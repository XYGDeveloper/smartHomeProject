//
//  UpdateUserNameController.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 2017/11/27.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "UpdateUserNameController.h"
#import "UIViewController+BarButton.h"
#import "Public+JGHUD.h"
#import "GCD.h"

@interface UpdateUserNameController ()

@property (nonatomic, strong) UITextField *nameTF;

@end

@implementation UpdateUserNameController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑昵称";
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    [self setNavbar];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 0.5)];
    line1.backgroundColor = kLineColor;
    [self.view addSubview:line1];
    
    UIView *whiteBg = [[UIView alloc] initWithFrame:CGRectMake(0, line1.bottom, SCREEN_WIDTH, 45)];
    whiteBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteBg];
    
    self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(10, line1.bottom, SCREEN_WIDTH - 20, whiteBg.height)];
    self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTF.placeholder = @"输入新的昵称";
    [self.view addSubview:self.nameTF];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, whiteBg.bottom, SCREEN_WIDTH, 0.5)];
    line2.backgroundColor = kLineColor;
    [self.view addSubview:line2];
    
}

-(void)setNavbar{
    [self addRightBarButtonItemWithTitle:@"完成" action:@selector(confirm:)];
}
-(void)confirm:(id)sender{
    NSString *nickName = self.nameTF.text;
    if (!nickName || [nickName isEqualToString:@""]) {
        [Public showJGHUDWhenError:self.view msg:@"输入正确格式昵称"];
        return;
    }
    
    [[LYZNetWorkEngine sharedInstance] updateUserInfo:nickName facepath:nil block:^(int event, id object) {
        if (event == 1) {
            [Public showJGHUDWhenSuccess:self.view msg:@"修改成功"];
            self.updateNamePop(nickName);
            [GCDQueue executeInMainQueue:^{
                [self.navigationController popViewControllerAnimated:YES];
            } afterDelaySecs:0.8];
            
        }else{
            [Public showJGHUDWhenError:self.view msg:@"修改失败，请重新尝试"];
        }
    }];
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
