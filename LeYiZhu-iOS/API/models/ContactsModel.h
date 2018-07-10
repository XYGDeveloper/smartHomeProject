//
//  ContactsModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ContactsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic , readonly, copy) NSString *contactsID;

@property (nonatomic, readonly, copy) NSString *name;

@property (nonatomic, readonly, assign) NSNumber *paperworkType;

@property (nonatomic, readonly, copy) NSString *paperworkNum;

@property (nonatomic, readonly, copy) NSString *sex;

@property (nonatomic, readonly, copy) NSString *phone;

@property (nonatomic, readonly, copy) NSString *createTime;


@end
