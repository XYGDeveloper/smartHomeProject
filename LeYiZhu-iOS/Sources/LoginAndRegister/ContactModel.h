//
//  ContactModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyContactsModel.h"

//typedef NS_ENUM(NSInteger) {
//    //以下是枚举成员
//    IndentifierType = 0,
//    hkPassportType,
//    twPassportType ,
//    passportType = 3
//} cardType;

@interface ContactModel : MyContactsModel

@property (nonatomic , assign) BOOL isHide;


@end
