//
//  UIHelper.h
//  Qqw
//
//  Created by zagger on 16/8/16.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import <Foundation/Foundation.h>

//快速创建label对象
#define GeneralLabel(f, c) [UIHelper labelWithFont:f textColor:c]
#define GeneralLabelA(f, c, a) [UIHelper labelWithFont:f textColor:c textAlignment:a]

#define TextColor1 HexColor(0x323232) //（导航栏文字（苹方中等）/子导航文字--选中状态（苹方中等）/头像旁边的用户名/文章标题/重点文字）
#define TextColor2 HexColor(0x666666) //（次级文字/子导航文字--未选中状态）
#define TextColor3 HexColor(0x909090) // (再次级文字/输入框内提示文字/注明类文字）
#define TextColor4 HexColor(0xd63d3e) //（警示文字/标示价钱的文字）


@interface UIHelper : NSObject

#pragma mark - placeholder
+ (UIImage *)bigPlaceholder;
+ (UIImage *)smallPlaceholder;

#pragma mark - general button
/** 主题绿色背景、直角、白色文字的按钮 */
+ (UIButton *)generalButtonWithTitle:(NSString *)title;

/** 主题绿色背景、小圆角、白色文字的按钮 */
+ (UIButton *)generalRaundCornerButtonWithTitle:(NSString *)title;

/** 边框颜色、文字颜色和主题相同的白底圆角按钮*/
+ (UIButton *)appstyleBorderButtonWithTitle:(NSString *)title;

/** 边框颜色为灰色，文字颜色为黑色的白底圆角按钮 */
+ (UIButton *)grayBorderButtonWithTitle:(NSString *)title;

#pragma mark - general label
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment;

@end
