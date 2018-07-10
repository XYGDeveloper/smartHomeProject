//
//  LYZStayHotelInfoCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayHotelInfoCell.h"
#import "UserStaysModel.h"
#import "UIView+SetRect.h"

@interface LYZStayHotelInfoCell  ()

@property (nonatomic, strong) UILabel *hotelNameLabel;
@property (nonatomic, strong) UILabel *roomTypeLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

//static CGFloat _stayPlanHotelInfoCellHeight = 96.0f;

@implementation LYZStayHotelInfoCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 25, LYZStayHotelInfoCell.cellHeight);
    self.width = SCREEN_WIDTH - 25;
}

- (void)buildSubview {
    self.hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(0, 12, self.width,22)
    self.hotelNameLabel.textColor = [UIColor blackColor];
    CGFloat hotelNameFont = iPhone5_5s ? 14 : 16;
    self.hotelNameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:hotelNameFont];
    self.hotelNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.hotelNameLabel];
    
    self.roomTypeLabel =[[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(0, self.hotelNameLabel.bottom + 4, self.width,20)
    self.roomTypeLabel.textColor = LYZTheme_BrownishGreyFontColor;
    CGFloat roomTypeFont = iPhone5_5s ? 12 : 14;
    self.roomTypeLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:roomTypeFont];
    self.roomTypeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.roomTypeLabel];
    
    self.dateLabel =[[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(0, self.roomTypeLabel.bottom + 4, self.width,20)
    self.dateLabel.textColor = LYZTheme_BrownishGreyFontColor;
    CGFloat dateFont = iPhone5_5s ? 12 : 14;
    self.dateLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:dateFont];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.dateLabel];
    
    
}

- (void)loadContent {
    UserStaysModel *model = (UserStaysModel *)self.data;
    self.hotelNameLabel.text = model.hotelName;
    [self.hotelNameLabel sizeToFit];
    
    self.roomTypeLabel.text = model.roomType;
    [self.roomTypeLabel sizeToFit];
    
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter_1  = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"MM月dd日"];
    
    //NSString转NSDate
    NSDate *checkinDate=[formatter dateFromString:model.checkInDate];
    NSDate *checkoutDate = [formatter dateFromString:model.checkOutDate];
    NSString *checkin_str = [formatter_1 stringFromDate:checkinDate];
    NSString *checkout_str = [formatter_1 stringFromDate:checkoutDate];
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",checkin_str, checkout_str];
    [self.dateLabel sizeToFit];
    [self layoutSubviews];
}

-(void)layoutSubviews{
    
    CGFloat space =  iPhone5_5s ? 5 : 8;
    self.hotelNameLabel.centerX = self.width / 2.0;
    self.hotelNameLabel.y = 12;
    
    self.roomTypeLabel.centerX = self.width /2.0;
    self.roomTypeLabel.y = self.hotelNameLabel.bottom + space;
    
    self.dateLabel.centerX = self.width /2.0;
    self.dateLabel.y = self.roomTypeLabel.bottom + space;
}

- (void)selectedEvent {
    
    
}

#pragma mark - class property.

//+ (void)setCellHeight:(CGFloat)cellHeight {
//
//    _stayPlanHotelInfoCellHeight = cellHeight;
//}
//
//+ (CGFloat)cellHeight {
//
//    return _stayPlanHotelInfoCellHeight;
//}



@end
