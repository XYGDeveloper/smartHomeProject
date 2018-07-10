//
//  BaseProvinceObject.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/1.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseProvinceObject : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, strong) NSArray * provinceslist;

@end

