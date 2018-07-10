//
//  AddCommentRequest.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface AddCommentRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *appUserID;

@property (nonatomic, copy) NSString *hotelID;

@property (nonatomic ,copy) NSString *childOrderId;

@property (nonatomic, copy) NSString *orderNO;

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, assign) NSNumber *satisFaction;

@property (nonatomic, strong) NSArray *images;

@end
