//
//  LYZSingleCalenderViewController.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/4/22.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYCalendarView.h"

typedef void (^optionCaleder)(NSDate *date);

@interface LYZSingleCalenderViewController : UIViewController

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *closeButton;
@property (nonatomic,strong)ZYCalendarView *calederView;
@property (nonatomic,strong)optionCaleder optionCalederBlock;
@property (nonatomic,strong)NSMutableArray *calederArray;
@property (nonatomic,strong) NSDate *enableDate;//不能选择时间

@end
