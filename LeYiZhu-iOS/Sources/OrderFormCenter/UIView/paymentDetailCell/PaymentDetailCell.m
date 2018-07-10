//
//  PaymentDetailCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "PaymentDetailCell.h"
#import "UIView+SetRect.h"
@interface PaymentDetailCell ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation PaymentDetailCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)buildSubview {
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.rightLabel];
    
}

- (void)loadContent {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self.data;
        self.leftLabel.text = dic[@"leftContent"];
        self.leftLabel.textColor = dic[@"leftColor"];
        NSNumber *leftFont = dic[@"leftFont"];
        self.leftLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:leftFont.floatValue];
        [self.leftLabel sizeToFit];
        
        self.rightLabel.text = dic[@"rightContent"];
        self.rightLabel.textColor = dic[@"rightColor"];
        NSNumber *rightFont = dic[@"rightFont"];
        self.rightLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:rightFont.floatValue];
        [self.rightLabel sizeToFit];
        
        [self layoutSubviews];
    }
}

-(void)layoutSubviews{
    self.leftLabel.x = DefaultLeftSpace;
    self.leftLabel.centerY = self.height /2.0;
    
    self.rightLabel.right = SCREEN_WIDTH - DefaultLeftSpace;
    self.rightLabel.centerY = self.height / 2.0;
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:self.data];
    }
}




@end
