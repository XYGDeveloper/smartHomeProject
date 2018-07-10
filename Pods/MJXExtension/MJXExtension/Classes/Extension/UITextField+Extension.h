//
//  UITextField+Extension.h
//  基础框架
//
//  Created by MJX on 2017/7/3.
//  Copyright © 2017年 ShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)


/**
 设置左边距空缺

 @param length 空缺长度,不小于10,建议15
 */
- (void)setLeftVacancyLength:(CGFloat)length;

@end
