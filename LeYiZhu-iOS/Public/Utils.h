//
//  Utils.h
//  Qqw
//
//  Created by zagger on 16/8/17.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

#pragma 引导页控制
/** 是否需要显示引导页 */
+ (BOOL)shouldShowGuidePage;
/** 更新本地缓存的app版权 */
+ (void)updateCachedAppVersion;

+(UIImage*) imageWithColor:( UIColor*)color1;

@end


@interface UIColor (extension)

+ (UIColor *)rgb:(NSString *)rgbHex;

@end


