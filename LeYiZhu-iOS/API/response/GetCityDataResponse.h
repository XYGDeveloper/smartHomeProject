//
//  GetCityDataResponse.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseProvinceObject.h"

@interface GetCityDataResponse : AbstractResponse

@property(nonatomic, readonly, strong) BaseProvinceObject * provicesObject;

@end

