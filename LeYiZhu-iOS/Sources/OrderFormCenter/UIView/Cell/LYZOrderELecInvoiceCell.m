//
//  LYZOrderELecInvoiceCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderELecInvoiceCell.h"
#import "BaseOrderDetailModel.h"

@interface LYZOrderELecInvoiceCell ()

@property (nonatomic, strong) UILabel *invoiceDetailLabel;
@property (nonatomic, strong) UILabel *invoiceTitleLabel;
@property (nonatomic, strong) UILabel *mailLabel;

@end

static CGFloat _OrderElecInvoiceCellHeight = 116.0f;

@implementation LYZOrderELecInvoiceCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)buildSubview {
    UILabel *detail_title = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, LYZOrderELecInvoiceCell.cellHeight/3.0)];
    detail_title.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    detail_title.textColor = LYZTheme_warmGreyFontColor;
    detail_title.text = @"发票明细";
    [self addSubview:detail_title];
    
    self.invoiceDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(detail_title.right, 0, SCREEN_WIDTH - 2*DefaultLeftSpace - 90,  LYZOrderELecInvoiceCell.cellHeight/3.0)];
    self.invoiceDetailLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    self.invoiceDetailLabel.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.invoiceDetailLabel];
    
    UILabel *lookup = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, detail_title.bottom, 100, LYZOrderELecInvoiceCell.cellHeight/3.0)];
    lookup.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    lookup.textColor = LYZTheme_warmGreyFontColor;
    lookup.text = @"发票抬头";
    [self addSubview:lookup];
    
    self.invoiceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(lookup.right, detail_title.bottom, 300,  LYZOrderELecInvoiceCell.cellHeight/3.0)];
    self.invoiceTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    self.invoiceTitleLabel.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.invoiceTitleLabel];
    
    UILabel *mail = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, lookup.bottom, 100, LYZOrderELecInvoiceCell.cellHeight/3.0)];
    mail.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    mail.textColor = LYZTheme_warmGreyFontColor;
    mail.text = @"邮箱";
    [self addSubview:mail];
    
    self.mailLabel = [[UILabel alloc] initWithFrame:CGRectMake(mail.right, lookup.bottom, 300,  LYZOrderELecInvoiceCell.cellHeight/3.0)];
    self.mailLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    self.mailLabel.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.mailLabel];
    
}


- (void)loadContent {
    if ([self.data isKindOfClass:[BaseOrderDetailModel class]]) {
        BaseOrderDetailModel *model = (BaseOrderDetailModel *)self.data;
        self.invoiceDetailLabel.text = model.invoiceJson.invoiceDetail;
        self.invoiceTitleLabel.text = model.invoiceJson.lookup;
        self.mailLabel.text = model.invoiceJson.address;
    }
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderElecInvoiceCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _OrderElecInvoiceCellHeight;
}


@end
