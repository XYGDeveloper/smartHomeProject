//
//  LYZContactsModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/10.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LYZContactsModel : NSObject

@property (nonatomic , copy) NSString *contactsID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSNumber *paperworkType;

@property (nonatomic, copy) NSString *paperworkNum;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *phone;

@property  NSInteger index; //订单填写页面 用来确定是入住人的index

@property (nonatomic, assign) BOOL isSelect; //入住人选择页面用来判断是否选中

@property (nonatomic, assign) BOOL unselectable;//入住人选择页面标记不能再选

+(NSString *)resetPaperworkType:(NSNumber *)paperworkType;

@end
