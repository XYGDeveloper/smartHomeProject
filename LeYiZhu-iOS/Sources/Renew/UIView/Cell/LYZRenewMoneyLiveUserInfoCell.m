//
//  LYZRenewMoneyLiveUserInfoCell.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/4/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRenewMoneyLiveUserInfoCell.h"
#import "UIView+SetRect.h"

#define kSpaceScale 0.12
#define kSpace (kSpaceScale * SCREEN_WIDTH)

@interface LYZRenewMoneyLiveUserInfoCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *liveDayLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@end

static CGFloat _RenewMoneyLiveUserCellHeight = 50.0f;

@implementation LYZRenewMoneyLiveUserInfoCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(DefaultLeftSpace, 0, 100, LYZRenewMoneyLiveUserInfoCell.cellHeight)
    CGFloat titleFont = iPhone5_5s ? 13.0f : 14.0f;
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:titleFont];
    self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.titleLabel];
    
    self.liveDayLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(self.titleLabel.right + kSpace, 0, 100, LYZRenewMoneyLiveUserInfoCell.cellHeight)
    self.liveDayLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:titleFont];
    self.liveDayLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.liveDayLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(SCREEN_WIDTH * 0.8, 0, 100, LYZRenewMoneyLiveUserInfoCell.cellHeight)
    self.moneyLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:titleFont];
    self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    self.moneyLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.moneyLabel];
}

- (void)loadContent {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self.data;
        self.titleLabel.text = [dic objectForKey:@"title"];
        self.moneyLabel.text = [dic objectForKey:@"money"];
        self.liveDayLabel.text = [dic objectForKey:@"detail"];
        
        [self.titleLabel sizeToFit];
        [self.moneyLabel sizeToFit];
        [self.liveDayLabel sizeToFit];
        
        [self layoutSubviews];
        
    }
}

-(void)layoutSubviews{
    self.titleLabel.x = 0.053 * SCREEN_WIDTH;
    self.titleLabel.centerY = self.height /2.0;
    
    self.liveDayLabel.x = 0.432 * SCREEN_WIDTH;
    self.liveDayLabel.centerY = self.height /2.0;
    
    self.moneyLabel.right = SCREEN_WIDTH - 0.053 * SCREEN_WIDTH;
    self.moneyLabel.centerY = self.height /2.0;
    
}



- (void)selectedEvent {
    
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _RenewMoneyLiveUserCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _RenewMoneyLiveUserCellHeight;
}

@end
