//
//  LYZToastConfig.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#ifndef LYZToastConfig_h
#define LYZToastConfig_h

#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height + 44

typedef NS_ENUM(NSInteger, FFToastType) {
    
    //灰色背景、无图标
    FFToastTypeDefault = 1,
    //绿色背景+成功图标
    FFToastTypeSuccess = 2,
    //红色背景+错误图标
    FFToastTypeError = 3,
    //橙色背景+警告图标
    FFToastTypeWarning = 4,
    //灰蓝色背景+信息图标
    FFToastTypeInfo = 5,
    
};

typedef NS_ENUM(NSInteger, FFToastPosition) {
    
    //显示在屏幕顶部
    FFToastPositionDefault = 0,
    //显示在状态栏下方
    FFToastPositionBelowStatusBar = 1,
    //显示在状态栏下方+圆角+左右边距
    FFToastPositionBelowStatusBarWithFillet = 2,
    //显示在屏幕底部
    FFToastPositionBottom = 3,
    //显示在屏幕底部+圆角
    FFToastPositionBottomWithFillet = 4,
    //显示在屏幕中间
    FFToastPositionCentre = 5,
    //显示在屏幕中间+圆角
    FFToastPositionCentreWithFillet = 6
    
};



#endif /* LYZToastConfig_h */
