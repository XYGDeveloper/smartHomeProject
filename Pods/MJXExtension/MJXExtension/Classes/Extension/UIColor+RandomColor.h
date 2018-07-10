//
//  UIColor+RandomColor.h
//  demo14-AttachmentCollectionView
//
//  Created by 张鹏 on 13-9-27.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RandomColor)

// MARK: -- 获取随机颜色
+ (UIColor *)randomColor;

// MARK: -- 获取随机深色的颜色
+ (UIColor *)specialRandomColor;

@end
