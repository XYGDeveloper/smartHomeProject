//
//  AddNewContactViewController.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/17.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "AddNewContactViewController.h"
#import "NewContactView.h"
#import "LYZContactsModel.h"
#import "LoginManager.h"
#import "Public+JGHUD.h"
#import "GCD.h"
#import "ColorSpaceCell.h"
#import "CustomCell.h"
#import "AddContactNameCell.h"
#import "AddContactPhoneCell.h"
#import "CarTypeCell.h"
#import "CarNumberTableViewCell.h"
#import <ContactsUI/ContactsUI.h>
#import "EdgeInsertLabel.h"

@interface AddNewContactViewController ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate,CNContactPickerDelegate>

//@property (nonatomic, strong) NewContactView *contactView;

@property (nonatomic, strong) NSNumber *selectedPaperworkType;

@property (nonatomic, strong) UITableView *contactListTabView;

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong)LYZContactsModel *contactModel;

@end

@implementation AddNewContactViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    if (self.fromContactsModel) {
        self.title = @"编辑入住人";
    }else{
        self.title = @"新增入住人";
    }
    [self configTableView];
    [self createDefaultDatas];
    [self configDeleteBtn];
    [self setRightNav];
    [self setUpDataSoruce];
}

#pragma mark -- UI Config

-(void)setRightNav{
    if (self.fromContactsModel) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        rightBtn.bounds = CGRectMake(0, 0, 60, 30);
        [rightBtn setTitle:@"清空" forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = - 10;
        self.navigationItem.rightBarButtonItems =@[spaceItem,rightItem];
    }
}

-(void)configDeleteBtn{
    if (self.fromContactsModel) {
        if (_isFromChooseList) {
            UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            deleteBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 60 -64, SCREEN_WIDTH/2.0, 60);
            [deleteBtn setBackgroundColor:[UIColor colorWithHexString:@"#cdac84"]];
            [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
            [deleteBtn addTarget:self action:@selector(deleteCustomer:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:deleteBtn];
            
            UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            saveBtn.frame = CGRectMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - 60 -64, SCREEN_WIDTH/2.0, 60);
            [saveBtn setBackgroundColor:[UIColor colorWithHexString:@"#af9372"]];
            [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            [saveBtn addTarget:self action:@selector(updateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:saveBtn];
        }else{
            UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            saveBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 60 -64, SCREEN_WIDTH, 60);
            [saveBtn setBackgroundColor:LYZTheme_paleBrown];
            [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
            [saveBtn addTarget:self action:@selector(fromOrderCommitSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:saveBtn];
        }
    }else{
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 60 -64, SCREEN_WIDTH, 60);
        [saveBtn setBackgroundColor:LYZTheme_paleBrown];
        [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveBtn];
    }
}
#pragma mark --Data Config

-(void)createDefaultDatas{
    if (self.fromContactsModel) {
        LYZContactsModel *contacts = [[LYZContactsModel alloc] init];
        contacts.name = self.fromContactsModel.name;
        contacts.phone = self.fromContactsModel.phone;
        contacts.paperworkNum = self.fromContactsModel.paperworkNum;
        contacts.contactsID = self.fromContactsModel.contactsID;
        self.contactModel = contacts;
    }else{
        LYZContactsModel *emptyContact = [[LYZContactsModel alloc] init];
        emptyContact.name = @"";
        emptyContact.phone = @"";
        emptyContact.paperworkNum = @"";
        self.contactModel = emptyContact;
    }
}

- (void)setUpDataSoruce
{
    
    if (!_adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (_adapters.count > 0) {
        [_adapters removeAllObjects];
    }
    [_adapters addObject:[AddContactNameCell dataAdapterWithData:self.contactModel cellHeight:AddContactNameCell.cellHeight]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    [_adapters addObject:[AddContactPhoneCell dataAdapterWithData:self.contactModel cellHeight:[AddContactPhoneCell cellHeightWithData:self.contactModel]]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    [_adapters addObject:[CarTypeCell dataAdapterWithData:self.contactModel cellHeight:CarTypeCell.cellHeight]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    [_adapters addObject:[CarNumberTableViewCell dataAdapterWithData:self.contactModel cellHeight:[CarNumberTableViewCell cellHeightWithData:self.contactModel]]];
    [GCDQueue executeInMainQueue:^{
        [self.contactListTabView reloadData];
    }];
    
}

-(void)configTableView{
    
    self.contactListTabView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 64 - 60)];
    self.contactListTabView.delegate        = self;
    self.contactListTabView.dataSource      = self;
    self.contactListTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contactListTabView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.contactListTabView.backgroundColor = [UIColor clearColor];
    self.contactListTabView.tableFooterView = self.footView;
    [self.view addSubview:self.contactListTabView];
    //注册cell
    [ColorSpaceCell registerToTableView:self.contactListTabView];
    [AddContactPhoneCell registerToTableView:self.contactListTabView];
    [AddContactNameCell registerToTableView:self.contactListTabView];
    [CarTypeCell registerToTableView:self.contactListTabView];
    [CarNumberTableViewCell registerToTableView:self.contactListTabView];
}

-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
        _footView.backgroundColor = [UIColor clearColor];
//        UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, SCREEN_WIDTH - 2*DefaultLeftSpace, 60)];
//        notice.numberOfLines = 0;
//        notice.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
//        notice.textColor = LYZTheme_warmGreyFontColor;
//        notice.text = @"温馨提示：请正确填写入住人信息，当实际入住人与订单填写入住人不一致时，将无法顺利入住";
//        [_footView addSubview:notice];
        
        EdgeInsertLabel *serviceLabel = [[EdgeInsertLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
        serviceLabel.center = _footView.center;
        serviceLabel.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
//        serviceLabel.textAlignment = NSTextAlignmentCenter;
        serviceLabel.numberOfLines = 0;
        NSString *title = @"温馨提示";
        NSString *phone = @"请正确填写入住人信息，当实际入住人与订单填写入住人不一致时，将无法顺利入住";
        NSString *str = [NSString stringWithFormat:@"%@\n%@",title,phone];
      
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 3;// 字体的行间距
        NSDictionary *attriBute = [NSDictionary dictionaryWithObjectsAndKeys:paragraphStyle,NSParagraphStyleAttributeName, nil];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attriBute];
        
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setAlignment:NSTextAlignmentCenter];
        paragraphStyle1.lineSpacing = 5;
        NSDictionary *attriBute1 = [NSDictionary dictionaryWithObjectsAndKeys:LYZTheme_BrownishGreyFontColor,NSForegroundColorAttributeName, [UIFont fontWithName:LYZTheme_Font_Regular size:18],NSFontAttributeName,paragraphStyle1,NSParagraphStyleAttributeName,nil];
        [attriStr addAttributes:attriBute1 range:NSMakeRange(0, title.length)];
        NSDictionary *attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_warmGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:17]};
        [attriStr addAttributes:attriBute2 range:NSMakeRange(title.length ,str.length - title.length)];
        serviceLabel.attributedText = attriStr;
        
        //加虚线
        CAShapeLayer *border = [CAShapeLayer layer];
        border.strokeColor = LYZTheme_warmGreyFontColor.CGColor;
        border.fillColor = nil;
        border.path = [UIBezierPath bezierPathWithRect:serviceLabel.bounds].CGPath;
        border.frame = serviceLabel.bounds;
        border.lineWidth = 1.f;
        //        border.lineCap = @"square";
        border.lineCap = @"butt";
        border.lineDashPattern = @[@5, @3];
        [serviceLabel.layer addSublayer:border];
        [_footView addSubview:serviceLabel];
    }
    return _footView;
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
    cell.controller          = self;
    [cell loadContent];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 完成按钮点击事件
- (void)rightButtonClick:(UIButton*)sender
{
    NSString *name = self.contactModel.name;
    NSString *phone = self.contactModel.phone;
    NSString *carNum = self.contactModel.paperworkNum;

    if (name && ![name isEqualToString:@""] && phone && ![phone isEqualToString:@""]) {
        NSString *appUserID = [LoginManager instance].appUserID;
        if (! [IICommons valiMobile:phone]) {
            [Public showJGHUDWhenError:self.view msg:@"请输入正确的手机号码"];
            return;
        }
        if (name.length > 20) {
            [Public showJGHUDWhenError:self.view msg:@"用户名输入不正确"];
            return;
        }
        
        if (![IICommons validateIDCardNumber:carNum] && carNum.length > 0) {
            [Public showJGHUDWhenError:[UIApplication sharedApplication].delegate.window msg:@"证件格式不正确！"];
            return;
            
        }
        if (self.contactModel) {
            //修改
            [[LYZNetWorkEngine sharedInstance] updateContactsWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType contactID:self.contactModel.contactsID name:name paperworkType: @1 paperworkNum:carNum sex:@"男" phone:phone block:^(int event, id object) {
                if (event == 1) {
                    [GCDQueue executeInMainQueue:^{
                        [Public showJGHUDWhenSuccess:self.view msg:@"修改入住人成功"];
                        [self performSelector:@selector(backTo) withObject:nil afterDelay:1.5];
                    }];
                    
                }else{
                    [Public showJGHUDWhenError:self.view msg:object];
                }
            }];
        }else{
            //添加
            
            NSLog(@"%@\n %@\n %@",name,phone,carNum);
            
            [[LYZNetWorkEngine sharedInstance] createContactsWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID name:name paperworkType:@1 paperworkNum:carNum sex:@"男" phone:phone block:^(int event, id object) {
                if (event == 1) {
                    [GCDQueue executeInMainQueue:^{
                        [Public showJGHUDWhenSuccess:self.view msg:@"添加入住人成功"];
                        [self performSelector:@selector(backTo) withObject:nil afterDelay:1.5];
                    }];
                }else{
                    [Public showJGHUDWhenError:self.view msg:object];
                }
            }];
        }
    }else{
             [Public showJGHUDWhenError:self.view msg:@"请填写详细联系人信息！"];
    }
}

-(void)updateBtnClick:(UIButton *)sender{
    NSString *name = self.contactModel.name;
    NSString *phone = self.contactModel.phone;
    NSString *carNum = self.contactModel.paperworkNum;
//    NSString *appUserID = [LoginManager instance].appUserID;
    if (name && ![name isEqualToString:@""]  && phone && ![phone isEqualToString:@""]) {
        if (! [IICommons valiMobile:phone]) {
            [Public showJGHUDWhenError:self.view msg:@"请输入正确的手机号码"];
            return;
        }
        if (name.length > 20) {
            [Public showJGHUDWhenError:self.view msg:@"用户名输入不正确"];
            return;
        }
        
        if (![IICommons validateIDCardNumber:carNum] && carNum.length > 0) {
            [Public showJGHUDWhenError:[UIApplication sharedApplication].delegate.window msg:@"证件格式不正确！"];
            return;
            
        }
        //修改
        [[LYZNetWorkEngine sharedInstance] updateContactsWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType contactID:self.contactModel.contactsID name:name paperworkType: @1 paperworkNum:carNum sex:@"男" phone:phone block:^(int event, id object) {
            if (event == 1) {
                [GCDQueue executeInMainQueue:^{
                    [Public showJGHUDWhenSuccess:self.view msg:@"修改入住人成功"];
                    [self performSelector:@selector(backTo) withObject:nil afterDelay:1.5];
                }];
            }else{
                [Public showJGHUDWhenError:self.view msg:object];
            }
        }];
        
    }else{
        [Public showJGHUDWhenError:self.view msg:@"请填写详细联系人信息！"];
    }
}

-(void)saveBtnClick:(UIButton *)sender{
    NSString *name = self.contactModel.name;
    NSString *phone = self.contactModel.phone;
    NSString *carNum = self.contactModel.paperworkNum;
    NSString *appUserID = [LoginManager instance].appUserID;
    LYZContactsModel *imodel = [[LYZContactsModel alloc] init];
    imodel.name = name;
    imodel.phone = phone;
    if ([name isEqualToString:@""]) {
        
        [Public showJGHUDWhenError:self.view msg:@"请输入入住人姓名"];
        return;
    }
    if ([appUserID isEqualToString:@""]) {
        
        [Public showJGHUDWhenError:self.view msg:@"请输入证件号码"];
        return;
    }
    
    if ([phone isEqualToString:@""]) {
        
        [Public showJGHUDWhenError:self.view msg:@"请输入手机号码"];
        return;
        
    }
    
    if (name && ![name isEqualToString:@""]  && phone && ![phone isEqualToString:@""]) {
        //添加
        if (! [IICommons valiMobile:phone]) {
            [Public showJGHUDWhenError:self.view msg:@"请输入正确的手机号码"];
            return;
        }
        if (name.length > 20) {
            [Public showJGHUDWhenError:self.view msg:@"用户名输入不正确"];
            return;
        }
        
        if (![IICommons validateIDCardNumber:carNum] && carNum.length > 0) {
            [Public showJGHUDWhenError:[UIApplication sharedApplication].delegate.window msg:@"证件格式不正确！"];
            return;
            
        }
        
        if (appUserID) {
            [[LYZNetWorkEngine sharedInstance] createContactsWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID name:name paperworkType:@1 paperworkNum:carNum sex:@"男" phone:phone block:^(int event, id object) {
                if (event == 1) {
                    [GCDQueue executeInMainQueue:^{
                        [Public showJGHUDWhenSuccess:self.view msg:@"添加入住人成功"];
                        if (self.callbackToCommitBlock) {
                            self.callbackToCommitBlock(imodel);
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    
                }else{
                    [Public showJGHUDWhenError:self.view msg:object];
                }
            }];
        }else{
            [Public showJGHUDWhenSuccess:self.view msg:@"添加入住人成功"];
            if (self.callbackToCommitBlock) {
                self.callbackToCommitBlock(imodel);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [Public showJGHUDWhenError:self.view msg:@"请填写详细联系人信息！"];
    }
}

-(void)deleteCustomer:(id)sender{
    [[LYZNetWorkEngine sharedInstance] deleteContact:VersionCode devicenum:DeviceNum fromtype:FromType contactID:self.contactModel.contactsID block:^(int event, id object) {
        if (event == 1) {
            [GCDQueue executeInMainQueue:^{
                [Public showJGHUDWhenSuccess:self.view msg:@"删除入住人成功"];
                [self performSelector:@selector(backTo) withObject:nil afterDelay:1.5];
            }];
        }else{
            [GCDQueue executeInMainQueue:^{
                [Public showJGHUDWhenError:self.view msg:@"删除失败！"];
            }];
        }
    }];
}

-(void)fromOrderCommitSaveBtn:(UIButton *)btn{
    
    NSString *name = self.contactModel.name;
    NSString *phone = self.contactModel.phone;
    NSNumber *paperType = self.selectedPaperworkType;
    NSString *carNum = self.contactModel.paperworkNum;
    LYZContactsModel *imodel = [[LYZContactsModel alloc] init];
    imodel.name = name;
    imodel.phone = phone;
    imodel.paperworkType = paperType;
    NSString *appUserID = [LoginManager instance].appUserID;
    
    if (name && ![name isEqualToString:@""]  && phone && ![phone isEqualToString:@""]) {
        if (! [IICommons valiMobile:phone]) {
            [Public showJGHUDWhenError:self.view msg:@"请输入正确的手机号码"];
            return;
        }
        if (name.length > 20) {
            [Public showJGHUDWhenError:self.view msg:@"用户名输入不正确"];
            return;
        }
        //添加
        [[LYZNetWorkEngine sharedInstance] createContactsWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID name:name paperworkType:@1 paperworkNum:carNum sex:@"男" phone:phone block:^(int event, id object) {
                [GCDQueue executeInMainQueue:^{
                    if (self.callbackToCommitBlock) {
                        self.callbackToCommitBlock(imodel);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }];
        }];
        
    }else{
        [Public showJGHUDWhenError:self.view msg:@"请填写详细联系人信息！"];
    }
}


-(void)backTo{
    if (self.callbackBlock) {
        self.callbackBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clearBtnClick:(id)sender{
    if (self.contactModel) {
        self.contactModel.name = @"";
        self.contactModel.phone = @"";
        self.contactModel.paperworkNum = @"";
        [self setUpDataSoruce];
    }
}

-(void)endEditPhoneNum{
    [self setUpDataSoruce ];
}


-(void)addLocalContact{
    [self chooseLocalContact];
}


-(void)chooseLocalContact{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusNotDetermined:
            NSLog(@"用户还没有决定是否可以访问");
            [self requestDetermain];
            break;
        case CNAuthorizationStatusDenied:
            NSLog(@"不可以访问联系人数据库");
            break;
        case CNAuthorizationStatusAuthorized:
            NSLog(@"可以访问联系人数据库");
            [self toMyLocalContacts];
            break;
        case CNAuthorizationStatusRestricted:
            NSLog(@"这个状态说明应用不仅不能够访问联系人数据，并且用户也不能在设置中改变这个状态");
            break;
        default:
            break;
    }
}

//请求授权提示框
-(void)requestDetermain{
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //获取联系人
            [self toMyLocalContacts];
        }
    }];
}

-(void)toMyLocalContacts{
    CNContactPickerViewController *contactVC = [CNContactPickerViewController new];
    contactVC.delegate = self;
    [self presentViewController:contactVC animated:YES completion:^{
        
    }];
}

#pragma mark - CNContactViewControllerDelegate代理

//选择一个联系人的时候调用
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    //1.姓名
    NSLog(@"%@-%@",contact.givenName,contact.familyName);
    //2.获取电话   --->泛型，会在遍历数组帮很大忙。
    for (CNLabeledValue *labelValue in contact.phoneNumbers) {
        NSLog(@"电话标签: %@",labelValue.label);
        CNPhoneNumber *phoneNumber = labelValue.value;
        NSLog(@"电话号码: %@",phoneNumber.stringValue);
        self.contactModel.phone = [phoneNumber.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [self setUpDataSoruce];
    }
    
}

//取消选择联系人的时候调用
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
    
    
}

@end
