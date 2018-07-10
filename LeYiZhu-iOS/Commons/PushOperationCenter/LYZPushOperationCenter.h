//
//  LYZPushOperationCenter.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/27.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseMessageView.h"
#include <EZAudioiOS/EZAudioiOS.h>

@interface LYZPushOperationCenter : NSObject<BaseMessageViewDelegate,EZMicrophoneDelegate,EZAudioFFTDelegate>

+ (instancetype)instance;

-(void)handleCode:(NSString *)code;

-(void)pushCouponToUser:(NSString *)imgUrl;

-(void)jumpToTargetWithOrderNo:(NSString *)orderNo orderType:(NSString *)orderType;

-(void)beginGetCurrentSoundFrequecy:(NSDictionary *)info;

@end
