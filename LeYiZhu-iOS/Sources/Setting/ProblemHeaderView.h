//
//  ProblemHeaderView.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/18.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomHeaderFooterView.h"

#define kDefaultHeaderHeight 60

@interface ProblemHeaderView : CustomHeaderFooterView

/**
 *  Change to normal state.
 *
 *  @param animated Animated or not.
 */
- (void)normalStateAnimated:(BOOL)animated;

/**
 *  Change to extended state.
 *
 *  @param animated Animated or not.
 */
- (void)extendStateAnimated:(BOOL)animated;

@end
