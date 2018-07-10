//
//  ProvinceModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>


@interface ProvinceModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, readonly, copy) NSString * province_id;

@property(nonatomic, readonly, copy) NSString * province_name;

@property (nonatomic, readonly, copy) NSString * province_code;

@property(nonatomic, readonly, strong) NSArray * citys;

@end
