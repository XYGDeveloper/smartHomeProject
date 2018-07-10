//
//  BaseBannerListModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseBannerListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, strong) NSArray *banners;

@property (nonatomic, readonly, strong) NSArray *recommends;

@property (nonatomic, readonly, strong) NSArray *activitys;

@property (nonatomic, readonly, copy) NSString *activityurl;

@end
