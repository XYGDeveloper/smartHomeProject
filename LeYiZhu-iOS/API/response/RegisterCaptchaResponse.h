//
//  RegisterCaptchaResponse.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/28.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
@interface RegisterCaptchaResponse : AbstractResponse

@property (nonatomic,readonly,copy)NSString  *captcha;

@end
