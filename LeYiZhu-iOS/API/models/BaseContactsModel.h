//
//  BaseContactsModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseContactsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, strong) NSArray *appContacts;

@end