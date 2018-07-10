//
//  LYZSingleCalenderViewController.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/4/22.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZSingleCalenderViewController.h"
#import "Masonry.h"

@interface LYZSingleCalenderViewController ()

@property (nonatomic, strong) NSDate *selectDate;

@end

@implementation LYZSingleCalenderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)ConfigCaleder{
    
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.topView =[[UIView alloc]init];
    self.topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
        
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"请选择续至日期";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.topView addSubview:_titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        
    }];
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * closeImg = [[UIImage imageNamed:@"pay_icon_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.closeButton setImage:closeImg forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeCaleder) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:_closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(-15);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(40);
    }];
    
    UIView *weekTitlesView = [[UIView alloc] init];
    [self.view addSubview:weekTitlesView];
    [weekTitlesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(47);
        
    }];
    CGFloat weekW =( self.view.frame.size.width  -2 * DefaultLeftSpace)/7.0;
    NSArray *titles = @[@"日", @"一", @"二", @"三",
                        @"四", @"五", @"六"];
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace + i*weekW, 0, weekW, 47)];
        week.textAlignment = NSTextAlignmentCenter;
        week.textColor = LYZTheme_warmGreyFontColor;
        week.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0f];
        [weekTitlesView addSubview:week];
        week.text = titles[i];
    }
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kLineColor;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weekTitlesView.mas_bottom).mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    self.calederView = [[ZYCalendarView alloc] init];
    self.calederView.manager.canSelectPastDays = false;
    // 可以选择时间段
    self.calederView.manager.selectionType = ZYCalendarSelectionTypeSingle;
    // 设置当前日期
    self.calederView.date = self.enableDate;
    WEAKSELF;
    self.calederArray = [NSMutableArray array];
    self.calederView.dayViewBlock = ^(ZYCalendarManager *manager, NSDate *dayDate) {
        weakSelf.selectDate = dayDate;
        [weakSelf performSelector:@selector(optionCaleder) withObject:nil afterDelay:0.5];
    };
    [self.view addSubview:_calederView];
    
    [self.calederView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(weekTitlesView.mas_bottom).mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_HEIGHT- 128);
    }];
    
}

-(void )setEnableDate:(NSDate *)enableDate{
    _enableDate = enableDate;
    self.calederView.date = enableDate;
}



- (void)optionCaleder{
    
    self.optionCalederBlock(self.selectDate);
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (void)closeCaleder{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ConfigCaleder];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
