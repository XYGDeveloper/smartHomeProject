//
//  LYZCalederViewController.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2017/3/15.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZCalederViewController.h"
#import "Masonry.h"
#import "NSDate+Utilities.h"

@interface LYZCalederViewController ()

@property (nonatomic, strong) NSDate *fromDate;
@property (nonatomic, strong) NSDate *toDate;

@end

@implementation LYZCalederViewController

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
    self.titleLabel.text = @"请选择入住日期";
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
    self.calederView.manager.selectionType = ZYCalendarSelectionTypeRange;
    // 设置当前日期

    if ([self isBetweenFromHour:0 toHour:6]) {
        self.calederView.date = [NSDate dateYesterday];
    }else{
         self.calederView.date = [NSDate date];
    }
   
    WEAKSELF;
    self.calederArray = [NSMutableArray array];
    self.calederView.dayViewBlock = ^(ZYCalendarManager *manager, NSDate *dayDate) {
        if (weakSelf.fromDate) {
            if ([IICommons compareOneDay:dayDate withAnotherDay:weakSelf.fromDate] <= 0) {
                weakSelf.fromDate = dayDate;
            }else{
                weakSelf.toDate = dayDate;
            }
        }else{
            weakSelf.fromDate = dayDate;
            [weakSelf.titleLabel setText:@"请选择退房日期"];
        }
        if (weakSelf.fromDate && weakSelf.toDate) {
             [weakSelf.calederArray addObject:weakSelf.fromDate];
            [weakSelf.calederArray addObject:weakSelf.toDate];
              [weakSelf performSelector:@selector(optionCaleder) withObject:nil afterDelay:0.5];
        }
    };
    [self.view addSubview:_calederView];
    
    [self.calederView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(weekTitlesView.mas_bottom).mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_HEIGHT- 128);
    }];
    
}

- (void)optionCaleder{

     self.optionCalederBlock(self.calederArray);
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

#pragma mark - Private

/**
 * @brief 判断当前时间是否在fromHour和toHour之间。如，fromHour=8，toHour=23时，即为判断当前时间是否在8:00-23:00之间
 */
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour {
    
    NSDate *dateFrom = [self getCustomDateWithHour:fromHour];
    NSDate *dateTo = [self getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    if ([currentDate compare:dateFrom]==NSOrderedDescending && [currentDate compare:dateTo]==NSOrderedAscending) {
        // 当前时间在9点和10点之间
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour {
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    return [resultCalendar dateFromComponents:resultComps];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
