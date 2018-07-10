//
//  CabinetInfoModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CabinetInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *cabinetID;//柜子组id

@property (nonatomic, readonly, copy) NSString *cabtype;

@property (nonatomic, readonly, copy) NSString *opentype;//打开类型(1.取 2.存)

@property (nonatomic, readonly, copy) NSString *latticeid;

@property (nonatomic, readonly, strong) NSArray *normjar;



@end
