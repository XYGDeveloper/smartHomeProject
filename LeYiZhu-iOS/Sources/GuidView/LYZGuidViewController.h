//
//  LYZGuidViewController.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/1/20.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectDelegate <NSObject>
- (void)click;
@end

@interface LYZGuidViewController : UIViewController

@property (nonatomic, strong) UIButton *btnEnter;
// 初始化引导页
- (void)initWithXTGuideView:(NSArray *)images;
// 版本信息判断
- (BOOL)isShow;
@property (nonatomic, assign) id<selectDelegate> delegate;
// 创建单利类
+ (instancetype)shareXTGuideVC;

@end
