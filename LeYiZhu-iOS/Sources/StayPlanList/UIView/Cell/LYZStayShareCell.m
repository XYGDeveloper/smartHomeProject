//
//  LYZStayShareCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayShareCell.h"
#import "UIView+SetRect.h"

//static CGFloat _stayPlanShareCellHeight = 50.0f;

@implementation LYZStayShareCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 25, LYZStayShareCell.cellHeight);
    self.width = SCREEN_WIDTH - 25;
}

- (void)buildSubview {
    UILabel *shareBtn =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.072 * SCREEN_HEIGHT)];
    shareBtn.backgroundColor = LYZTheme_paleBrown;
    shareBtn.text = @"分享入住信息给好友";
    shareBtn.textColor = [UIColor whiteColor];
    CGFloat shareFont = iPhone5_5s ? 14 : 16;
    shareBtn.font = [UIFont fontWithName:LYZTheme_Font_Regular size:shareFont];
    shareBtn.textAlignment = NSTextAlignmentCenter;
    [self addSubview:shareBtn];
}

- (void)loadContent {
    
}

- (void)selectedEvent {
    
    
}

#pragma mark - class property.

//+ (void)setCellHeight:(CGFloat)cellHeight {
//
//    _stayPlanShareCellHeight = cellHeight;
//}
//
//+ (CGFloat)cellHeight {
//
//    return _stayPlanShareCellHeight;
//}


@end
