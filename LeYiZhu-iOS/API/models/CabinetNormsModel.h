//
//  CabinetNormsModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CabinetNormsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *norm;

@property (nonatomic, readonly, copy) NSString *norminfo;

@property (nonatomic, readonly, copy) NSString *ishavecloselat;

@end
