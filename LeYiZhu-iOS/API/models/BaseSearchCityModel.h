//
//  BaseSearchCityModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseSearchCityModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, strong)  NSArray *hcs;

@end
