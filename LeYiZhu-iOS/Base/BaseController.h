//
//  BaseController.h
//  ZhiNengJiaju
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseController : UIViewController

- (void)setNavigationItem:(UIBarButtonItem *)item;


- (UIButton *)setLeftNavigationItemWithImage:(UIImage *)leftImage
                        hightLightImageImage:(UIImage *)hightImage
                                      action:(SEL)action;
- (UIButton *)setRightNavigationItemWithImage:(UIImage *)leftImage
                         hightLightImageImage:(UIImage *)hightImage
                                       action:(SEL)action;



@end
