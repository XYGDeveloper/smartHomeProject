//
//  LYZStayPlanDateCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayPlanDateCell.h"
#import "UserStaysModel.h"
#import "UIView+SetRect.h"

#define kLivedaysXScale 0.2
#define kLivedaysYScale 0.27


@interface LYZStayPlanDateCell ()

@property (nonatomic,strong) UILabel *checkinLabel;
@property (nonatomic,strong) UILabel *checkoutLabel;
@property (nonatomic, strong) UILabel *checkinDateLabel;
@property (nonatomic, strong) UILabel *checkoutDateLabel;
@property (nonatomic, strong) UILabel *liveDayLabel;
@property (nonatomic ,strong)  UILabel *noticeLabel;


@end

//static CGFloat _stayPlanDateCellHeight = 96.0;

@implementation LYZStayPlanDateCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.width = SCREEN_WIDTH - 25;
}

- (void)buildSubview {
    
    self.liveDayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    CGFloat liveDayFont = iPhone5_5s ? 12.0 : 14.0;
    self.liveDayLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:liveDayFont];
    self.liveDayLabel.textColor = LYZTheme_paleBrown;
    self.liveDayLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.liveDayLabel];
    
   self.checkinLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.checkinLabel.textColor = RGB(83, 83, 83);
    self.checkinLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat checkinTitleFont = iPhone5_5s ? 14.0 : 16.0;
    self.checkinLabel.font= [UIFont fontWithName:LYZTheme_Font_Regular size:checkinTitleFont];
    [self addSubview:self.checkinLabel];
    
    self.checkoutLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.checkoutLabel.textColor = RGB(83, 83, 83);
    self.checkoutLabel.textAlignment = NSTextAlignmentCenter;
    self.checkoutLabel.font= [UIFont fontWithName:LYZTheme_Font_Regular size:checkinTitleFont];
    [self addSubview:self.checkoutLabel];
    
    self.checkinDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.checkinDateLabel.textColor = [UIColor blackColor];
    CGFloat checkInDateFont = iPhone5_5s ? 18.0 : 20.0;
    self.checkinDateLabel.font= [UIFont fontWithName:LYZTheme_Font_Regular size:checkInDateFont];
    self.checkinDateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.checkinDateLabel];
    
    self.checkoutDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.checkoutDateLabel.textColor = [UIColor blackColor];
    self.checkoutDateLabel.textAlignment = NSTextAlignmentCenter;
    self.checkoutDateLabel.font= [UIFont fontWithName:LYZTheme_Font_Regular size:checkInDateFont];
    [self addSubview:self.checkoutDateLabel];
    
   
    
   self.noticeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.noticeLabel.textColor = LYZTheme_warmGreyFontColor;
     CGFloat noticeFont = iPhone5_5s ? 12.0 : 14.0;
    self.noticeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:noticeFont];
    self.noticeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.noticeLabel];
}

- (void)loadContent {
    
   
    
    self.checkinLabel.text = @"入住";
    [self.checkinLabel sizeToFit];
    
    self.checkoutLabel.text = @"退房";
    [self.checkoutLabel sizeToFit];
   
    
     self.noticeLabel.text = @"建议入住当日14点后在自助机办理入住手续";
    [self.noticeLabel sizeToFit];
   
    
    UserStaysModel *model = (UserStaysModel *)self.data;

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
    self.checkinDateLabel.text = checkin_str;
    [self.checkinDateLabel sizeToFit];
  
    self.checkoutDateLabel.text = checkout_str;
    [self.checkoutDateLabel sizeToFit];
 
    self.liveDayLabel.text = [NSString stringWithFormat:@"共%@天",model.liveDays];

    [self layoutSubviews];
}

-(void)layoutSubviews{
    self.liveDayLabel.width = SCREEN_WIDTH * kLivedaysXScale;
    self.liveDayLabel.height = self.height *kLivedaysYScale;
    self.liveDayLabel.centerX =self.width/2.0;
    self.liveDayLabel.centerY =  self.height/2.0 -  10;
    self.liveDayLabel.layer.borderColor = LYZTheme_paleBrown.CGColor;
    self.liveDayLabel.layer.borderWidth = 1.0;
    self.liveDayLabel.layer.cornerRadius =self.liveDayLabel.height/2.0;
    
    self.checkinLabel.bottom = self.liveDayLabel.centerY  -  5;
    self.checkinLabel.centerX = (self.width - self.liveDayLabel.width)/4.0;
    
    self.checkoutLabel.y = self.checkinLabel.y;
    self.checkoutLabel.centerX = self.width - self.checkinLabel.centerX;
    
    self.noticeLabel.centerX = self.liveDayLabel.centerX;
    self.noticeLabel.bottom = self.height - 5;
    
    self.checkinDateLabel.y = self.checkinLabel.bottom + 5;
    self.checkinDateLabel.centerX = self.checkinLabel.centerX;
    
    self.checkoutDateLabel.y = self.checkinDateLabel.y;
    self.checkoutDateLabel.centerX = self.checkoutLabel.centerX;

}

- (void)selectedEvent {
    

}

#pragma mark - class property.

//+ (void)setCellHeight:(CGFloat)cellHeight {
//    
//    _stayPlanDateCellHeight = cellHeight;
//}
//
//+ (CGFloat)cellHeight {
//    
//    return _stayPlanDateCellHeight;
//}



@end
