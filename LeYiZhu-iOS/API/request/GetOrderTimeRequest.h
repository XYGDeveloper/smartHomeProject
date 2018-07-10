//
//  getOrderTimeRequest.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/13.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface GetOrderTimeRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *orderNO;

@end
