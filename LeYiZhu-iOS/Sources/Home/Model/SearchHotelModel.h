//
//  SearchHotelModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"


@class SearchLoadHotelModel;
@interface SearchHotelModel : BaseObject

@property NSString *hotelID;

@property NSString *name;

@property NSString *distance;

+(instancetype)initWithHotel:(SearchLoadHotelModel *)hotel;

@end
