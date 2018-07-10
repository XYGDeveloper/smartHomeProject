//
//  LYZRenewMoneyDetailCommonCell.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/4/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRenewMoneyDetailCommonCell.h"
#import "UIView+SetRect.h"

@interface LYZRenewMoneyDetailCommonCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

static CGFloat _RenewMoneyCommonCellHeight = 50.0f;

@implementation LYZRenewMoneyDetailCommonCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(DefaultLeftSpace, 0, 100, LYZRenewMoneyDetailCommonCell.cellHeight)
    CGFloat titleFont = iPhone5_5s ? 15.0f : 16.0f;
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:titleFont];
    self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.titleLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 100, 0, 100, LYZRenewMoneyDetailCommonCell.cellHeight)
    CGFloat moneyFont = iPhone5_5s ? 14.0f : 15.0f;
    self.moneyLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:moneyFont];
    self.moneyLabel.textColor = LYZTheme_BrownishGreyFontColor;
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.moneyLabel];
}

- (void)loadContent {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self.data;
        self.titleLabel.text = [dic objectForKey:@"title"];
        self.moneyLabel.text = [dic objectForKey:@"money"];
        [self.titleLabel sizeToFit];
        [self.moneyLabel sizeToFit];
        [self layoutSubviews];
    }
    
}

-(void)layoutSubviews{
    self.titleLabel.x = 0.053 * SCREEN_WIDTH;
    self.titleLabel.centerY = self.height / 2.0;
    
    self.moneyLabel.right = SCREEN_WIDTH * (1 - 0.053);
     self.moneyLabel.centerY = self.height / 2.0;
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _RenewMoneyCommonCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _RenewMoneyCommonCellHeight;
}


@end
