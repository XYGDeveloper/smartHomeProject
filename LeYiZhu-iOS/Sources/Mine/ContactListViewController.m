//
//  ContactListViewController.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/17.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "ContactListViewController.h"
#import "Masonry.h"
#import "LoginManager.h"
#import "LYZNetWorkEngine.h"
#import "MyContactsModel.h"
#import "MJExtension.h"
@interface ContactListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *contactListTableView;
@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)NSMutableArray *contactsArray;

@end

@implementation ContactListViewController

static  NSString *reuseIdentity = @"reuseIdentity";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor grayColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewUI];
    [self viewDidLayou];
    [self.contactListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentity];
    [self.contactListTableView reloadData];
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)contactsArray
{
    if (_contactsArray != nil) {
        _contactsArray = [NSMutableArray array];
    }
    return _contactsArray;
    
}

- (UITableView *)contactListTableView
{
    
    if (!_contactListTableView) {
        _contactListTableView = [[UITableView alloc]init];
        _contactListTableView.delegate = self;
        _contactListTableView.dataSource = self;
    }

    return _contactListTableView;

}

- (UIButton *)addButton
{

    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = [UIColor orangeColor];
        [_addButton setTitle:@"添加" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return _addButton;
}

- (void)initViewUI{

    
    NSString * appUserID = [LoginManager instance] .appUserID;
    [[LYZNetWorkEngine sharedInstance] getContactsListWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID limit:@"1000" pages:@"1" block:^(int event, id object) {
        self.contactsArray = [MyContactsModel mj_keyValuesArrayWithObjectArray:object];
    }];

}

- (void)viewDidLayou
{
    [self.view addSubview:_contactListTableView];
    [self.view addSubview:_addButton];
    [self.contactListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(40);
        make.bottom.mas_equalTo(SCREEN_HEIGHT/3 *2);
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
}

#pragma mark-代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    MyContactsModel *model = [self.contactsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
