//
//  RoomPriceModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface RoomPriceModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *checkInDate;

@property (nonatomic, readonly, copy) NSString *price;

@property (nonatomic, readonly, copy) NSString *vipPrice;

@end
