//
//  bindByPhoneRequest.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/29.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface bindByPhoneRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *captcha;

@property (nonatomic, copy) NSString *thirdID;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *facePath;

@end
