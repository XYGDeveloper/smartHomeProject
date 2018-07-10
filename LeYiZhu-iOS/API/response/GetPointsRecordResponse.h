//
//  GetPointsRecordResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
#import "BasePointRecordModel.h"

@interface GetPointsRecordResponse : AbstractResponse

@property (nonatomic, readonly, strong) BasePointRecordModel *pointRecord;

@end
