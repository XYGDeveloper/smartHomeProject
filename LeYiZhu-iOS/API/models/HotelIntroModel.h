//
//  HotelIntroModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface HotelIntroModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *hotelID;

@property (nonatomic, readonly, copy) NSString *hotelName;

@property (nonatomic, readonly, copy) NSString *tags;

@property (nonatomic, readonly, copy) NSString *intro;//酒店介绍

@property (nonatomic, readonly, copy) NSString *facility;//酒店设施

@property (nonatomic, readonly, copy) NSString *checkInInfo;//入住须知


@end
