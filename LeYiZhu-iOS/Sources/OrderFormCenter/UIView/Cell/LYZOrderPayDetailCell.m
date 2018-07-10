//
//  LYZOrderPayDetailCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderPayDetailCell.h"
#import "BaseOrderDetailModel.h"

@interface LYZOrderPayDetailCell ()

@property(nonatomic, strong) UILabel *stayMoneySumLabel;

@property (nonatomic, strong)UILabel *depositSumLabel;

@property (nonatomic, strong)UILabel *couponPriceLabel;

@end

static CGFloat _OrderPayDetailCellHeight = 100.0f;

@implementation LYZOrderPayDetailCell


- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace , 0, 90, 40 )];
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    titleLabel.textColor = LYZTheme_warmGreyFontColor;
    titleLabel.text = @"住宿费";
    [self addSubview:titleLabel];
    
    self.stayMoneySumLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right  , 0, 100, 30)];
    self.stayMoneySumLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.stayMoneySumLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.stayMoneySumLabel];
    
    UILabel *couponLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, titleLabel.bottom-3, 90, 25)];
    couponLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    couponLabel.textColor = LYZTheme_warmGreyFontColor;
    couponLabel.text = @"优惠券";
    [self addSubview:couponLabel];
    
    self.couponPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(couponLabel.right, couponLabel.y, 100, 25)];
    self.couponPriceLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.couponPriceLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.couponPriceLabel];

    UILabel *depositLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace , couponLabel.bottom, 100, 25 )];
    depositLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    depositLabel.textColor = LYZTheme_warmGreyFontColor;
    depositLabel.text = @"押金";
    [self addSubview:depositLabel];
    
    self.depositSumLabel = [[UILabel alloc] initWithFrame:CGRectMake(depositLabel.right-10  ,depositLabel.y, 100, 25)];
    self.depositSumLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.depositSumLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.depositSumLabel];
}

- (void)loadContent {
   
    if ([self.data isKindOfClass:[BaseOrderDetailModel class]]) {
        BaseOrderDetailModel *model = (BaseOrderDetailModel *)self.data;
        self.stayMoneySumLabel.text = [NSString stringWithFormat:@"￥%@",model.orderJson.stayMoneySum];
        self.depositSumLabel.text = [NSString stringWithFormat:@"￥%@",model.orderJson.depositSum];
        if (model.orderJson.coupontype.integerValue == 0) {
            self.couponPriceLabel.text = [NSString stringWithFormat:@"￥%@",@0];
        }else if (model.orderJson.coupontype.integerValue == 1) {
            self.couponPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.orderJson.coupondenominat];
        }
    }
}


- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderPayDetailCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderPayDetailCellHeight;
}

-(void)dealloc{
    LYLog(@"dealloc");
}

@end
