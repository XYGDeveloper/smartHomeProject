//
//  AddContactViewController.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/12.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AddContactViewController.h"
#import "LoginManager.h"
#import "EditContactTableViewCell.h"
#import "Public+JGHUD.h"


#define kName @"姓名"
#define kType @"证件类型"
#define kNum @"证件号码" 
#define kSex @"性别"
#define kPhone @"手机号码"

@interface AddContactViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *table;

@property (nonatomic ,strong) NSArray *keyItems;

@property (nonatomic, strong) NSMutableDictionary *contactDic;

@property (nonatomic, strong) NSArray *paperWorkTypes;

@property (nonatomic, assign) BOOL isAdd;

@end

@implementation AddContactViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"新增联系人";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configData];
    [self setUpUI];
}


-(void)configData{
    _keyItems = @[kName,kType,kNum,kSex,kPhone];
    _paperWorkTypes = @[@"二代身份证",@"港澳通行证",@"台湾通行证",@"护照"];
    NSArray * valueArr = nil;
    if (self.model) {
        self.isAdd = NO;
        valueArr = @[@" ",@" ",@" ",@" ",@" "];
    }else{
        self.isAdd = YES;
        valueArr = @[@" ",@" ",@" ",@" ",@" "];
    }
    self.contactDic = [NSMutableDictionary dictionary];
    _contactDic = [NSMutableDictionary dictionaryWithObjects:valueArr forKeys:_keyItems];
}

-(void)setUpUI{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    _table = [[UITableView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 328) / 2.0, 64 + 40 , 328, kDefaultCellHeight * 5 - 3) style:UITableViewStylePlain];
    self.table.scrollEnabled = NO;
    _table.layer.cornerRadius = 8.0;
    _table.backgroundColor = [UIColor whiteColor];
    self.table.showsVerticalScrollIndicator = NO;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    commitBtn.backgroundColor = [UIColor colorWithHexString:@"#f2bb12"];
    if (self.model) {
        [commitBtn setTitle:@"确定修改" forState:UIControlStateNormal];
    }else{
        [commitBtn setTitle:@"确定添加" forState:UIControlStateNormal];
    }
    
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _keyItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EditContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iiicell"];
    if (!cell) {
        cell = [[EditContactTableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iicell"];
    }
    
    cell.ikey = _keyItems[indexPath.row];
    cell.ivalue = [_contactDic objectForKey:_keyItems[indexPath.row]];
    cell.cellEdited = ^(NSString * key,NSString *value){
        LYLog(@"key is -->%@,value is --->%@",key,value);
        [self refreshDataKey:key value:value];
    }; 
    if (indexPath.row == 1) {
        cell.canEdit = YES;
        cell.textFieldClick= ^(){
            [self jumpActionSheet];
        };
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kDefaultCellHeight;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 1) {
        [self jumpActionSheet];
    }
}


#pragma mark -- ActionSheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 4) {
        [actionSheet dismissWithClickedButtonIndex:4 animated:YES];
        return;
    }
    
    NSString *value = _paperWorkTypes[buttonIndex];
    [self refreshDataKey:@"证件类型" value:value];
}


#pragma mark --Action Method

-(void)jumpActionSheet{
    LYLog(@" 弹出ActionSheet");
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"二代身份证",@"港澳通行证",@"台湾通行证",@"护照", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

-(void)commitBtnClick:(id)sender{
    
    if (self.isAdd) {
        [self addContact];
    }else{
        [self updateContact];
    }
}

-(void)addContact{
    
    
  
    NSString *appUserId = [LoginManager instance].appUserID;
    NSString * name = [_contactDic objectForKey:kName];
    NSString * type = [_contactDic objectForKey:kType];
    NSString * num = [_contactDic objectForKey:kNum];
    NSString * sex = [_contactDic objectForKey:kSex];
    NSString * phone = [_contactDic objectForKey:kPhone];
    if ([name isEqualToString:@""]) {
        [Public showJGHUDWhenError:self.view msg:@"请输入入住人姓名"];
        return;
    }
    
    if ([num isEqualToString:@""]) {
        
        [Public showJGHUDWhenError:self.view msg:@"请输入证件号码"];
        return;
    }
    
    if ([phone isEqualToString:@""]) {
        
        [Public showJGHUDWhenError:self.view msg:@"请输入手机号码"];
        return;
        
    }
    
    if ([sex isEqualToString:@""]) {
        
        [Public showJGHUDWhenError:self.view msg:@"请输入性别"];
        return;
        
    }
    if(phone.length < 11 || phone.length > 11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
    
    JGProgressHUD *hud = [Public hudWhenRequest];
    
    [hud showInView:self.view animated:YES];
    [[LYZNetWorkEngine sharedInstance] createContactsWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserId name:name paperworkType:[NSNumber numberWithInt:[type intValue]] paperworkNum:num sex:sex phone:phone block:^(int event, id object) {
         [hud dismissAnimated:YES];
        if (event == 1){
            dispatch_async(dispatch_get_main_queue(), ^{
                JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"添加成功"];
                [hud showInView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud dismissAnimated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            });
        
        }else{
            
             [Public showJGHUDWhenError:self.view msg:@"添加失败"];
        }
    }];
}

-(void)updateContact{
    
    NSString *contactId = self.model.contactsID;
    NSString * name = [_contactDic objectForKey:kName];
    NSString * type = [_contactDic objectForKey:kType];
    NSString * num = [_contactDic objectForKey:kNum];
    NSString * sex = [_contactDic objectForKey:kSex];
    NSString * phone = [_contactDic objectForKey:kPhone];
    
    
    JGProgressHUD *hud = [Public hudWhenRequest];
    [hud showInView:self.view animated:YES];
    [[LYZNetWorkEngine sharedInstance] updateContactsWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType contactID: contactId name:name paperworkType:[NSNumber numberWithInt:[type intValue]] paperworkNum:num sex:sex phone:phone block:^(int event, id object) {
        [hud dismissAnimated:YES];
        if (event == 1){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"修改成功"];
                [hud showInView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud dismissAnimated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            });
            
        }else{
            [Public showJGHUDWhenError:self.view msg:@"修改失败"];
        }
    }];


}


-(void)refreshDataKey:(NSString *)key value:(NSString *)value{
    [_contactDic setObject:value forKey:key];
    [self.table reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
