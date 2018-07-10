//
//  ProblemModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ProblemModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, assign) NSNumber *problemID;

@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, readonly , copy) NSString *reply;

@end
