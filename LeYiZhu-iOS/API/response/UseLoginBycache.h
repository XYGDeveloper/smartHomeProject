//
//  UseLoginBycache.h
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "UserInfo.h"
@interface UseLoginBycache : AbstractResponse

@property (nonatomic,readonly,copy)UserInfo  * userInfo;

@end
