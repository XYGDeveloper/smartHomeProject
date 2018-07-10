//
//  LYZPhoneCall.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYZPhoneCall : NSObject

+ (void)callPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc;

+(void)noAlertCallPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc;

@end
