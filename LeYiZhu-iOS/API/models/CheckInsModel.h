//
//  CheckInsModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CheckInsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, copy)  NSString *name;

@property (nonatomic, readonly, copy) NSString *paperworkNum;   // 身份证号码

@property (nonatomic, readonly, strong) NSNumber *paperworkType;

@property (nonatomic, readonly, copy) NSString *liveRrcordPhone;

@end
