//
//  ContactViewController.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "ContactViewController.h"
#import "Masonry.h"
#import "ContactTableViewCell.h"
#import "MJRefresh.h"
#import "LoginManager.h"
#import "AddNewContactViewController.h"
#import "GCD.h"
#import "LYZContactsModel.h"
#import "ContactsModel.h"
#import "BaseContactsModel.h"
#import "MJExtension.h"
#import "Public+JGHUD.h"
#import "AddNewContactViewController.h"
#import "EditControllerViewController.h"
#import "EmptyManager.h"
#import <Reachability.h>
@interface ContactViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *contactTableView;

@property (nonatomic,strong)NSArray *contactArray;

@property (nonatomic,strong)UIButton *compleleButton;

@property (nonatomic,assign)int page;

@property (nonatomic,strong)Reachability *reach;

@property (nonatomic,assign)int limit;

@end

@implementation ContactViewController


- (NSArray *)contactArray
{

    if (!_contactArray) {
        
        _contactArray = [NSArray array];
    }
    
    return _contactArray;
    

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.contactTableView.mj_header beginRefreshing];
    
}

- (void)addContacts:(UIBarButtonItem *)addContacts{

    AddNewContactViewController *newContact = [AddNewContactViewController new];
    newContact.title = @"添加联系人";
    newContact.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newContact animated:YES];
    
}

- (void)handleData:(int)limit{

    NSString *appUserId = [LoginManager instance].appUserID;
    
    [[LYZNetWorkEngine sharedInstance] getContactsListWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserId limit:[NSString stringWithFormat:@"%d",limit] pages:[NSString stringWithFormat:@"%d",self.page] block:^(int event, id object) {
        [self.contactTableView.mj_header endRefreshing];
        [self.contactTableView.mj_footer endRefreshing];

            if (event == 1) {
                [self.contactTableView.mj_header endRefreshing];
                [self.contactTableView.mj_footer endRefreshing];

                [[EmptyManager sharedManager] removeEmptyFromView:self.view];
                GetContactsListResponse *response = (GetContactsListResponse *)object;
                BaseContactsModel *baseContactModel = response.baseContacts;
                NSArray *temp = baseContactModel.appContacts;
                
                NSMutableArray * tempMutArr = [NSMutableArray array];
                for (ContactsModel *model in temp) {
                    LYZContactsModel *lyzModel = [[LYZContactsModel alloc] init];
                    lyzModel.contactsID = model.contactsID;
                    lyzModel.name = model.name;
                    lyzModel.paperworkNum = model.paperworkNum;
                    lyzModel.paperworkType = model.paperworkType;
                    lyzModel.sex = model.sex;
                    lyzModel.phone = model.phone;
                    //以下判断是否已经填写了
                    [tempMutArr addObject:lyzModel];
                }
                self.contactArray = [NSArray arrayWithArray:tempMutArr];
                
                NSLog(@"---------%@",self.contactArray);
                
                [self.contactTableView reloadData];

            }else if (event == 2)
            {
                
                [self.contactTableView.mj_header endRefreshing];
                [self.contactTableView.mj_footer endRefreshing];

                [[EmptyManager sharedManager] showEmptyOnView:self.view withImage:[UIImage imageNamed:@"no_live"] explain:@"暂时没有添加入住人" operationText:@"去添加入住人" operationBlock:^{
                    AddNewContactViewController *newContact = [AddNewContactViewController new];
                    newContact.title = @"添加联系人";
                    newContact.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:newContact animated:YES];
                    
                }];
            
            }else{
            
                [self.contactTableView.mj_header endRefreshing];
                [self.contactTableView.mj_footer endRefreshing];

            }
    }];
    
    limit += 10;
    
    self.limit = limit;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"addContact"] style:UIBarButtonItemStylePlain target:self action:@selector(addContacts:)];
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.contactTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.contactTableView.delegate  = self;
    self.contactTableView.dataSource  = self;
    self.contactTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contactTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_contactTableView];
    [self.contactTableView registerClass:[ContactTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ContactTableViewCell class])];
    WEAKSELF;
    __weak UITableView *weakTable = self.contactTableView;
    weakTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf handleData:10];
        
    }];
    
    _contactTableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{

        [self handleData:self.limit];

    }];
    
    self.reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [self.reach startNotifier];
    
}


- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
        
        [self.contactTableView.mj_header endRefreshing];
        [[EmptyManager sharedManager] showEmptyOnView:self.view withImage:[UIImage imageNamed:@"network"] explain:@"网络状态异常,可能是你的网络断开" operationText:@"" operationBlock:^{
            
        }];
        
        return;
        
        
    }else{
        
        [self.contactTableView.mj_header endRefreshing];
        
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.contactArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 82;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ContactTableViewCell class])];
    
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    LYZContactsModel *model = [self.contactArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.name;
    cell.telephoneLabel.text = model.phone;
    
    cell.isEdit = ^(){
    
//        EditControllerViewController *edit = [EditControllerViewController new];
//        edit.title =@"编辑入住人";
//        edit.contactId = model.contactsID;
//        edit.name = model.name;
//        edit.telephone = model.phone;
//        [self.navigationController pushViewController:edit animated:YES];
        
       
        AddNewContactViewController *vc = [[AddNewContactViewController alloc] init];
        vc.fromContactsModel = model;
        vc.isFromChooseList = YES;
        WEAKSELF;
        vc.callbackBlock = ^(){
            [weakSelf.contactTableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:vc animated:YES];
    };
  
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    LYZContactsModel *model = [self.contactArray objectAtIndex:indexPath.row];
//    EditControllerViewController *edit = [EditControllerViewController new];
//    edit.title =@"编辑入住人";
//    edit.contactId = model.contactsID;
//    edit.name = model.name;
//    edit.telephone = model.phone;
//    [self.navigationController pushViewController:edit animated:YES];
    AddNewContactViewController *vc = [[AddNewContactViewController alloc] init];
    vc.fromContactsModel = model;
    vc.isFromChooseList = YES;
    WEAKSELF;
    vc.callbackBlock = ^(){
        [weakSelf.contactTableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}




- (void)FinishAction:(UIButton *)button{

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
