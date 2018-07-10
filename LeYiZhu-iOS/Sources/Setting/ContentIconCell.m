//
//  ContentIconCell.m
//  Animations
//
//  Created by YouXianMing on 2016/11/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ContentIconCell.h"
//#import "UIButton+inits.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"

@interface ContentIconCell ()

@property (nonatomic, strong) UIImageView    *iconImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIImageView *arrowNextImageView;

@end

@implementation ContentIconCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    self.iconImageView                        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.iconImageView.left                   = 15.f;
    self.iconImageView.userInteractionEnabled = NO;
    [self addSubview:self.iconImageView];
    
    self.titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, Width - 100.f, 35.f)];
    self.titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    self.titleLabel.font      = [UIFont fontWithName:@"KohinoorTelugu-Light" size:15.f];
    [self addSubview:self.titleLabel];
    
    self.contentLabel           = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 35.f)];
    self.contentLabel.textColor = LYZTheme_warmGreyFontColor;
    self.contentLabel.font      = [UIFont fontWithName:LYZTheme_Font_Light size:14.f];
    self.contentLabel.right = Width - 40;
    [self addSubview:self.contentLabel];
    self.arrowNextImageView       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indent_icon_show"]];
    self.arrowNextImageView.right = Width - 15.f;
    [self addSubview:self.arrowNextImageView];
    
    
}

- (void)loadContent {

    NSDictionary *dic = self.data;
    
    if ([dic isKindOfClass:[NSDictionary class]]) {
        
        self.iconImageView.hidden      = NO;
        self.titleLabel.hidden         = NO;
        self.arrowNextImageView.hidden = NO;
        
        self.iconImageView.centerY     = self.dataAdapter.cellHeight / 2.f;
        self.iconImageView.image = [UIImage imageNamed:dic[@"icon"]];
        
        self.titleLabel.centerY = self.dataAdapter.cellHeight / 2.f;
        self.titleLabel.text    = dic[@"title"];
        
        self.contentLabel.centerY = self.dataAdapter.cellHeight/2.f;
        self.contentLabel.text = dic[@"content"];
        
        self.arrowNextImageView.centerY = self.dataAdapter.cellHeight / 2.f;
        
    } else {
    
        self.iconImageView.hidden      = YES;
        self.titleLabel.hidden         = YES;
        self.arrowNextImageView.hidden = YES;
        
    }
}

- (void)selectedEvent {

    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:self.data];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

    [UIView animateWithDuration:0.35f delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
//        self.titleLabel.x        = highlighted ? 55.f : 50.f;
         self.titleLabel.x        = highlighted ? DefaultLeftSpace + 5 : DefaultLeftSpace;
        self.backgroundColor     = highlighted ? [[UIColor whiteColor] colorWithAlphaComponent:0.5f] : [UIColor whiteColor];
        self.iconImageView.scale = highlighted ? 0.95f : 1.f;
        
    } completion:nil];
}

@end
