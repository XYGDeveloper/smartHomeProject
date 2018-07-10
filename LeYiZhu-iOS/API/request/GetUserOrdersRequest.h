//
//  GetUserOrdesRequest.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/21.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface GetUserOrdersRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *appUserID;

@property (nonatomic, copy) NSString *orderStatus;

@property (nonatomic, copy) NSString *limit;

@property (nonatomic, copy) NSString *pages;

@end
