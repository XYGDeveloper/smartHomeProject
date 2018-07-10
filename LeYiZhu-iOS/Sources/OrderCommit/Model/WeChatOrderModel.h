//
//  WeChatOrderModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface WeChatOrderModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, strong) NSNumber *orderType;

@property (nonatomic, copy) NSString *appid;

@property (nonatomic, copy) NSString *partnerid;

@property (nonatomic, copy) NSString *prepayid;

@property (nonatomic, copy) NSString *packageStr;

@property (nonatomic, copy) NSString *noncestr;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *sign;

@end
