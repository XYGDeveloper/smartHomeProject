//
//  GetBannerLists.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseBannerModel.h"

@interface GetBannerListsResponse : AbstractResponse

@property (nonatomic ,readonly, strong) BaseBannerModel *baseBanner;

@end
