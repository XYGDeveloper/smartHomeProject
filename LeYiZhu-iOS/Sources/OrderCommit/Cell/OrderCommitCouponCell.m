//
//  OrderCommitCouponCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/3.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "OrderCommitCouponCell.h"
#import "OrderCommitCellMarcos.h"
#import "PreFillCouponModel.h"
#import "LYZOrderCommitViewController.h"
#import "LYZRenewViewController.h"

@interface OrderCommitCouponCell ()

@property (nonatomic, strong) UILabel *couponLabel;
@property (nonatomic, strong) UIButton *couponBtn;

@end

static CGFloat _OrderCouponCellHeight = 47.0f;

@implementation OrderCommitCouponCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    UILabel *couponTitltLabel =  [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, OrderCommitCouponCell.cellHeight)];
    couponTitltLabel.textColor = LYZTheme_warmGreyFontColor;
    couponTitltLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14.0f];
    couponTitltLabel.text = @"优惠券";
    [self addSubview:couponTitltLabel];
    
    
    self.couponLabel =  [[UILabel alloc] initWithFrame:CGRectMake(couponTitltLabel.right +  kTitle_Content_Space, 0, 160, OrderCommitCouponCell.cellHeight)];
    self.couponLabel.textColor = LYZTheme_paleBrown;
    self.couponLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0f];
    [self addSubview:self.couponLabel];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kTitle_Content_Space - 10, (OrderCommitCouponCell.cellHeight  - 10) /2.0, 10, 10)];
    img.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:img];
    
    self.couponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.couponBtn.frame = CGRectMake(couponTitltLabel.right +  kTitle_Content_Space, 0, SCREEN_WIDTH - couponTitltLabel.right -  kTitle_Content_Space, OrderCommitCouponCell.cellHeight);
    [self.couponBtn addTarget:self action:@selector(chooseCoupon:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.couponBtn];

}


- (void)loadContent {
    self.couponBtn.enabled = YES;
    PreFillCouponModel *model = (PreFillCouponModel *)self.data;
    NSString *coupon;
    if (model.coupontype.integerValue == 0) {
        coupon = @"没有可使用的优惠券";
        self.couponBtn.enabled = NO;
    }else if (model.coupontype.integerValue == 1 || model.coupontype.integerValue == 2) {
        //现金券
        coupon = model.couponName;
    }else{
         coupon = @"不使用优惠券";
    }
    self.couponLabel.text =coupon;
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _OrderCouponCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderCouponCellHeight;
}

#pragma mark - btn actions

-(void)chooseCoupon:(UIButton *)sender{
    if ([self.controller isKindOfClass:[LYZOrderCommitViewController class]]) {
        LYZOrderCommitViewController *vc = (LYZOrderCommitViewController *)self.controller;
        if ([vc respondsToSelector:@selector(chooseCoupon)]) {
            [vc chooseCoupon];
        }
    }
    
    if ([self.controller isKindOfClass:[LYZRenewViewController class]]) {
        LYZRenewViewController *vc = (LYZRenewViewController *)self.controller;
        if ([vc respondsToSelector:@selector(chooseCoupon)]) {
            [vc chooseCoupon];
        }
    }

    
    
}


@end
