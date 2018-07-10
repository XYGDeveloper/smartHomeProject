//
//  WiFiManager.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WiFiManager : NSObject

+ (instancetype)instance;

- (void)scanWifiInfos;

@end
