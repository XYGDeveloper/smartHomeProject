//
//  LYZRenewRoomInfoModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/4/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface RenewRoomInfoModel : MTLModel<MTLJSONSerializing>


@property (nonatomic, readonly, copy) NSString *liveUserName;

@property (nonatomic, readonly, copy) NSString *roomNum;

@property (nonatomic, readonly, strong) NSArray *roomPrice;

@property (nonatomic, readonly, strong) NSNumber *liveDay;

@property (nonatomic, readonly, copy) NSString *roomPriceSum;

@property (nonatomic, readonly, copy) NSString *deposit;//房间押金




@end
