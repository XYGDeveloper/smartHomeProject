//
//  SearchLoadCitysModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SearchLoadCitysModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *cityID;

@property (nonatomic, readonly, copy) NSString *name;
/*
 ** 酒店状态
 * status :  1、已入驻 2、即将入驻
 */
@property (nonatomic, readonly, strong) NSNumber *status;



@end
