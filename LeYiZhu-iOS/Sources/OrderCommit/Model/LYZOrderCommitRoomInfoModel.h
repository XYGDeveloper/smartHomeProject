//
//  ModelForOrderCommit.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYZOrderCommitRoomInfoModel : NSObject

@property (nonatomic, copy) NSString *roomID;
@property (nonatomic, copy) NSString *hotelName;
@property (nonatomic, copy) NSString *roomType;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *vipPrice;
@property (nonatomic, strong) NSDate *checkInDate;
@property (nonatomic, strong) NSDate *checkOutDate;

@end
