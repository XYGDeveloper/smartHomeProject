//
//  GetCabinetInfoRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface GetCabinetInfoRequest : AbstractRequest

@property (nonatomic, copy) NSString *cabinetNO;
@property (nonatomic, copy) NSString *cabinetType;

@end
