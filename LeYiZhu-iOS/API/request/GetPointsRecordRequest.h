//
//  GetPointsRecordRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface GetPointsRecordRequest : AbstractRequest

@property (nonatomic, copy) NSString *limit;

@property (nonatomic, copy) NSString *pages;

@end
