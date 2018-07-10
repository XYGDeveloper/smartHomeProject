//
//  LYZRefillGuestInfoModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/13.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYZRefillGuestInfoModel : NSObject

@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, copy) NSString *roomID;
@property (nonatomic, copy) NSString *roomNum;
@property (nonatomic, copy) NSString *liveUserName;
@property (nonatomic, copy) NSString *renewDate;
@property (nonatomic, copy) NSString *continueDate;
@property (nonatomic, copy) NSString *childOrderId;


@property (nonatomic, assign) NSInteger index;

@end
