//
//  LYZHotelOrderCell.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 2017/11/24.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZHotelOrderCell.h"
#import "UIView+SetRect.h"
#import "HotelRoomsModel.h"
#import "LoginManager.h"
#import "LYZHotelViewController.h"
#import "UIButton+LYZLoginButton.h"
#import "YQAlertView.h"
#import "MJExtension.h"
@interface LYZHotelOrderCell ()<YQAlertViewDelegate>

@property (nonatomic, strong) UILabel *roomTypeLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *vipPriceLabel;

@property (nonatomic , strong) UILabel *tagLabel;

@property (nonatomic , strong) UILabel *tagLabel0;

@end

static CGFloat _hotelOrderCellHeight = 65.0f;

@implementation LYZHotelOrderCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    self.roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.roomTypeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:18];
    self.roomTypeLabel.textColor = LYZTheme_paleBrown;
    [self addSubview:self.roomTypeLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.priceLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:18];
    self.priceLabel.textColor = LYZTheme_paleBrown;
    [self addSubview:self.priceLabel];
    self.vipPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.vipPriceLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    self.vipPriceLabel.textColor = RGB(182, 182, 182);
    [self addSubview:self.vipPriceLabel];
    
    self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderBtn.width = 100.0f;
    self.orderBtn.height = 35.0f;
    self.orderBtn.right = SCREEN_WIDTH - DefaultLeftSpace;
    self.orderBtn.centerY = _hotelOrderCellHeight/2.0;
    self.orderBtn.layer.cornerRadius = 5.0f;
    self.orderBtn.needLogin = YES;
    self.orderBtn.clipsToBounds = YES;
    self.orderBtn.backgroundColor = LYZTheme_paleBrown;
    [self.orderBtn setTitle:@"立即预订" forState:UIControlStateNormal];
    [self.orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.orderBtn addTarget:self action:@selector(orderRoom:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.orderBtn];
    
    self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    self.tagLabel.textColor = [UIColor colorWithHexString:@"#818fbd" alpha:1.0];
    self.tagLabel.textAlignment = NSTextAlignmentCenter;
    self.tagLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:10];
    self.tagLabel.layer.borderColor = [UIColor colorWithHexString:@"#818fbd" alpha:1.0].CGColor;
    self.tagLabel.layer.borderWidth = 0.5f;
    self.tagLabel.layer.cornerRadius = 4.0f;
    self.tagLabel.text = @"不可取消";
    [self addSubview:self.tagLabel];
    
    self.tagLabel0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    self.tagLabel0.textColor = [UIColor colorWithHexString:@"#818fbd" alpha:1.0];
    self.tagLabel0.textAlignment = NSTextAlignmentCenter;
    self.tagLabel0.font = [UIFont fontWithName:LYZTheme_Font_Regular size:10];
    self.tagLabel0.layer.borderColor = [UIColor colorWithHexString:@"#818fbd" alpha:1.0].CGColor;
    self.tagLabel0.layer.borderWidth = 0.5f;
    self.tagLabel0.layer.cornerRadius = 4.0f;
    self.tagLabel0.text = @"会员折扣";
    [self addSubview:self.self.tagLabel0];
    
}


- (void)loadContent {
    if (!self.data) {
        return;
    }
    NSDictionary *dic = (NSDictionary *)self.data;
    HotelRoomsModel *model = (HotelRoomsModel *)dic[@"data"];
    NSString *isExact = dic[@"isExact"];
    self.orderBtn.enabled = YES;
    self.roomTypeLabel.text = model.roomType;
    [self.roomTypeLabel sizeToFit];
    self.roomTypeLabel.x = DefaultLeftSpace;
    self.roomTypeLabel.centerY = 18;
    
    self.tagLabel.x = DefaultLeftSpace;
    self.tagLabel.y = self.roomTypeLabel.bottom + 5;
    
    self.tagLabel0.x = DefaultLeftSpace *2 + self.tagLabel.width-15;
    self.tagLabel0.y = self.roomTypeLabel.bottom + 5;
    
    NSLog(@"-------------%@",[model.roomTypeStatus stringValue]);
    
    if ([model.openstatus.uppercaseString isEqualToString:@"Y"]) {
        if ([model.roomTypeStatus intValue]== 1) {
            [ self.orderBtn setTitle:@"立即预订" forState:UIControlStateNormal];
            self.orderBtn.backgroundColor = LYZTheme_paleBrown;
        }else if([model.roomTypeStatus intValue]==2){
            [self.orderBtn setTitle:@"满 房" forState:UIControlStateNormal];
            self.orderBtn.backgroundColor = LYZTheme_PinkishGeryColor;
            self.orderBtn.enabled = YES;
        }else{
            [self.orderBtn setTitle:@"满 房" forState:UIControlStateNormal];
            self.orderBtn.backgroundColor = LYZTheme_PinkishGeryColor;
            self.orderBtn.enabled = YES;
        }
    }else{
        [self.orderBtn setTitle:@"即将营业" forState:UIControlStateNormal];
        self.orderBtn.backgroundColor = LYZTheme_PinkishGeryColor;
        self.orderBtn.enabled = NO;
    }
    
    NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_paleBrown,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:18]};
    NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_paleBrown,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:12]};

    NSLog(@"--------查看数据------%@   %@",model.price,model.vipprice);
    
    if (![LoginManager instance].appUserID) {
        if ([isExact isEqualToString:@"Y"]) {
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.vipprice];
            [self.priceLabel sizeToFit];
            self.priceLabel.right = self.orderBtn.x - 10;
            self.priceLabel.centerY = _hotelOrderCellHeight/2.0-10;
            NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@ ",model.price]];
            [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
            self.vipPriceLabel.attributedText = newPrice;
            [self.vipPriceLabel sizeToFit];
            self.vipPriceLabel.right = self.orderBtn.x - 10;
            self.vipPriceLabel.bottom = self.orderBtn.bottom;
            
        }else{
            NSString *price =  [NSString stringWithFormat:@"￥%@",model.price];
            NSString *qi = @"起";
            NSString *total = [NSString stringWithFormat:@"%@ %@",price,qi];
            NSMutableAttributedString *attri_total = [[NSMutableAttributedString alloc] initWithString:total];
            [attri_total addAttributes:attriBute1 range:NSMakeRange(0, price.length)];
            [attri_total addAttributes:attriBute2 range:NSMakeRange(price.length, total.length - price.length)];
            self.priceLabel.attributedText = attri_total;
            [self.priceLabel sizeToFit];
            self.priceLabel.right = self.orderBtn.x - 10;
            self.priceLabel.centerY = _hotelOrderCellHeight/2.0-10;
        }
    }else{
//        if ([model.vipprice isEqualToString:model.price]) {
//            //已登录，不是会员
//            if ([isExact isEqualToString:@"Y"]) {
//                self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
//                [self.priceLabel sizeToFit];
//                self.priceLabel.right = self.orderBtn.x - 10;
//                self.priceLabel.centerY = _hotelOrderCellHeight/2.0;
//            }else{
//                NSString *price =  [NSString stringWithFormat:@"￥%@",model.price];
//                NSString *qi = @"起";
//                NSString *total = [NSString stringWithFormat:@"%@ %@",price,qi];
//                NSMutableAttributedString *attri_total = [[NSMutableAttributedString alloc] initWithString:total];
//                [attri_total addAttributes:attriBute1 range:NSMakeRange(0, price.length)];
//                [attri_total addAttributes:attriBute2 range:NSMakeRange(price.length, total.length - price.length)];
//                self.priceLabel.attributedText = attri_total;
//                [self.priceLabel sizeToFit];
//                self.priceLabel.right = self.orderBtn.x - 10;
//                self.priceLabel.centerY = _hotelOrderCellHeight/2.0;
//            }
//        }else{
            if ([isExact isEqualToString:@"Y"]){
                self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.vipprice];
                [self.priceLabel sizeToFit];
                self.priceLabel.right = self.orderBtn.x - 10;
                self.priceLabel.centerY = _hotelOrderCellHeight/2.0-10;
                NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@ ",model.price]];
                [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
                self.vipPriceLabel.attributedText = newPrice;
                [self.vipPriceLabel sizeToFit];
                self.vipPriceLabel.right = self.orderBtn.x - 10;
                self.vipPriceLabel.bottom = self.orderBtn.bottom;
            }else{
                NSString *price =  [NSString stringWithFormat:@"￥%@",model.vipprice];
                NSString *qi = @"起";
                NSString *total = [NSString stringWithFormat:@"%@ %@",price,qi];
                NSMutableAttributedString *attri_total = [[NSMutableAttributedString alloc] initWithString:total];
                [attri_total addAttributes:attriBute1 range:NSMakeRange(0, price.length)];
                [attri_total addAttributes:attriBute2 range:NSMakeRange(price.length, total.length - price.length)];
                self.priceLabel.attributedText = attri_total;
                [self.priceLabel sizeToFit];
                self.priceLabel.right = self.orderBtn.x - 10;
                self.priceLabel.centerY = _hotelOrderCellHeight/2.0-10;
                NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@ ",model.price]];
                [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
                self.vipPriceLabel.attributedText = newPrice;
                [self.vipPriceLabel sizeToFit];
                self.vipPriceLabel.right = self.orderBtn.x - 10;
                self.vipPriceLabel.bottom = self.orderBtn.bottom;
            }
            
//        }
    }
}



- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _hotelOrderCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _hotelOrderCellHeight;
}

#pragma mark - Btn Action

-(void)orderRoom:(id)sender{
    
    LYZHotelViewController *vc = (LYZHotelViewController *)self.controller;
    if (self.data) {
    NSDictionary *dic = (NSDictionary *)self.data;
      HotelRoomsModel *model = (HotelRoomsModel *)dic[@"data"];
      [vc orderRoom:model];
    }
  
}



@end
