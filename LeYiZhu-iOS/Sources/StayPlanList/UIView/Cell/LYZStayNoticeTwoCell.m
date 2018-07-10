//
//  LYZStayNoticeTwoCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayNoticeTwoCell.h"
#import "UserStaysModel.h"
#import "UIView+SetRect.h"

@interface LYZStayNoticeTwoCell ()

@property (nonatomic, strong) UILabel *noticeLabel;

@end

//static CGFloat _stayPlanNoticeCellHeight = 35.0f;

@implementation LYZStayNoticeTwoCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 25, LYZStayNoticeTwoCell.cellHeight);
    self.width = SCREEN_WIDTH - 25;
}

- (void)buildSubview {
    self.backgroundColor = RGB(244, 244, 244);
    self.noticeLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(0,0, self.width ,LYZStayNoticeTwoCell.cellHeight)
     self.noticeLabel.textColor = LYZTheme_BrownishGreyFontColor;
    CGFloat noticeFont = iPhone5_5s ? 12 : 14;
     self.noticeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:noticeFont];
     self.noticeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.noticeLabel];
    
}

- (void)loadContent {
      UserStaysModel *model = (UserStaysModel *)self.data;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter_1  = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"MM月dd日"];
    
    //NSString转NSDate
   
    NSDate *checkoutDate = [formatter dateFromString:model.checkOutDate];
    NSString *checkout_str = [formatter_1 stringFromDate:checkoutDate];
    NSString *checkoutTime = [model.lastcheckouttime substringToIndex:5];
     self.noticeLabel.text = [NSString stringWithFormat:@"请在%@%@前退房",checkout_str,checkoutTime];
    [self.noticeLabel sizeToFit];
    [self layoutSubviews];
}

-(void)layoutSubviews{
    self.noticeLabel.centerX = self.width /2.0;
    self.noticeLabel.centerY = self.height /2.0;
}

- (void)selectedEvent {
    
    
}

#pragma mark - class property.

//+ (void)setCellHeight:(CGFloat)cellHeight {
//
//    _stayPlanNoticeCellHeight = cellHeight;
//}
//
//+ (CGFloat)cellHeight {
//
//    return _stayPlanNoticeCellHeight;
//}


@end
