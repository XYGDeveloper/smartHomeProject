//
//  SearchOrderListModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SearchOrderListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly ,copy) NSString *orderNO;

@property (nonatomic, readonly ,assign) NSNumber *status;

@property (nonatomic, readonly ,assign) NSNumber *actualPayment;

@property (nonatomic, readonly ,assign) NSNumber *liveDays;

@property (nonatomic, readonly ,copy) NSString *checkTime;  //入住日期

@property (nonatomic, readonly ,copy) NSString *outTime;

@property (nonatomic, readonly, copy) NSString *hotelName;

@property (nonatomic, readonly ,copy) NSString *roomType;

@property (nonatomic, readonly, copy) NSString *roomImgPath;


@end
