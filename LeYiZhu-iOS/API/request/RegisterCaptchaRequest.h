//
//  RegisterCaptchaRequest.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/28.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface RegisterCaptchaRequest : AbstractRequest

@property(nonatomic, copy)NSString *phone;

@property(nonatomic, copy)NSString *versioncode;

@property(nonatomic, copy)NSString *devicenum;

@property(nonatomic, copy)NSString *fromtype;

@end
