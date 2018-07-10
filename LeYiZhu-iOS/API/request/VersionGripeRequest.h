//
//  LYZVersionGripeRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface VersionGripeRequest : AbstractRequest

@property (nonatomic, copy) NSString *isOpenGripe;

@property (nonatomic, copy) NSString *isforce;

@property (nonatomic, copy) NSString *appversioncode;

@end
