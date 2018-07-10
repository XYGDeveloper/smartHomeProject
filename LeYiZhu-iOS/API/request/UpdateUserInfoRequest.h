//
//  UpdateUserInfoRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface UpdateUserInfoRequest : AbstractRequest

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *facepath;

@end
