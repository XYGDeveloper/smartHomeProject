//
//  LYZCalederViewController.h
//  LeYiZhu-iOS
//
//  Created by xyg on 2017/3/15.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYCalendarView.h"

typedef void (^optionDateCaleder)(NSMutableArray *array);

@interface LYZCalederViewController : UIViewController

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *closeButton;
@property (nonatomic,strong)ZYCalendarView *calederView;
@property (nonatomic,strong)optionDateCaleder optionCalederBlock;
@property (nonatomic,strong)NSMutableArray *calederArray;

@end
