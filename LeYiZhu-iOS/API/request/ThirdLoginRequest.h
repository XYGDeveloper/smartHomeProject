//
//  ThirdLoginRequest.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface ThirdLoginRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *thirdID;


@property (nonatomic, copy) NSString *type;//类型1.微博2.QQ3.微信

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *facePath;


@end
