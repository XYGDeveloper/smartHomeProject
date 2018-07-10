//
//  LYZChangePswViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/1.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYZChangePswViewController : UIViewController

@property (nonatomic, copy)void(^vercodeCallBack)();

- (void)showInViewController:(UIViewController *)vc;

@end
