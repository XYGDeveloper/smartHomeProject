//
//  LYZOrderGuestInfoModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYZContactsModel;

@interface LYZOrderGuestInfoModel : NSObject

@property (nonatomic, copy) NSString *roomCount;

@property (nonatomic, strong) NSArray <LYZContactsModel *>*guests;

@property (nonatomic, copy) NSString *phoneNum;

@end
