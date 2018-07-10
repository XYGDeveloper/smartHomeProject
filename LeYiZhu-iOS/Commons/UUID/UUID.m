//
//  UUID.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/23.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "UUID.h"
#import "KeyChainStore.h"


@implementation UUID



+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[KeyChainStore load:@"com.smarthome.app.usernamepassword"];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [KeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
    return strUUID;
}

@end
