//
//  ThirdLoginResponse.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "UserInfo.h"

@interface ThirdLoginResponse : AbstractResponse

@property (nonatomic, readonly, strong)UserInfo *userInfo;

@end
