//
//  EditControllerViewController.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "EditControllerViewController.h"
#import "ValuePickerView.h"
#import "Masonry.h"
#import "GCD.h"
#import "Public+JGHUD.h"
#import "IICommons.h"
@interface EditControllerViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNmae;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *carType;
@property (weak, nonatomic) IBOutlet UITextField *carNumber;

@property (nonatomic, strong) ValuePickerView *pickerView;

@property (nonatomic,strong) UIButton *deleButton;
@property (nonatomic,strong) UIButton *saveButton;

@end

@implementation EditControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LYZTheme_BackGroundColor;

    self.userNmae.text = self.name;
  
    self.phone.text = self.telephone;
   
    self.deleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_deleButton];
    self.deleButton.backgroundColor = [UIColor colorWithRed:204/255.0f green:172/255.0f blue:133/255.0f alpha:1.0f];
    [self.deleButton addTarget:self action:@selector(toEdit:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.deleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(0);
    }];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_saveButton];
    self.saveButton.backgroundColor =[UIColor colorWithRed:175/255.0f green:147/255.0f blue:115/255.0f alpha:1.0f];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(60);
        make.right.mas_equalTo(0);
    }];
    [self.saveButton addTarget:self action:@selector(toSave:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)toEdit:(UIButton *)button{

    [[LYZNetWorkEngine sharedInstance] deleteContact:VersionCode devicenum:DeviceNum fromtype:FromType contactID:_contactId block:^(int event, id object) {
        if (event == 1) {
            [GCDQueue executeInMainQueue:^{
                [Public showJGHUDWhenSuccess:self.view msg:@"删除入住人成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            
            [GCDQueue executeInMainQueue:^{
                [Public showJGHUDWhenError:self.view msg:@"删除失败！"];
            }];
        }
    }];
    
}


-(int)checkIsHaveNumAndLetter:(NSString*)password{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, password.length)];
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    if (tNumMatchCount == password.length) {
        //全部符合数字，表示沒有英文
        return 1;
        
    } else if (tLetterMatchCount == password.length) {
        //全部符合英文，表示沒有数字
        return 2;
    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return 3;
    } else {
        return 4;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
    
}


- (BOOL)isValidateMobile:(NSString *)mobile{
    //手机号以13、15、18开头，八个\d数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}



- (void)toSave:(UIButton *)button{
    
    
    
    if (self.userNmae.text.length == 0) {
          [Public showJGHUDWhenError:self.view msg:@"请输入姓名"];
        return;
        
    }
    
    if ([self checkIsHaveNumAndLetter:self.userNmae.text] == 1) {
        
        [Public showJGHUDWhenError:self.view msg:@"用户名不能为数字"];
        return;
        
    }
    
    
    if (self.userNmae.text.length > 20) {
        
        [Public showJGHUDWhenError:self.view msg:@"用户名输入不正确"];
        return;
        
    }
    
    
    if (self.phone.text.length == 0) {
        
        [Public showJGHUDWhenError:self.view msg:@"手机号不能为空"];
        return;
        
    }
    if(self.phone.text.length < 11 || self.phone.text.length > 11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
    
    [[LYZNetWorkEngine sharedInstance] updateContactsWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType contactID:_contactId name:self.userNmae.text paperworkType:@1  paperworkNum:@"" sex:@"男" phone:self.phone.text block:^(int event, id object) {
        if (event == 1) {
            [GCDQueue executeInMainQueue:^{
                [Public showJGHUDWhenSuccess:self.view msg:@"修改入住人成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        }else{
            
            [Public showJGHUDWhenError:self.view msg:object];
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
