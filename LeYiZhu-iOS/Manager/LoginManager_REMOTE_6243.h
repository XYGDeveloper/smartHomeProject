//
//  LoginManager.h
//  LeYiZhu-iOS
//
//  Created by mac on 16/11/21.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"


@interface LoginManager : NSObject

+ (instancetype)instance;

- (NSString*)getToken;

- (BOOL)isLogin;


- (UserModel*)getUserModel;


@end
