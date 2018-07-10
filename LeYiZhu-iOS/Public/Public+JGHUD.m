//
//  Public+JGHUD.m
//  BeiKePark
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Public+JGHUD.h"
#import "JGProgressHUDSuccessIndicatorView.h"
#import "JGProgressHUDErrorIndicatorView.h"

@implementation Public (JGHUD)

+ (JGProgressHUD*)hudWhenRequest
{
    JGProgressHUD *hud =  [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud.textLabel.text = @"正在请求...";
//    hud.tapOutsideBlock = ^(JGProgressHUD *HUD){
//        [HUD dismissAnimated:YES];
//    };
    return hud;
}

+ (JGProgressHUD *)hudWhenSuccess
{
    JGProgressHUD *hud = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud.indicatorView =  [[JGProgressHUDSuccessIndicatorView alloc]init];
    hud.textLabel.text = @"登录成功";
    return hud;
}

+ (JGProgressHUD *)hudWhenSuccessWithMsg:(NSString *)msg
{
    JGProgressHUD *hud = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud.indicatorView =  [[JGProgressHUDSuccessIndicatorView alloc]init];
    hud.textLabel.text = msg;
    return hud;
}

+ (JGProgressHUD *)hudWHenFailure
{
    JGProgressHUD *hud = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud.indicatorView =  [[JGProgressHUDErrorIndicatorView alloc]init];
    return hud;
}

+ (JGProgressHUD *)showJGHUDWhenSuccess:(UIView *)baseView msg:(NSString *)message
{
    //显示JGProgressHUD
    JGProgressHUD *jgHUD = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    jgHUD.textLabel.text = message;
    JGProgressHUDSuccessIndicatorView *errorView = [[JGProgressHUDSuccessIndicatorView alloc]init];
    jgHUD.indicatorView = errorView;
    jgHUD.voiceOverEnabled = NO;
    [jgHUD showInView:baseView animated:YES];
    [jgHUD dismissAfterDelay:1.5f animated:YES];
    
    return jgHUD;

}

+ (JGProgressHUD *)showJGHUDWhenError:(UIView *)baseView msg:(NSString *)message
{
    //显示JGProgressHUD
    JGProgressHUD *jgHUD = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    jgHUD.textLabel.text = [message description];
    JGProgressHUDErrorIndicatorView *errorView = [[JGProgressHUDErrorIndicatorView alloc]init];
    jgHUD.indicatorView = errorView;
    jgHUD.voiceOverEnabled = NO;
    [jgHUD showInView:baseView animated:YES];
    [jgHUD dismissAfterDelay:1.5f animated:YES];
    
    return jgHUD;
}
@end
