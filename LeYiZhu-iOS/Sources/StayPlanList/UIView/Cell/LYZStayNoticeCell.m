//
//  LYZNoticeCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayNoticeCell.h"
#import "UIView+SetRect.h"

//static CGFloat _stayPlanNoticeCellHeight = 35.0;

@implementation LYZStayNoticeCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 25, LYZStayNoticeCell.cellHeight);
    self.width = SCREEN_WIDTH - 25;
}

- (void)buildSubview {
    self.backgroundColor = RGB(244, 244, 244);
    UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.width ,0.052 *SCREEN_HEIGHT )];
    notice.textColor = LYZTheme_BrownishGreyFontColor;
    CGFloat noticeFont = iPhone5_5s ? 12 : 14;
    notice.font = [UIFont fontWithName:LYZTheme_Font_Regular size:noticeFont];
    notice.textAlignment = NSTextAlignmentCenter;
    notice.text = @"入住流程";
    [self addSubview:notice];
    
}

- (void)loadContent {
    
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
