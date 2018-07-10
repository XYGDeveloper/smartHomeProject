//
//  BannersModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BannersModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *bannerID;

@property (nonatomic, readonly, copy) NSString *imgpath;

@property (nonatomic, readonly, copy) NSString *subtitle;

@property (nonatomic, readonly, copy) NSString *url;

@end
