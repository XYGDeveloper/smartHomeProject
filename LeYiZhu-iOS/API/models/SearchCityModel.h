//
//  SearchCityModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SearchCityModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *hotelID;

@property (nonatomic, readonly, copy) NSString *hotelName;

@property (nonatomic, readonly, copy) NSString *cityID;

@property (nonatomic, readonly, copy) NSString *cityName;

@property (nonatomic, readonly, assign) NSNumber *type;



@end
