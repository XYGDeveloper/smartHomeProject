//
//  UpdatePswRequest.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/12.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface UpdatePswRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *appUserID;

@property (nonatomic, copy) NSString *oldPsw;

@property (nonatomic, copy) NSString *nPsw;


@end
