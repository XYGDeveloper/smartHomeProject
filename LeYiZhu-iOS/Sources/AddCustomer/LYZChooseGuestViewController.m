//
//  AddCustomerController.m
//  LeYiZhu-iOS
//
//  Created by mac on 16/11/23.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "LYZChooseGuestViewController.h"
#import "NewContactView.h"
#import "CustomerContactModel.h"
#import "UIImage+YYAdd.h"
#import "Public+JGHUD.h"
#import "LoginManager.h"
#import "AddNewContactViewController.h"
#import "GCD.h"
#import "BaseContactsModel.h"
#import "SelectContactCell.h"
#import "ColorSpaceCell.h"
#import "ContactsModel.h"
#import "LYZContactsModel.h"

#define NoContactImgWidth 156

@interface LYZChooseGuestViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic , strong) NSArray<LYZContactsModel*> *contactMutArray;
@property (nonatomic , weak) NewContactView *contactView;
@property (nonatomic, strong) UIImageView *noContactImgView;
@property (nonatomic, strong) UITableView *contactListTabView;

@end



@implementation LYZChooseGuestViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.bounds = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.title = @"选择入住人";
    [self setNav];
    [self configTableView];
    [self setUpBtn];
    [self setUpDataSoruce];
}

-(void)setNav{
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.bounds = CGRectMake(0, 0, 60, 30);
    [rightButton setImage:[UIImage imageNamed:@"nav_icon_add_copy"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addCustomer:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = - 20;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
}



-(UIImageView *)noContactImgView{
    if (!_noContactImgView) {
        _noContactImgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - NoContactImgWidth)/2.0, (SCREEN_HEIGHT - NoContactImgWidth -64- 60 -20)/2.0 , NoContactImgWidth, NoContactImgWidth)];
        _noContactImgView.image = [UIImage imageNamed:@"icon_noting"];
    }
    return _noContactImgView;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}


#pragma mark -- 获取数据源 并且生成视图
- (void)setUpDataSoruce
{
    if (!_adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (_adapters.count > 0) {
        [_adapters removeAllObjects];
    }
    NSString *appUserId = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance] getContactsListWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserId limit:nil pages:nil block:^(int event, id object) {
        if (event == 1) {
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
                //以下判断是否已经填写了，填写用户标记为不可选中
                for (LYZContactsModel *imodel in self.filledContacts) {
                    if ([imodel.contactsID isEqualToString:model.contactsID]) {
                        lyzModel.unselectable = YES;
                    }
                }
                [tempMutArr addObject:lyzModel];
            }
            self.contactMutArray = [NSArray arrayWithArray:tempMutArr];
            
            [GCDQueue executeInMainQueue:^{
                if (self.noContactImgView.superview) {
                    [self.noContactImgView removeFromSuperview];
                }
                if ( self.contactMutArray.count > 0) {
                    [self.adapters addObject:[self lineType:kSpace height:25.f]];
                    for (int i = 0; i < self.contactMutArray.count; i++) {
                        [self.adapters addObject:[SelectContactCell dataAdapterWithData:[self.contactMutArray objectAtIndex:i] cellHeight:SelectContactCell.cellHeight]];
                        if (i == self.contactMutArray.count - 1) {
                            break;
                        }
                        [self.adapters addObject:[self lineType:kShortType height:0.5]];
                    }
                    [self.contactListTabView reloadData];
                }
            }];
        }else{
           // 这里 考虑到接口修改对安卓影响大：只要是errorcode 不为1 就统一出现没有联系人
//            if (self.contactListTabView.superview) {
//                [self.contactListTabView removeFromSuperview];
//            }
            [self.view addSubview:self.noContactImgView];
            [self.contactListTabView reloadData];
        }
    }];
}

-(void)configTableView{
    
    self.contactListTabView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 64 - 60)];
    self.contactListTabView.delegate        = self;
    self.contactListTabView.dataSource      = self;
    self.contactListTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contactListTabView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.contactListTabView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contactListTabView];
    //注册cell
    [ColorSpaceCell registerToTableView:self.contactListTabView];
    [SelectContactCell registerToTableView:self.contactListTabView];
}

//添加下面的增加用户按钮
- (void)setUpBtn{
    
    UIButton *compeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    compeleteBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 64 -60, SCREEN_WIDTH, 60);
    [compeleteBtn setBackgroundColor:LYZTheme_paleBrown];
    [compeleteBtn setTitle:@"完成" forState:UIControlStateNormal];
    [compeleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    compeleteBtn.titleLabel.font = [UIFont  fontWithName:@"PingFangSC-Regular" size:20];
    [compeleteBtn addTarget:self action:@selector(chooseGuestCompelete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:compeleteBtn atIndex:1001];
    
}

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    
    if (type == kSpace) {
        
        return [ColorSpaceCell dataAdapterWithData:nil cellHeight:20.f];
        
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :[UIColor colorWithHexString:@"E8E8E8"]} cellHeight:0.5f];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" : [UIColor colorWithHexString:@"E8E8E8"], @"leftGap" : @(25.f)} cellHeight:0.5f];
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = _adapters[indexPath.row];
    CustomCell      *cell    = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter         = adapter;
    cell.data                = adapter.data;
    cell.indexPath           = indexPath;
    cell.tableView           = tableView;
    cell.delegate            = self;
    [cell loadContent];
    if ([cell isKindOfClass:[SelectContactCell class]]) {
        SelectContactCell *contactCell = (SelectContactCell *)cell;
        contactCell.selectBtnHandler = ^(id data){
           
            LYZContactsModel *selectedModel = (LYZContactsModel *)data;
            //选中一个后全部重置成未选中
            for (LYZContactsModel *model in self.contactMutArray) {
                model.isSelect = NO;
            }
            selectedModel.isSelect = YES;
            [self.contactListTabView reloadData];
            //分未选中和取消选中两种情况
//            if (!selectedModel.isSelect) {
//                 NSInteger selectCount = 0;
//                selectedModel.isSelect = !selectedModel.isSelect;
//                for (LYZContactsModel *model in self.contactMutArray) {
//                    if (model.isSelect == YES) {
//                        selectCount ++;
//                    }
//                }
//                if (selectCount > self.maxCount) {
//                    selectedModel.isSelect = !selectedModel.isSelect;
//                    NSString *msg = [NSString stringWithFormat:@"您选择了%li间房，所以只能选择%li人",(long)self.maxCount,self.maxCount];
//                    [Public showJGHUDWhenError:self.view msg:msg];
//                    [self.contactListTabView reloadData];
//                    return ;
//                }
//                [self.contactListTabView reloadData];
//
//            }else{
//                selectedModel.isSelect = !selectedModel.isSelect;
//                [self.contactListTabView reloadData];
//            }
            
        };
        contactCell.editBtnHandler = ^(id data){
            LYZContactsModel *selectedModel = (LYZContactsModel *)data;
            AddNewContactViewController *vc = [[AddNewContactViewController alloc] init];
            vc.fromContactsModel = selectedModel;
            vc.isFromChooseList = YES;
            vc.callbackBlock = ^(){
                [self setUpDataSoruce];
            };
            [self.navigationController pushViewController:vc animated:YES];
        };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}


#pragma mark -- 完成按钮点击事件
- (void)rightButtonClick:(UIButton*)sender
{
    
}

//新增联系人
- (void)addCustomer:(UIButton*)sender
{
    AddNewContactViewController *vc = [[AddNewContactViewController alloc] init];
    WEAKSELF;
    vc.callbackBlock = ^(){
        [weakSelf setUpDataSoruce];
    };
    vc.callbackToCommitBlock =^(id date){
        [weakSelf setUpDataSoruce];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)chooseGuestCompelete:(UIButton *)sender{
    LYZContactsModel *selectedmodel;
    for (LYZContactsModel *model in self.contactMutArray) {
        if (model.isSelect == YES) {
            selectedmodel = model;
            break;
        }
    }
   
    if (selectedmodel) {
        
        if (self.completeBlock) {
            self.completeBlock(selectedmodel);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
