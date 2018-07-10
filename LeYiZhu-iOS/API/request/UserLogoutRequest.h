//
//  UserLogoutRequest.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface UserLogoutRequest : AbstractRequest

@property(nonatomic, readwrite, copy) NSString * appUserID;

@property(nonatomic, readwrite, copy) NSString * versioncode;

@property(nonatomic, readwrite, copy) NSString * devicenum;

@property (nonatomic,readwrite , copy) NSString * fromtype;// 1.android  2.ios


@end
