//
//  OrderCommitMoneyDetailView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderCommitMoneyDetailView.h"
#import "CountMoneyModel.h"
#import "UIView+SetRect.h"

#define kPayBtnScale 0.096
#define kLeftSpace  (0.093 * SCREEN_WIDTH)

#define kPayBtnWidth  (SCREEN_WIDTH * kPayBtnScale)

@interface OrderCommitMoneyDetailView ()

@property (nonatomic, strong) UILabel *accommodation_detail_label;
@property (nonatomic, strong) UILabel *deposit_detail_label;
@property (nonatomic, strong) UILabel *accommodation_totalM_label;
@property (nonatomic, strong) UILabel *deposit_totalM_label;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UILabel *couponLabel;
@property (nonatomic, strong) UILabel *discoutPriceLabel;

@end

@implementation OrderCommitMoneyDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *title_p = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 80, 47)];
        title_p.textColor = LYZTheme_BrownishGreyFontColor;
        CGFloat titleFont = iPhone5_5s ? 14 : 16;
        title_p.font = [UIFont fontWithName:LYZTheme_Font_Regular size:titleFont];
        title_p.text = @"住宿费";
        [self addSubview:title_p];
        
        _accommodation_detail_label = [[UILabel alloc] initWithFrame:CGRectMake(title_p.right + 20, 0, 200, 47)];
        _accommodation_detail_label.textColor =LYZTheme_BrownishGreyFontColor;
        _accommodation_detail_label.font = [UIFont fontWithName:LYZTheme_Font_Regular size:titleFont];
        [self addSubview:_accommodation_detail_label];
        
        _accommodation_totalM_label =  [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 100, 0, 100, 47)];
        _accommodation_totalM_label.textColor = LYZTheme_BrownishGreyFontColor;
        _accommodation_totalM_label.textAlignment = NSTextAlignmentRight;
        _accommodation_totalM_label.font = [UIFont fontWithName:LYZTheme_Font_Regular size:titleFont];
        [self addSubview:_accommodation_totalM_label];
        
        UILabel *couponTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, title_p.bottom, 80, 47)];
        couponTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:titleFont];
        couponTitleLabel.textColor = LYZTheme_BlackFontColorFontColor;
        couponTitleLabel.text = @"优惠券";
        [self addSubview:couponTitleLabel];
        
        _couponLabel = [[UILabel alloc] initWithFrame:CGRectMake(couponTitleLabel.right + 20, title_p.bottom, 200, 47)];
        _couponLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:titleFont];
        _couponLabel.textColor = LYZTheme_BlackFontColorFontColor;
        [self addSubview:_couponLabel];
        
        _discoutPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 100, title_p.bottom, 100, 47)];
        _discoutPriceLabel.textAlignment = NSTextAlignmentRight;
        _discoutPriceLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:titleFont];
        _discoutPriceLabel.textColor = LYZTheme_BlackFontColorFontColor;
        [self addSubview:_discoutPriceLabel];
    
        
        UILabel *title_d = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, couponTitleLabel.bottom, 80, 47)];
        title_d.textColor = LYZTheme_BrownishGreyFontColor;
        title_d.font = [UIFont fontWithName:LYZTheme_Font_Regular size:titleFont];
        title_d.text = @"押金";
        [self addSubview:title_d];
        
        _deposit_detail_label = [[UILabel alloc] initWithFrame:CGRectMake(title_d.right + 20, title_d.y, 200, 47)];
        _deposit_detail_label.textColor =LYZTheme_BrownishGreyFontColor;
        _deposit_detail_label.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
        [self addSubview:_deposit_detail_label];
   
        _deposit_totalM_label =  [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 100, title_d.y, 100, 47)];
        _deposit_totalM_label.textColor = LYZTheme_BrownishGreyFontColor;
        _deposit_totalM_label.textAlignment = NSTextAlignmentRight;
        _deposit_totalM_label.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
        [self addSubview:_deposit_totalM_label];
        
        UIView *shortLineView = [[UIView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, title_d.bottom, SCREEN_WIDTH - DefaultLeftSpace, 0.5)];
        shortLineView.backgroundColor = kLineColor;
        [self addSubview:shortLineView];
        
        UILabel *title_t =[[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, shortLineView.bottom, 100, 60)];
        title_t.textColor = LYZTheme_BrownishGreyFontColor;
        title_t.font = [UIFont fontWithName:LYZTheme_Font_Regular size:titleFont];
        title_t.text = @"支付金额";
        [self addSubview:title_t];
        
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 100, title_t.y, 100, 60)];
        _totalPriceLabel.textColor = [UIColor blackColor];
        _totalPriceLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:titleFont];
        _totalPriceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_totalPriceLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _totalPriceLabel.bottom, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = kLineColor;
        [self addSubview:line];
        
        UIImageView *wxImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPayBtnWidth, kPayBtnWidth)];
        wxImg.x = kLeftSpace;
        wxImg.centerY =line.bottom + (self.height - line.bottom)/2.0;
        wxImg.image = [UIImage imageNamed:@"pay_icon_weixin"];
        [self addSubview:wxImg];
        
        UILabel *wxLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(wxImg.right +8, wxImg.y, 100, kPayBtnWidth)
        wxLabel.textColor = [UIColor blackColor];
        CGFloat payFont = iPhone5_5s ? 16 : 18;
        wxLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:payFont];
        wxLabel.text = @"微信支付";
        [wxLabel sizeToFit];
        wxLabel.x = wxImg.right + 8;
        wxLabel.centerY = wxImg.centerY;
        [self addSubview:wxLabel];
        
        UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        wxBtn.frame = CGRectMake(0, line.bottom, SCREEN_WIDTH/2.0, self.height - line.bottom);
        [wxBtn addTarget:self action:@selector(wxPay:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:wxBtn];
        
        
        UILabel *AliLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        AliLabel.textColor = [UIColor blackColor];
        AliLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:payFont];
        AliLabel.text = @"支付宝支付";
        [AliLabel sizeToFit];
        AliLabel.right = SCREEN_WIDTH -  kLeftSpace;
        AliLabel.centerY = wxImg.centerY;
        [self addSubview:AliLabel];
        
        UIImageView *AliImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPayBtnWidth, kPayBtnWidth)];
        AliImg.right = AliLabel.x - 8;
        AliImg.centerY = wxImg.centerY;
        AliImg.image = [UIImage imageNamed:@"pay_icon_zhifubao"];
        [self addSubview:AliImg];
       
        
        UIButton *aliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        aliBtn.frame = CGRectMake(SCREEN_WIDTH/2.0, line.bottom, SCREEN_WIDTH/2.0, self.height - line.bottom);
        [aliBtn addTarget:self action:@selector(AliPay:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:aliBtn];
    }
    return self;
}



- (void)configureWithMoneyModel:(CountMoneyModel*)moneyModel{
    _accommodation_detail_label.text = [NSString stringWithFormat:@"￥%@ × %@间 × %@天",moneyModel.roomPrice,moneyModel.payNum,moneyModel.liveDay];
    _accommodation_totalM_label.text = [NSString stringWithFormat:@"￥%@",moneyModel.stayMoneySum];
    _deposit_detail_label.text = [NSString stringWithFormat:@"￥%@ × %@间",moneyModel.deposit,moneyModel.payNum];
    _deposit_totalM_label.text = [NSString stringWithFormat:@"￥%@",moneyModel.depositSum];
    
    _totalPriceLabel.text = [NSString stringWithFormat:@"￥%@",moneyModel.actualPayment];

    if (moneyModel.coupontype.integerValue == 0) {
          _couponLabel.text =  @"不使用优惠券";
        
    }else if (moneyModel.coupontype.integerValue == 1){
        _couponLabel.text = [NSString stringWithFormat:@"%@元抵扣 >>",moneyModel.coupondenominat];
        _discoutPriceLabel.text = [NSString stringWithFormat:@"- ￥%@",moneyModel.coupondenominat];
    }else if (moneyModel.coupontype.integerValue == 2){
        _couponLabel.text = [NSString stringWithFormat:@"%1.f折折扣券 >>",moneyModel.coupondiscount.floatValue * 10];
//        _discoutPriceLabel.text = [NSString stringWithFormat:@"- ￥%@",moneyModel.coupondenominat];
    }
    
}


#pragma mark -- Btn Actions

-(void)wxPay:(UIButton *)sender{
    if (self.wxPay) {
        self.wxPay();
    }
}

-(void)AliPay:(UIButton *)sender{
    if (self.aliPay) {
        self.aliPay();
    }
}

@end
