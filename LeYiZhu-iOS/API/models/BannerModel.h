//
//  BannerModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/14.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BannerModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, copy) NSString *bannerID;

@property (nonatomic ,readonly, assign) NSNumber *type;

@property (nonatomic ,readonly, copy) NSString *imgPath;

@property (nonatomic ,readonly, copy) NSString *content;

@property (nonatomic ,readonly, copy) NSString *objectID;






@end
