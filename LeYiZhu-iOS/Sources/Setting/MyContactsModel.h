//
//  MyContactsModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/12.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger) {
    //以下是枚举成员
    IndentifierType = 1,
    hkPassportType,
    twPassportType ,
    passportType
} cardType;

@interface MyContactsModel : NSObject

@property (nonatomic , copy) NSString *contactsID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *paperworkType;

@property (nonatomic, copy) NSString *paperworkNum;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *phone;

-(void)resetPaperworkType:(NSInteger )paperworkType;



@end
