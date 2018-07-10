//
//  OrderCommitRoomInfoCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderCommitRoomInfoCell.h"
#import "LYZHotelRoomDetailModel.h"
#import "UIView+SetRect.h"

@interface OrderCommitRoomInfoCell ()

@property (nonatomic, strong) UILabel *roomTypeLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *vipPriceLabel;

@property (nonatomic, strong) UILabel *vipTagLabel;

@property (nonatomic, strong) UILabel *tagLabel;

@property (nonatomic, strong) UILabel *tagLabel0;

@end

static CGFloat _OrderRoomInfoCellHeight = 60.0f;

@implementation OrderCommitRoomInfoCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.roomTypeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:18.0f];
    self.roomTypeLabel.textColor =LYZTheme_paleBrown;
    [self addSubview:self.roomTypeLabel];
    
    self.vipPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.vipPriceLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:17];
    self.vipPriceLabel.textColor = LYZTheme_paleBrown;
    self.vipPriceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.vipPriceLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.priceLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
    self.priceLabel.textColor =LYZTheme_warmGreyFontColor;
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.priceLabel];
    
    self.vipTagLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.vipTagLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:13];
    self.vipTagLabel.textColor = LYZTheme_paleBrown;
    self.vipTagLabel.textAlignment = NSTextAlignmentCenter;
    self.vipTagLabel.layer.cornerRadius = 3.0;
    self.vipTagLabel.layer.borderColor = LYZTheme_paleBrown.CGColor;
    self.vipTagLabel.layer.borderWidth = 0.5f;
    
    [self addSubview:self.vipTagLabel];
    
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
    [self addSubview:self.tagLabel0];
    
}

- (void)loadContent {
    if (self.data && [self.data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self.data;
        LYZHotelRoomDetailModel *model = (LYZHotelRoomDetailModel *)dic[@"roomInfo"];
        self.roomTypeLabel.text = model.roomType;
        [self.roomTypeLabel sizeToFit];
        self.roomTypeLabel.x = DefaultLeftSpace;
        self.roomTypeLabel.centerY = _OrderRoomInfoCellHeight/2.0;
        
        self.tagLabel.x = self.roomTypeLabel.right + 10;
        self.tagLabel.centerY = self.roomTypeLabel.centerY - 12.5;
        self.vipTagLabel.hidden = NO;
        self.tagLabel0.x = self.roomTypeLabel.right + 10;
        self.tagLabel0.centerY = self.roomTypeLabel.centerY +12.5;
        //    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/天",[NSString removeFloatAllZero:model.price]];
        NSString *price = dic[@"price"];
        NSString *vipprice = dic[@"vipprice"];
        BOOL isExact = [dic[@"exact"] isEqualToString:@"Y"] ? YES : NO;
        
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_paleBrown,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:18]};
        NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_paleBrown,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:12]};
        
        if ([[NSString  removeFloatAllZero:price] isEqualToString:[NSString  removeFloatAllZero:vipprice]]) {
            if (isExact) {
                self.priceLabel.text = [NSString stringWithFormat:@"￥%@/天",price];
                [self.priceLabel sizeToFit];
                self.priceLabel.right = SCREEN_WIDTH -DefaultLeftSpace;
                self.priceLabel.centerY = OrderCommitRoomInfoCell.cellHeight/2.0;
            }else{
                NSString *original =  [NSString stringWithFormat:@"￥%@ ",price];
            
                NSString *total = [NSString stringWithFormat:@"￥%@ 起/天",price];
                NSMutableAttributedString *attri_total = [[NSMutableAttributedString alloc] initWithString:total];
                [attri_total addAttributes:attriBute1 range:NSMakeRange(0, original.length)];
                [attri_total addAttributes:attriBute2 range:NSMakeRange(original.length, total.length - original.length)];

                self.priceLabel.attributedText = attri_total;
                [self.priceLabel sizeToFit];
                self.priceLabel.right = SCREEN_WIDTH -DefaultLeftSpace;
                self.priceLabel.centerY = OrderCommitRoomInfoCell.cellHeight/2.0;
                self.vipTagLabel.hidden = YES;
            }
          
        }else{
            if (isExact) {
                self.vipPriceLabel.text = [NSString stringWithFormat:@"￥%@/天",vipprice];
                [self.vipPriceLabel sizeToFit];
                self.vipPriceLabel.right = SCREEN_WIDTH -DefaultLeftSpace;
                self.vipPriceLabel.y = 5;
               
            }else{
                NSString *original =  [NSString stringWithFormat:@"￥%@ ",vipprice];
                
                NSString *total = [NSString stringWithFormat:@"￥%@ 起/天",vipprice];
                NSMutableAttributedString *attri_total = [[NSMutableAttributedString alloc] initWithString:total];
                [attri_total addAttributes:attriBute1 range:NSMakeRange(0, original.length)];
                [attri_total addAttributes:attriBute2 range:NSMakeRange(original.length, total.length - original.length)];

                self.vipPriceLabel.attributedText = attri_total;
                [self.vipPriceLabel sizeToFit];
                self.vipPriceLabel.right = SCREEN_WIDTH -DefaultLeftSpace;
                self.vipPriceLabel.y = 5;
            }
            NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@/天 ",price]];
            [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
            self.priceLabel.attributedText = newPrice;
            [self.priceLabel sizeToFit];
            self.priceLabel.right = SCREEN_WIDTH -DefaultLeftSpace;
            self.priceLabel.y = self.vipPriceLabel.bottom + 3;
            
            self.vipTagLabel.text = model.vipname;
            CGSize size = [self.vipTagLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:LYZTheme_Font_Light size:13],NSFontAttributeName,nil]];
            self.vipTagLabel.height = size.height + 6;
            self.vipTagLabel.width = size.width + 8;
            self.vipTagLabel.centerY = OrderCommitRoomInfoCell.cellHeight /2.0;
            self.vipTagLabel.right = self.vipPriceLabel.x - 10;
        }
    }
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _OrderRoomInfoCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderRoomInfoCellHeight;
}


@end
