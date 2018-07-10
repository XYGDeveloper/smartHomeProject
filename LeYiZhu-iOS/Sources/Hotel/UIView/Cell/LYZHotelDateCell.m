//
//  LYZHotelDateCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZHotelDateCell.h"
#import "NSDate+Formatter.h"
#import "LYZHotelViewController.h"
#import "NSDate+Utilities.h"
#import "Masonry.h"
@interface LYZHotelDateCell ()

@property (nonatomic, strong) UILabel *checkinDateLabel;

@property (nonatomic, strong) UILabel *checkoutDateLabel;

@property (nonatomic, strong) UILabel *totalNightLabel;

@property (nonatomic, strong) UIImageView *arrowView;

@end

@implementation LYZHotelDateCell

static CGFloat _OrderHotelDateHeight = 72.5f;

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
//
//    if ([[LSTimeSlot sharedTimeSlot] isStockTradingBeginHour:00 andBeginMinus:00 andEndHour:6 andEndMinus:00 andIsEarlyBack:NO andEarlyBackMinus:0]) {
//
//        UILabel *checkInLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 40, LYZHotelDateCell.cellHeight/3.0)];
//        checkInLabel.textColor = LYZTheme_warmGreyFontColor;
//        checkInLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
//        checkInLabel.text = @"入住";
//        [self addSubview:checkInLabel];
//
//        UILabel *checkOutLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 40, LYZHotelDateCell.cellHeight/3.0)];
//        checkOutLabel.textColor = LYZTheme_warmGreyFontColor;
//        checkOutLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
//        checkOutLabel.text = @"退房";
//        [self addSubview:checkOutLabel];
//        self.checkinDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace,  checkInLabel.bottom - 3, 160 -DefaultLeftSpace,   LYZHotelDateCell.cellHeight/3.0)];
//        [self addSubview:self.checkinDateLabel];
//
//        self.checkoutDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, self.checkinDateLabel.y, 160 -DefaultLeftSpace, LYZHotelDateCell.cellHeight/3.0)];
//        [self addSubview:self.checkoutDateLabel];
//
//        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 15 ,(LYZHotelDateCell.cellHeight - 15)/3.0  , 15, 15)];
//        arrowImg.image = [UIImage imageNamed:@"hotle_icon_show"];
//        [self addSubview:arrowImg];
//
//        self.totalNightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        self.totalNightLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
//        self.totalNightLabel.textColor = LYZTheme_paleBrown;
//        [self addSubview:self.totalNightLabel];
//        //凌晨时段提醒
//        _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.checkinDateLabel.y + LYZHotelDateCell.cellHeight/3.0, kScreenWidth, LYZHotelDateCell.cellHeight/3.0 + 3)];
//        _arrowView.image = [UIImage imageNamed:@"warm"];
//        UILabel *warmLabel = [[UILabel alloc]init];
//        warmLabel.text = @"凌晨时段,系统默认时间选择为前一天晚上,如不合适,请重新调整时间";
//        warmLabel.textColor = [UIColor whiteColor];
//        warmLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:11.0];
//        [self.arrowView addSubview:warmLabel];
//        [warmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(DefaultLeftSpace);
//            make.centerY.mas_equalTo(self.arrowView.mas_centerY).mas_equalTo(4);
//            make.right.mas_equalTo(-20);
//            make.height.mas_equalTo(LYZHotelDateCell.cellHeight/3.0);
//        }];
//        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [closeButton setImage:[UIImage imageNamed:@"closeImage"] forState:UIControlStateNormal];
//        [self.arrowView addSubview:closeButton];
//        [closeButton addTarget:self action:@selector(closeWarm) forControlEvents:UIControlEventTouchUpInside];
//        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-5);
//            make.centerY.mas_equalTo(self.arrowView.mas_centerY).mas_equalTo(4);
//            make.width.height.mas_equalTo(20);
//        }];
//
//        //    _arrowView.layer.mask = arrowLayer;
//        [self addSubview:self.arrowView];
//
//    }else{
    
        UILabel *checkInLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 40, LYZHotelDateCell.cellHeight/2.0)];
        checkInLabel.textColor = LYZTheme_warmGreyFontColor;
        checkInLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
        checkInLabel.text = @"入住";
        [self addSubview:checkInLabel];
        
        UILabel *checkOutLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 40, LYZHotelDateCell.cellHeight/2.0)];
        checkOutLabel.textColor = LYZTheme_warmGreyFontColor;
        checkOutLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
        checkOutLabel.text = @"退房";
        [self addSubview:checkOutLabel];
        
        self.checkinDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace,  checkInLabel.bottom - 3, 160 -DefaultLeftSpace,   LYZHotelDateCell.cellHeight/2.0)];
        [self addSubview:self.checkinDateLabel];
        
        self.checkoutDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, self.checkinDateLabel.y, 160 -DefaultLeftSpace, LYZHotelDateCell.cellHeight/2.0)];
        [self addSubview:self.checkoutDateLabel];
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 15 ,(LYZHotelDateCell.cellHeight - 15)/2.0  , 15, 15)];
        arrowImg.image = [UIImage imageNamed:@"hotle_icon_show"];
        [self addSubview:arrowImg];
        self.totalNightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.totalNightLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
        self.totalNightLabel.textColor = LYZTheme_paleBrown;
        [self addSubview:self.totalNightLabel];
//
//    }
}

- (void)closeWarm{
    
}

- (void)loadContent {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self.data;
        NSDate *checkinDate = [dic objectForKey:@"checkIn"];
        NSDate *checkOutDate = [dic objectForKey:@"checkOut"];
        NSString *checkInStr = [checkinDate dateWithFormat:@"MM月dd日"];
        NSString *checkOutStr = [checkOutDate dateWithFormat:@"MM月dd日"];
        NSString *checkinWeek = [self getweekDayWithDate:checkinDate];
        NSString *checkoutWeek = [self getweekDayWithDate:checkOutDate];
        
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:17]};
        NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_warmGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:11]};

        NSString *str_checkin = [NSString stringWithFormat:@"%@ %@",checkInStr,checkinWeek];
        NSMutableAttributedString *attri_checkin = [[NSMutableAttributedString alloc] initWithString:str_checkin];
        [attri_checkin addAttributes:attriBute1 range:NSMakeRange(0, checkInStr.length)];
        [attri_checkin addAttributes:attriBute2 range:NSMakeRange(checkInStr.length, str_checkin.length - checkInStr.length)];
        self.checkinDateLabel.attributedText = attri_checkin;
        
        NSString *str_checkout = [NSString stringWithFormat:@"%@ %@",checkOutStr,checkoutWeek];
        NSMutableAttributedString *attri_checkout = [[NSMutableAttributedString alloc] initWithString:str_checkout];
        [attri_checkout addAttributes:attriBute1 range:NSMakeRange(0, checkOutStr.length)];
        [attri_checkout addAttributes:attriBute2 range:NSMakeRange(checkOutStr.length, str_checkout.length - checkOutStr.length)];
        self.checkoutDateLabel.attributedText = attri_checkout;
        
        NSInteger totalNight = [checkOutDate daysAfterDate:checkinDate];
        self.totalNightLabel.text = [NSString stringWithFormat:@"%li天",totalNight];
        [self.totalNightLabel sizeToFit];
        self.totalNightLabel.right = SCREEN_WIDTH - DefaultLeftSpace - 15 - 20;
        self.totalNightLabel.centerY = _OrderHotelDateHeight/2.0;
    }
}

-(void)orderRoom:(id)sender{
    
    LYZHotelViewController *vc = (LYZHotelViewController *)self.controller;
    if (self.data) {
        NSDictionary *dic = (NSDictionary *)self.data;
        HotelRoomsModel *model = (HotelRoomsModel *)dic[@"data"];
        [vc orderRoom:model];
    }
    
}



- (void)selectedEvent {
    _OrderHotelDateHeight = 72.5;
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
//    if ([[LSTimeSlot sharedTimeSlot] isStockTradingBeginHour:00 andBeginMinus:00 andEndHour:6 andEndMinus:00 andIsEarlyBack:NO andEarlyBackMinus:0]) {
//        cellHeight = 100.5;
        _OrderHotelDateHeight = cellHeight;
//    }else{
//        cellHeight = 100.5;
//        _OrderHotelDateHeight = cellHeight;
//    }
}

+ (CGFloat)cellHeight {
    return _OrderHotelDateHeight;
}

#pragma mark - Btn Action

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


//-(void)chooseDate:(UIButton *)sender{
//    LYZHotelViewController *vc = (LYZHotelViewController *)self.controller;
//    if ([vc respondsToSelector:@selector(datePick)]) {
//        [vc datePick];
//    }
//}

@end
