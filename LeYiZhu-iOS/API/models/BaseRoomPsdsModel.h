//
//  BaseRoomPsdsModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseRoomPsdsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly ,strong) NSArray *userRoomPwds;

@end
