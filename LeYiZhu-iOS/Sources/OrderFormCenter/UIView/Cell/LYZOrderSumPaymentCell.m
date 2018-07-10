//
//  LYZOrderSumPaymentCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderSumPaymentCell.h"
#import "BaseOrderDetailModel.h"
#import "LYZOrderFormViewController.h"
#import "UIView+SetRect.h"

@interface LYZOrderSumPaymentCell ()

@property(nonatomic, strong) UILabel *sumPaymentLabel;

@end

static CGFloat _OrderSumPaymentCellHeight = 48.0f;

@implementation LYZOrderSumPaymentCell


- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace , 0, 90, LYZOrderSumPaymentCell.cellHeight )];
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    titleLabel.textColor = LYZTheme_warmGreyFontColor;
    titleLabel.text = @"订单总额";
    [self addSubview:titleLabel];
    
    self.sumPaymentLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right  , 0, 90, LYZOrderSumPaymentCell.cellHeight )];
    self.sumPaymentLabel.font = [UIFont fontWithName:LYZTheme_Font_Bold size:16];
    self.sumPaymentLabel.textColor = LYZTheme_paleBrown;
    [self addSubview:self.sumPaymentLabel];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -DefaultLeftSpace -10  , (LYZOrderSumPaymentCell.cellHeight -10)/2.0, 10, 10)];
    imgView.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:imgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 48);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    subtitleLabel.textColor = RGB(51, 51, 51);
    subtitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    subtitleLabel.text = @"明细";
    [subtitleLabel sizeToFit];
    subtitleLabel.right = imgView.x - 8;
    subtitleLabel.centerY = LYZOrderSumPaymentCell.cellHeight / 2.0;
    [self addSubview:subtitleLabel];
}


- (void)loadContent {
 
    if ([self.data isKindOfClass:[BaseOrderDetailModel class]]) {
        BaseOrderDetailModel *model = (BaseOrderDetailModel *)self.data;
        self.sumPaymentLabel.text = [NSString stringWithFormat:@"￥%@",model.orderJson.actualPayment];
    }
}


- (void)selectedEvent {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:@"paymentDetail"];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderSumPaymentCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderSumPaymentCellHeight;
}

#pragma mark - Btn Action

-(void)btnClick:(id)sender{
    LYZOrderFormViewController *vc = (LYZOrderFormViewController *)self.controller;
    if ([vc respondsToSelector:@selector(showPaymentDetail)]) {
        [vc showPaymentDetail];
    }
}

-(void)dealloc{
    LYLog(@"dealloc");
}

@end
