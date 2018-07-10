//
//  SearchHotelOrCityResponse.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseSearchCityModel.h"

@interface SearchHotelOrCityResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseSearchCityModel * baseSearchCity;
@end
