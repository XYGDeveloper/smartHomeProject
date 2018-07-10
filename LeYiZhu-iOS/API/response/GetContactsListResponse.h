//
//  GetContactsListResponse.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/8.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseContactsModel.h"

@interface GetContactsListResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseContactsModel *baseContacts;

@end
