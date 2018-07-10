//
//  VipApplyInfoModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSUInteger, CellType) {
//    nameType = 0,
//    idType,
//    emailType,
//    inviteCodeType
//};

@interface VipApplyInfoModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *IDNum;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *inviteCode;

//@property (nonatomic, assign) CellType type;

@end
