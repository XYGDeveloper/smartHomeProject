//
//  GetCabinetInfoResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"

@class CabinetInfoModel;
@interface GetCabinetInfoResponse : AbstractResponse

@property (nonatomic, readonly, strong) CabinetInfoModel *cabinetInfo;


@end
