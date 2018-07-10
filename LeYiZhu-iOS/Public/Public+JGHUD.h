//
//  Public+JGHUD.h
//  BeiKePark
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 mac. All rights reserved.
//
#import "Public.h"
#import "JGProgressHUD.h"

@interface Public (JGHUD)

+ (JGProgressHUD*)hudWhenRequest;

+ (JGProgressHUD*)hudWhenSuccess;

+ (JGProgressHUD*)hudWHenFailure;

+ (JGProgressHUD *)showJGHUDWhenSuccess:(UIView *)baseView msg:(NSString *)message;

+ (JGProgressHUD*)showJGHUDWhenError:(UIView*)baseView msg:(NSString *)message;

+ (JGProgressHUD *)hudWhenSuccessWithMsg:(NSString *)msg;

@end
