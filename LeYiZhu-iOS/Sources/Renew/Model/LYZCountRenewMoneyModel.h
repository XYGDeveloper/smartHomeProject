//
//  LYZCountRenewMoneyModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RenewRoomInfoModel.h"

@interface LYZCountRenewMoneyModel : NSObject

@property (nonatomic, strong) NSNumber *deductible;

@property (nonatomic, strong) NSNumber *stayMoneySum;

@property (nonatomic,strong) NSNumber *depositSum;

@property (nonatomic, strong) NSNumber *actualPayment;

@property (nonatomic, strong) NSArray <RenewRoomInfoModel*>*roomJar;

@end
