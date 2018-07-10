//
//  WaterfallPictureModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "mantle.h"

@interface WaterfallPictureModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *iht;
@property (nonatomic, strong) NSNumber *iwd;
@property (nonatomic, strong) NSString *isrc;


@end

