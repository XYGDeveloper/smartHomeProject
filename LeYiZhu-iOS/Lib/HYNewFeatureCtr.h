//
//  HYNewFeatureCtr.h
//  NewAssemProduct
//
//  Created by why on 2017/1/3.
//  Copyright © 2017年 moreShare. All rights reserved.
//	新特性

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface HYNewFeatureCtr : UIViewController



/** 圆点的大小 及 空隙  在 .m 文件宏定义设置 */

/** 进入首页按钮 */
@property (nonatomic,weak) UIButton *enterButton;

/** 创建普通滚动图片新特性界面
 *  @param imageNames 图片名数组
 *  @param dotImage	  pageControl 圆点
 *  @param currentDotImage	    当前圆点
 *  @param enterBlock 进入主页面的回调
 *  @param configurationBlock 配置回调
 */
+ (instancetype)newFeatureVCWithImageNames:(NSArray *)imageNames dotImage:(NSString *)dotImage currentDotImage:(NSString *)currentDotImage enterBlock:(void(^)())enterBlock configuration:(void (^)(UIButton *enterButton))configurationBlock;

/** 创建视频新特性界面
 *  @param URL 视频路径
 *  @param enterBlock 进入主页面的回调
 *  @param configurationBlock 配置回调
 */
+ (instancetype)newFeatureVCWithPlayerURL:(NSURL *)URL enterBlock:(void(^)())enterBlock configuration:(void (^)(AVPlayerLayer *playerLayer))configurationBlock;

/*
 *  是否应该显示版本新特性界面
 */
+ (BOOL)canShowNewFeature;

@end
