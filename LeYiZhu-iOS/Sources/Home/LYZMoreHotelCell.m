//
//  LYZMoreHotelCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/20.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZMoreHotelCell.h"

static CGFloat _moreInfoHotelCellHeight = 50.0f;

@implementation LYZMoreHotelCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = LYZTheme_paleBrown;
    [self addSubview:line];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, LYZMoreHotelCell.cellHeight)];
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    titleLabel.textColor = LYZTheme_paleBrown;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"了解更多";
    
    [self addSubview:titleLabel];
    
}


- (void)loadContent {
   
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _moreInfoHotelCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _moreInfoHotelCellHeight;
}


@end
