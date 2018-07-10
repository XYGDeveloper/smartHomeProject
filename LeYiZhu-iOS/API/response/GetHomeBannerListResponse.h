//
//  GetBannerListResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseBannerListModel.h"

@interface GetHomeBannerListResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseBannerListModel  *baseBannerList;

@end
