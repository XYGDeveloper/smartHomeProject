//
//  LYZOrderInvoiceCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderInvoiceCell.h"

@interface LYZOrderInvoiceCell ()

@property (nonatomic, strong) UILabel *invoiceTypeLabel;

@end

static CGFloat _OrderInvoiceTypeCellHeight = 52.0f;

@implementation LYZOrderInvoiceCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)buildSubview {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, LYZOrderInvoiceCell.cellHeight)];
    title.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    title.textColor = LYZTheme_warmGreyFontColor;
    title.text = @"发票";
    [self addSubview:title];
    
    self.invoiceTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(title.right, 0, 300,  LYZOrderInvoiceCell.cellHeight)];
    self.invoiceTypeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    self.invoiceTypeLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.invoiceTypeLabel];
    
}


- (void)loadContent {
   NSDictionary *dic = (NSDictionary *)self.data;
    self.invoiceTypeLabel.text = [dic objectForKey:@"invoiceType"];
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderInvoiceTypeCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _OrderInvoiceTypeCellHeight;
}


@end
