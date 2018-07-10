//
//  paymentDateCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "paymentDetailCommonCell.h"
#import "UIView+SetRect.h"


@interface paymentDetailCommonCell ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation paymentDetailCommonCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.leftLabel.textColor = LYZTheme_warmGreyFontColor;
    CGFloat font = iPhone5_5s ? 13 : 15;
    self.leftLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:font];
    [self addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.rightLabel.textColor = LYZTheme_warmGreyFontColor;
    self.rightLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:font];
    [self addSubview:self.rightLabel];
   
}

- (void)loadContent {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self.data;
        self.leftLabel.text = dic[@"left"];
        self.rightLabel.text = dic[@"right"];
        [self.leftLabel sizeToFit];
        [self.rightLabel sizeToFit];
    }
    [self layoutSubviews];
}

-(void)layoutSubviews{
    
    self.leftLabel.x =  DefaultLeftSpace;
    self.leftLabel.centerY = self.height / 2.0;
    
    self.rightLabel.right = SCREEN_WIDTH - DefaultLeftSpace;
    self.rightLabel.centerY = self.height /2.0;
}

- (void)selectedEvent {
    
}

@end
