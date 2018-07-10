//
//  OpenKeyRequest.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface OpenKeyRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *roomID;

@property (nonatomic, copy) NSString *appUserID;

@property (nonatomic, copy) NSString *pactVersion;




@end
