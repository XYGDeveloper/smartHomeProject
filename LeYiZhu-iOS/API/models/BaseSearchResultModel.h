//
//  BaseSearchResultModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "HotelSearchResultModel.h"

@interface BaseSearchResultModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, readonly, strong) NSArray * searchResult;

@end
