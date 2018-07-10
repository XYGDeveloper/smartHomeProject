//
//  UpdateContactsRequest.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface UpdateContactsRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *contactID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSNumber *paperworkType;

@property (nonatomic, copy) NSString *paperworkNum;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *phone;

@end
