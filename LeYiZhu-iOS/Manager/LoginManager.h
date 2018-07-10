//
//  LoginManager.h
//  LeYiZhu-iOS
//
//  Created by mac on 16/11/21.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"



typedef void(^LoginBlock)(void);
@class User;
@interface LoginManager : NSObject

@property (nonatomic, copy) NSString *token;

@property (nonatomic ,strong) User * userInfo;//当前登录角色信息

@property (nonatomic, copy) NSString *appUserID;

@property (nonatomic, assign) BOOL autoLogin;

@property (nonatomic, copy) LoginBlock successBlock;

+ (instancetype)instance;


-(BOOL)isLogin;

-(void)userLogin;

-(void)userLogin:(LoginBlock)block;


- (BOOL)saveUserInfo:(UserInfo*)userInfo;

-(void)checkLoginSuccess:(LoginBlock)block;

-(void)loginWithPhone:(NSString*)phone passwd:(NSString*)psw block:(EventCallBack)block;

- (void)loginWithPhone:(NSString *)phone varcode:(NSString *)varcode block:(EventCallBack)block;

-(void)logoutWithblock:(EventCallBack)block;

- (void)logout;

@end
