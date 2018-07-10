//
//  LYZHotelCommonTitleCell.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 2017/11/23.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZHotelCommonTitleCell.h"
#import "UIView+SetRect.h"

@interface LYZHotelCommonTitleCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subtitleLabel;

@property (nonatomic, strong) UILabel *moreLabel;

@end

static CGFloat _titleCellHeight = 45.5f;

@implementation LYZHotelCommonTitleCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subtitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    self.subtitleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.subtitleLabel];
    
    self.moreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.moreLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.moreLabel.textColor = LYZTheme_paleBrown;
    [self addSubview:self.moreLabel];
}


- (void)loadContent {
    NSDictionary *dic = (NSDictionary *)self.data;
    self.titleLabel.text = dic[@"title"];
    [self.titleLabel sizeToFit];
    self.titleLabel.x = DefaultLeftSpace;
    self.titleLabel.centerY = _titleCellHeight/2.0;
    
    self.subtitleLabel.text = dic[@"subtitle"];
    [self.subtitleLabel sizeToFit];
    self.subtitleLabel.x = self.titleLabel.right + 5;
    self.subtitleLabel.centerY = _titleCellHeight/2.0;
    if ([dic[@"title"]isEqualToString:@"选择房型"]) {
        self.moreLabel.text = @"左右滑动，查看更多房型";
    }
    [self.moreLabel sizeToFit];
    self.moreLabel.x = self.subtitleLabel.right + 5;
    self.moreLabel.centerY = _titleCellHeight/2.0;
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _titleCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _titleCellHeight;
}


@end
