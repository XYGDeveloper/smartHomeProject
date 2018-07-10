//
//  SearchLoadHotelModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SearchLoadHotelModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *hotelID;

@property (nonatomic, readonly, copy) NSString *name;

@property (nonatomic, readonly, copy) NSString *distance;


@end
