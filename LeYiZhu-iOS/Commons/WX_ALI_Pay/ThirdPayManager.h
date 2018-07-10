//
//  ThirdPayManager.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdPayManager : NSObject

+ (instancetype)instance;

- (void)weixinRequest:(NSString *)orderNo orderType:(NSString *)orderType;

- (void)createAliOrder:(NSString *)orderNO orderType:(NSString *)orderType;


@end
