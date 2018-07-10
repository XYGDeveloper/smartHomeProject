//
//  OpenCabinetRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface OpenCabinetRequest : AbstractRequest

@property (nonatomic, copy) NSString *cabinetID;
@property (nonatomic, copy) NSString *cabinetType;
@property (nonatomic, copy) NSString *opentype;
@property (nonatomic, copy) NSString *latticeid;
@property (nonatomic, copy) NSString *norm;

@end
