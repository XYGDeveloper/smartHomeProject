//
//  ContactsViewController.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/12.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ContactsViewController.h"
#import "LoginManager.h"
#import "MyContactsModel.h"
#import "AddContactViewController.h"
#import "ContactsModel.h"
#import "Public+JGHUD.h"
//#import "ContactListViewController.h"

@interface ContactsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@property (nonatomic ,strong) NSArray *contacts;

@end

@implementation ContactsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"常用联系人";
     [self getContactData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
   
}


-(void)setupUI{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    _table = [[UITableView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 328) / 2.0, 64 + 30 , 328, 400) style:UITableViewStylePlain];
    _table.layer.cornerRadius = 8.0;
    _table.backgroundColor = [UIColor whiteColor];
    self.table.showsVerticalScrollIndicator = NO;
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.table];
    
    UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    commitBtn.backgroundColor = [UIColor colorWithHexString:@"#f2bb12"];
    [commitBtn setTitle:@"添加" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
}

-(void)getContactData{
    

//    MyContactsModel * model1 = [[MyContactsModel alloc] init];
//    model1.name = @"高圆圆";
//    model1.paperworkType = @"二代身份证";
//    model1.paperworkNum = @"10101010";
//    model1.sex = @"男";
//    model1.phone = @"10000000";
//    
//    MyContactsModel * model2 = [[MyContactsModel alloc] init];
//    model2.name = @"吴彦祖";
//    model2.paperworkType = @"二代身份证";
//    model2.paperworkNum = @"10101010";
//    model2.sex = @"男";
//    model2.phone = @"10000000";
//    
//    MyContactsModel * model3 = [[MyContactsModel alloc] init];
//    model3.name = @"张美腻";
//    model3.paperworkType = @"二代身份证";
//    model3.paperworkNum = @"10101010";
//    model3.sex = @"男";
//    model3.phone = @"10000000";
//    
//    _contacts = @[model1,model2,model3];
    
    NSString * appUserID = [LoginManager instance] .appUserID;
    [[LYZNetWorkEngine sharedInstance] getContactsListWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID limit:@"1000" pages:@"1" block:^(int event, id object) {
        GetContactsListResponse *contactsList = (GetContactsListResponse*)object;
        if (event == 1) {
            BaseContactsModel * baseContacts = contactsList.baseContacts;
            NSArray *arr = baseContacts.appContacts;
            NSMutableArray * tempArr = [NSMutableArray array];
            if (arr.count ) {
                for (ContactsModel * model in arr) {
                    MyContactsModel * myModel = [[MyContactsModel alloc] init];
                    myModel.name = model.name;
                    myModel.paperworkNum = model.paperworkNum;
                    [myModel resetPaperworkType:[model.paperworkType intValue]];
                    myModel.sex = model.sex;
                    myModel.phone = model.phone;
                    myModel.contactsID = model.contactsID;
                    [tempArr addObject:myModel];
                }
                _contacts = [NSArray arrayWithArray:tempArr];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.table reloadData];
                });
            }
        }else{
            [Public showJGHUDWhenError:self.view msg:@"请求联系人列表失败"];
        }
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iiicell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iicell"];
    }
    MyContactsModel * model = _contacts[indexPath.row];
        cell.textLabel.text = model.name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyContactsModel * model = self.contacts[indexPath.row];
    AddContactViewController * vc = [[AddContactViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -- Action Method

-(void)commitBtnClick:(id)sender{
    
    AddContactViewController * vc = [[AddContactViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
