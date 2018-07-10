//
//  LoginManager.m
//  LeYiZhu-iOS
//
//  Created by mac on 16/11/21.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "LoginManager.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "BaseNavController.h"
#import "JPUSHService.h"
#import "User.h"

NSString * const iToken = @"iitoken";
NSString * const iUserID = @"iiuserID";
NSString * const iAccout = @"iiaccount";
NSString * const iPassword = @"iipassword";
#define KUserInfo @"kUserInfo"

@interface LoginManager ()

@property (nonatomic ,assign) BOOL isLogin;

@end

@implementation LoginManager

+ (instancetype)instance
{
    static LoginManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LoginManager alloc] init];
    });
    return manager;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        _autoLogin = YES;
    }
    return self;

}

-(NSString *)token{
    return [IICommons getPersistenceStringWithKey:iToken];
}



-(NSString *)appUserID{
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] dataForKey:KUserInfo]];
    return user.appUserID;
}

- (BOOL) isLogin{
    if (self.appUserID.length > 0) {
        return YES;
    }
    return NO;
}


- (BOOL)saveUserInfo:(UserInfo *)userInfo
{
    if(userInfo == nil){
        return NO;
    }
    User *user = [User initWithUserInfo:userInfo];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:user] forKey:KUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
     [IICommons setPersistenceData:userInfo.token withKey:iToken];
    return YES;
}

-(User *)userInfo{
  
    return  [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] dataForKey:KUserInfo]];
}

-(void)checkLoginSuccess:(LoginBlock)block{
    if ([self isLogin]) {
        block();
    }else{
        [self userLogin:block];
    }
}

-(void)userLogin:(LoginBlock)block{
    
    LoginController *loginVC = [[LoginController alloc] init];
    
    BaseNavController *nav = [[BaseNavController alloc]initWithRootViewController:loginVC];
    
    loginVC.presentBlock = ^(void){
        block();
    };
    AppDelegate *dele = (AppDelegate*) [UIApplication sharedApplication].delegate;
    [dele.rootTab presentViewController:nav animated:YES completion:nil];
}


-(void)userLogin{

    LoginController *loginVC = [[LoginController alloc] init];
    
    BaseNavController *nav = [[BaseNavController alloc]initWithRootViewController:loginVC];
    
    loginVC.presentBlock = ^(void){
         NSLog(@"login success");
    };
    AppDelegate *dele = (AppDelegate*) [UIApplication sharedApplication].delegate;
    [dele.rootTab presentViewController:nav animated:YES completion:nil];
}



-(void)loginWithPhone:(NSString*)phone passwd:(NSString*)psw block:(EventCallBack)block{

    [[LYZNetWorkEngine sharedInstance] userLogin:phone password:psw versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        if (event == 1) {
            UserInfo * userInfo = [(UserLoginResponse*)object userInfo];
        
            BOOL isSuccess =  [self saveUserInfo:userInfo];
            if(isSuccess){
                LYLog(@"储存成功 登录信息");
            }else{
                LYLog(@"储存失败 登录信息");
            }
            if (self.autoLogin) {
                if (userInfo.appUserID) {
                    //密码暂时先 本地保存  以后要加密保存在 keychain 中
                    [IICommons setPersistenceData:userInfo.appUserID withKey:iUserID];
                }
            }
            block(1,object);

        }else if(event == 8){
            UserInfo * userInfo = [(UserLoginResponse*)object userInfo];
            
            BOOL isSuccess =  [self saveUserInfo:userInfo];
            if(isSuccess){
                LYLog(@"储存成功 登录信息");
            }else{
                LYLog(@"储存失败 登录信息");
            }
            if (self.autoLogin) {
                if (userInfo.appUserID) {
                    //密码暂时先 本地保存  以后要加密保存在 keychain 中
                    [IICommons setPersistenceData:userInfo.appUserID withKey:iUserID];
                }
            }
            block(8 , object);
            
        }
        else{
            block(0,object);
        }
    }];
}


- (void)loginWithPhone:(NSString *)phone varcode:(NSString *)varcode block:(EventCallBack)block
{
    [[LYZNetWorkEngine sharedInstance] userLogin:phone varCode:varcode versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        
        if (event == 1) {
            
            NSLog(@"xinxi%@",object);
            
            UserInfo * userInfo = [(UserLoginResponse*)object userInfo];
            userInfo.phone = phone;
            BOOL isSuccess =  [self saveUserInfo:userInfo];
            if(isSuccess){
                LYLog(@"储存成功 登录信息");
            }else{
                LYLog(@"储存失败 登录信息");
            }
            //test 设置推送
            [JPUSHService setAlias:userInfo.appUserID completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NSLog(@"设置结果:%li 用户别名:%@",iResCode,iAlias);
            } seq:1001];
            if (self.autoLogin) {
                if (userInfo.appUserID) {
                    //密码暂时先 本地保存  以后要加密保存在 keychain 中
                    [IICommons setPersistenceData:userInfo.appUserID withKey:iUserID];
                }
            }
            block(1,object);
            
        }else if(event == 8){
            UserInfo * userInfo = [(UserLoginResponse*)object userInfo];
            BOOL isSuccess =  [self saveUserInfo:userInfo];
            if(isSuccess){
                LYLog(@"储存成功 登录信息");
            }else{
                LYLog(@"储存失败 登录信息");
            }
            if (self.autoLogin) {
                if (userInfo.appUserID) {
                    //密码暂时先 本地保存  以后要加密保存在 keychain 中
                    [IICommons setPersistenceData:userInfo.appUserID withKey:iUserID];
                }
            }
            block(8 , object);
        }
        else{
            block(0,object);
        }
    }];
    
}





-(void)logoutWithblock:(EventCallBack)block{
     NSString * userID = self.appUserID;
    [[LYZNetWorkEngine sharedInstance] userLogoutAppUserID:userID versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        if (event == 1) {
            [IICommons removePersistenceDataForKey:iUserID];
            [self logout];
            block(1,object);
        }else
        {
            block(0,object);
        }
    }];
}

- (void)logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: KUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [IICommons removePersistenceDataForKey:iToken];
    //解除推送绑定
   [JPUSHService setAlias:@"" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
       
   } seq:1001];
}
@end
