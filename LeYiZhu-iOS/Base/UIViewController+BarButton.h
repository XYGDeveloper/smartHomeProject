//
//  UIViewController+BarButton.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BarButton)

- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action needLogin:(BOOL)needLogin;

- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action;

- (void)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action;

- (void)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action;

- (void)addLeftBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action;

- (void)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction;

@end
