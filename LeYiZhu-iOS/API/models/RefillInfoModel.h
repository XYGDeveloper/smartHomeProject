//
//  RefillInfoModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface RefillInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *checkInDate;

@property (nonatomic, readonly, copy) NSString *checkOutDate;

@property (nonatomic, readonly, copy) NSString *continueDate;

@property (nonatomic, readonly, copy) NSString *roomNum;

@property (nonatomic, readonly, copy) NSString *liveUserName;

@property (nonatomic, readonly, copy) NSString *liveUserPhone;

@property (nonatomic, readonly, assign) NSNumber *isSelect;

@property (nonatomic, readonly, copy) NSString *childOrderId;


@end
