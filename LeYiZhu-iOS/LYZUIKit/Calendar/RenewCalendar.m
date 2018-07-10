//
//  RenewCalendar.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/28.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "RenewCalendar.h"
#import "UIView+SetRect.h"
#import "FSCalendar.h"
#import "IICalendarCell.h"
#import "POP.h"
#import "UIView+UserInteraction.h"
#import <EventKit/EventKit.h>
#import "NSDate+Utilities.h"
#import "NSDate+Formatter.h"

#define kScale 0.88

@interface RenewCalendar()
<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *checkinDateLabel;
@property (nonatomic, strong) UILabel *checkoutDateLabel;
@property (nonatomic, strong) UILabel *totalNightLabel;
@property (nonatomic, strong) UILabel *noticeLabel;

@property (nonatomic, strong) FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

// The start date of the range
@property (strong, nonatomic) NSDate *date1;
// The end date of the range
@property (strong, nonatomic) NSDate *date2;
@property (strong, nonatomic) NSCache *cache;
@property (strong, nonatomic) NSArray<EKEvent *> *events;

- (void)configureCell:(__kindof FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position;

@end

@implementation RenewCalendar

-(void)show{
    if (self.contentView) {
        self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy-MM-dd";
        
        
        [self.contentView addSubview:self];
        self.contentViewUserInteractionEnabled == NO ? [self.contentView enabledUserInteraction] : 0;
        [self createBlackView];
        [self createCalendarView];
        [self loadCalendarEvents];
        
        //        self.date1 = [NSDate date];
        //        self.date2 = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:0];
        //
        //        [self.calendar selectDate:self.date1];
        //        [self.calendar selectDate:self.date2];
        //        [self configureVisibleCells];
        
    }
}

- (void)hide {
    if (self.contentView) {
        
        [self removeViews];
    }
}

- (void)removeViews {
    
    // 执行动画
    POPBasicAnimation  *annimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    annimation.fromValue             =  [NSValue valueWithCGRect:CGRectMake(0, 0.12 * SCREEN_HEIGHT, SCREEN_WIDTH, 0.88 *SCREEN_HEIGHT)];
    annimation.toValue            = [NSValue valueWithCGRect:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0.88 *SCREEN_HEIGHT)];
    annimation.duration            = 0.3f;
    [self.bgView pop_addAnimation:annimation forKey:nil];
    
    //    POPBasicAnimation  *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    //    alpha.toValue             = @(0.f);
    //    alpha.duration            = 0.2f;
    //    [self.blackView pop_addAnimation:alpha forKey:nil];
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.blackView.alpha       = 0.f;
        //        self.bgView.alpha     = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)createBlackView {
    
    self.blackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.8 *SCREEN_HEIGHT)];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha           = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    [tap addTarget:self action:@selector(hide)];
    [self.blackView addGestureRecognizer:tap];
    [self addSubview:self.blackView];
    POPBasicAnimation  *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alpha.toValue             = @(0.2f);
    alpha.duration            = 0.2f;
    [self.blackView pop_addAnimation:alpha forKey:nil];
    //    [UIView animateWithDuration:0.2f animations:^{
    //
    //        self.blackView.alpha = 0.3f;
    //
    //    } completion:^(BOOL finished) {
    //
    //
    //    }];
}

-(void)createCalendarView{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, SCREEN_HEIGHT *kScale)];
    self.bgView.backgroundColor = LYZTheme_BackGroundColor;
    [self addSubview:self.bgView];
    
    UILabel *checkinTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    checkinTitle.textColor = LYZTheme_warmGreyFontColor;
    checkinTitle.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    checkinTitle.text = @"续住时间";
    [checkinTitle sizeToFit];
    checkinTitle.centerX = SCREEN_WIDTH /4.0;
    checkinTitle.y = 18;
    [self.bgView addSubview:checkinTitle];
    
    UILabel *checkoutTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    checkoutTitle.textColor = LYZTheme_warmGreyFontColor;
    checkoutTitle.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    checkoutTitle.text = @"退房";
    [checkoutTitle sizeToFit];
    checkoutTitle.centerX = SCREEN_WIDTH * 3 /4.0;
    checkoutTitle.y = 18;
    [self.bgView addSubview:checkoutTitle];
    
    self.checkinDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, checkinTitle.bottom + 2, SCREEN_WIDTH/2.0, 30)];
    self.checkinDateLabel.textColor = [UIColor blackColor];
    self.checkinDateLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.checkinDateLabel];
    
    self.checkoutDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, self.checkinDateLabel.y, SCREEN_WIDTH/2.0, 30)];
    self.checkoutDateLabel.textColor = [UIColor blackColor];
    self.checkoutDateLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.checkoutDateLabel];
    
    self.totalNightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    self.totalNightLabel.centerX = SCREEN_WIDTH/2.0;
    self.totalNightLabel.centerY = SCREEN_HEIGHT * 0.11/2.0;
    self.totalNightLabel.textAlignment = NSTextAlignmentCenter;
    self.totalNightLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.totalNightLabel.textColor = LYZTheme_paleBrown;
    [self.bgView addSubview:self.totalNightLabel];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.11, SCREEN_WIDTH, 1)];
    line.backgroundColor = kLineColor;
    [self.bgView addSubview:line];
    
    CGFloat weekW = SCREEN_WIDTH  /7.0;
    NSArray *titles = @[@"周日", @"周一", @"周二", @"周三",
                        @"周四", @"周五", @"周六"];
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] initWithFrame:CGRectMake( i*weekW, line.bottom, weekW, SCREEN_HEIGHT *0.05)];
        week.textAlignment = NSTextAlignmentCenter;
        if ([titles[i] isEqualToString:@"周日"] || [titles[i] isEqualToString:@"周六"]) {
            week.textColor = [UIColor redColor];
        }else{
            week.textColor = RGB(58, 58, 58);
        }
        
        week.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0f];
        [self.bgView addSubview:week];
        week.text = titles[i];
    }
    
    //日历页面
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, line.bottom + SCREEN_HEIGHT *0.05, SCREEN_WIDTH, _bgView.height - 0.26 *SCREEN_HEIGHT)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.pagingEnabled = NO;
    calendar.allowsMultipleSelection = YES;
    calendar.rowHeight = 60;
    calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    calendar.appearance.titleDefaultColor = [UIColor blackColor];
    calendar.appearance.headerTitleColor = [UIColor blackColor];
    calendar.appearance.titleFont = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    calendar.appearance.subtitleFont = [UIFont fontWithName:LYZTheme_Font_Regular size:10];
    calendar.appearance.headerDateFormat = @"yyyy年MM月";
    calendar.weekdayHeight = 0;
    calendar.swipeToChooseGesture.enabled = YES;
    
    //mine
    //    calendar.appearance.titleOffset = CGPointMake(0, -25);
    calendar.appearance.subtitleOffset = CGPointMake(0, 20);
    calendar.appearance.eventOffset =  CGPointMake(0, 10);
    calendar.appearance.eventDefaultColor = [UIColor clearColor];
    calendar.appearance.eventSelectionColor = [UIColor clearColor];
    calendar.today = nil; // Hide the today circle
    [calendar registerClass:[IICalendarCell class] forCellReuseIdentifier:@"cell"];
    self.calendar = calendar;
    [self.bgView addSubview:calendar];
    
    RenewCalendarMessageObject *message = self.messageObject;
    //设置默认日期
    
    self.date1 =message.startDate ;
    self.date2 = [self.date1 dateByAddingDays:1];
    [self.calendar selectDate:self.date1];
    [self.calendar selectDate:self.date2];
    [self configureVisibleCells];
    [self refreshUI];
    
    //底部确定按钮
    UIView*bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bgView.height - 0.1 *SCREEN_HEIGHT , SCREEN_WIDTH, 0.1 *SCREEN_HEIGHT)];
    //    bottomView.backgroundColor =RGB(250, 250, 250);
    bottomView.backgroundColor = LYZTheme_BackGroundColor;
    [self.bgView addSubview:bottomView];
    
    UIView *line_bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line_bottom.backgroundColor = kLineColor;
    [bottomView addSubview:line_bottom];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, bottomView.height - 30);
    //    confirmBtn.center = bottomView.center;
    confirmBtn.layer.cornerRadius = 5.0f;
    confirmBtn.backgroundColor = RGB(65, 150, 253);
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:17];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:confirmBtn];
    
    
    // 执行动画
    POPBasicAnimation  *annimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    annimation.fromValue             = [NSValue valueWithCGRect:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kScale *SCREEN_HEIGHT)];
    annimation.toValue            = [NSValue valueWithCGRect:CGRectMake(0, (1-kScale) * SCREEN_HEIGHT, SCREEN_WIDTH, kScale *SCREEN_HEIGHT)];
    annimation.duration            = 0.3f;
    [self.bgView pop_addAnimation:annimation forKey:nil];
    
}






#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    RenewCalendarMessageObject *message = self.messageObject;
    NSString *now = [self.dateFormatter stringFromDate:message.startDate];
    return [self.dateFormatter dateFromString:now];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
     RenewCalendarMessageObject *message = self.messageObject;
    return [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:5 toDate:message.startDate options:0];
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @"今天";
    }else{
        EKEvent *event = [self eventsForDate:date].firstObject;
        if (event) {
            return event.title;
        }else{
            return nil;
        }
    }
    
    return nil;
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    IICalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

- (nullable NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date{
    
    NSString *date_str = [date dateWithFormat:@"yyyy-MM-dd"];
    NSString *date_from = [self.date1 dateWithFormat:@"yyyy-MM-dd"];
    NSString *date_to = [self.date2 dateWithFormat:@"yyyy-MM-dd"];
    
    if ([date_str isEqualToString:date_from] ) {
        return @"续住";
    }else if ([date_str isEqualToString:date_to]){
        return @"退房";
    }else{
        return nil;
    }
    
    //    if ([date compare:self.date1] == NSOrderedSame ) {
    //        return @"入住";
    //    }else if ([date compare:self.date2] == NSOrderedSame){
    //        return @"离店";
    //    }else{
    //        return nil;
    //    }
    
    //    if (date == self.date1 ) {
    //        return @"入住";
    //    }else if (date == self.date2){
    //        return @"离店";
    //    }else{
    //        return nil;
    //    }
}


#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return NO;
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    if (!self.events) return 0;
    NSArray<EKEvent *> *events = [self eventsForDate:date];
    return events.count;
}

//- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
//{
//
//    if ([self.gregorian isDateInToday:date]) {
//        return @[[UIColor orangeColor]];
//    }
//    return @[appearance.eventDefaultColor];
//}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    if (calendar.swipeToChooseGesture.state == UIGestureRecognizerStateChanged) {
        // If the selection is caused by swipe gestures
        if (!self.date1) {
            self.date1 = date;
        } else {
            if (self.date2) {
                [calendar deselectDate:self.date2];
            }
            self.date2 = date;
        }
    } else {
        if (!self.date2) {
            self.date2 = date;
        }else{
            [self.calendar deselectDate:self.date2];
            self.date2 = date;
        }
    }
    [self configureVisibleCells];
    [self.calendar reloadData];
    
    [self refreshUI];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
    [self configureVisibleCells];
}

//- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
//{
//    if ([self.gregorian isDateInToday:date]) {
//        return @[[UIColor orangeColor]];
//    }
//    return @[appearance.eventDefaultColor];
//}

#pragma mark - Private methods

- (void)configureVisibleCells
{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(__kindof FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position
{
    IICalendarCell *rangeCell = cell;
    if (position != FSCalendarMonthPositionCurrent) {
        rangeCell.middleLayer.hidden = YES;
        rangeCell.selectionLayer.hidden = YES;
        return;
    }
    if (self.date1 && self.date2) {
        // The date is in the middle of the range
        BOOL isMiddle = [date compare:self.date1] != [date compare:self.date2];
        rangeCell.middleLayer.hidden = !isMiddle;
    } else {
        rangeCell.middleLayer.hidden = YES;
    }
    BOOL isSelected = NO;
    isSelected |= self.date1 && [self.gregorian isDate:date inSameDayAsDate:self.date1];
    isSelected |= self.date2 && [self.gregorian isDate:date inSameDayAsDate:self.date2];
    rangeCell.selectionLayer.hidden = !isSelected;
}


#pragma mark - Btn Action

-(void)confirmBtnClick:(id)sender{
    if (self.date1 && self.date2) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageView:event:)]) {
            [self.delegate baseMessageView:self event:@[self.date1, self.date2]];
        }
    }
}

#pragma mark - Private

- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date{
    
    NSArray<EKEvent *> *events = [self.cache objectForKey:date];
    if ([events isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.occurrenceDate isEqualToDate:date];
    }]];
    if (filteredEvents.count) {
        [self.cache setObject:filteredEvents forKey:date];
    } else {
        [self.cache setObject:[NSNull null] forKey:date];
    }
    return filteredEvents;
}

- (void)loadCalendarEvents
{
    __weak typeof(self) weakSelf = self;
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        
        if(granted) {
            NSDate *startDate = [NSDate date];
            NSDate *endDate = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:5 toDate:[NSDate date] options:0];
            NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
            NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
            NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
                return event.calendar.subscribed;
            }]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!weakSelf) return;
                weakSelf.events = events;
                [weakSelf.calendar reloadData];
            });
            
        } else {
            
            
        }
    }];
    
}
#pragma mark - UI

-(void)refreshUI{
    NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:15]};
    NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_warmGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:12]};
    if (self.date1) {
        NSString *checkInStr = [self.date1 dateWithFormat:@"MM月dd日"];
        NSString *checkinWeek = [self getweekDayWithDate:self.date1];
        NSString *str_checkin = [NSString stringWithFormat:@"%@ %@",checkInStr,checkinWeek];
        NSMutableAttributedString *attri_checkin = [[NSMutableAttributedString alloc] initWithString:str_checkin];
        [attri_checkin addAttributes:attriBute1 range:NSMakeRange(0, checkInStr.length)];
        [attri_checkin addAttributes:attriBute2 range:NSMakeRange(checkInStr.length, str_checkin.length - checkInStr.length)];
        self.checkinDateLabel.attributedText = attri_checkin;
        if (!self.date2) {
            self.totalNightLabel.text = nil;
            self.checkoutDateLabel.text = nil;
        }
    }
    
    if (self.date2) {
        NSString *checkOutStr = [self.date2 dateWithFormat:@"MM月dd日"];
        NSString *checkoutWeek = [self getweekDayWithDate:self.date2];
        NSString *str_checkout = [NSString stringWithFormat:@"%@ %@",checkOutStr,checkoutWeek];
        NSMutableAttributedString *attri_checkout = [[NSMutableAttributedString alloc] initWithString:str_checkout];
        [attri_checkout addAttributes:attriBute1 range:NSMakeRange(0, checkOutStr.length)];
        [attri_checkout addAttributes:attriBute2 range:NSMakeRange(checkOutStr.length, str_checkout.length - checkOutStr.length)];
        self.checkoutDateLabel.attributedText = attri_checkout;
    }
    if (self.date1 && self.date2) {
        NSInteger totalNight = [self.date2 daysAfterDate:self.date1];
        self.totalNightLabel.text = [NSString stringWithFormat:@"%li天",totalNight];
    }
    
    
    
}


#pragma mark - Memory warnning

- (void)didReceiveMemoryWarning{
    
    [self.cache removeAllObjects];
}

- (id) getweekDayWithDate:(NSDate *) date
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSInteger week = [comps weekday];
    NSString *weekStr;
    // 1 是周日，2是周一 3.以此类推
    switch (week) {
        case 1:
            weekStr = @"周日";
            break;
        case 2:
            weekStr = @"周一";
            break;
        case 3:
            weekStr = @"周二";
            break;
        case 4:
            weekStr = @"周三";
            break;
        case 5:
            weekStr = @"周四";
            break;
        case 6:
            weekStr = @"周五";
            break;
        case 7:
            weekStr = @"周六";
        default:
            break;
    }
    return weekStr;
}

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


@end

#pragma mark - RenewCalendarMessageObject

@implementation RenewCalendarMessageObject

@end
