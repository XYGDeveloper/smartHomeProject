//
//  CreateRenewModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/4/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CreateRenewModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy)  NSString *orderNO;

@property (nonatomic, readonly, strong)  NSNumber *orderType;


@end
