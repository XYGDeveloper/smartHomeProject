//
//  CitysModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CitysModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, readonly, copy) NSString * city_id;

@property(nonatomic, readonly, copy) NSString * city_name;

@property(nonatomic, readonly, copy) NSString * city_code;

@property (nonatomic, readonly, copy) NSString * province_id;

@end
