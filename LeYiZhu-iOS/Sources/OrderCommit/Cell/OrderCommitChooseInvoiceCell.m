//
//  OrderCommitChooseInvoiceCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/8.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderCommitChooseInvoiceCell.h"
#import "OrderCommitCellMarcos.h"
#import "LYZOrderCommitViewController.h"
#import "OrderInvoiceModel.h"

#define kInvoiceBtnTag 100

@interface OrderCommitChooseInvoiceCell ()

@property (nonatomic, strong) UIButton *invoiceNoNeedBtn;
@property (nonatomic, strong) UIButton *needInvoiceBtn;


@end

static CGFloat _OrderChooseInvoinceCellHeight = 47.0f;


@implementation OrderCommitChooseInvoiceCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 80, OrderCommitChooseInvoiceCell.cellHeight)];
    title.textColor = LYZTheme_warmGreyFontColor;
    title.font = [UIFont fontWithName:@"PingFangSC-Light" size:14.0f];
    title.text = @"发票";
    [self addSubview:title];
    
    self.invoiceNoNeedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.invoiceNoNeedBtn.frame = CGRectMake(title.right - 10,12.5, 80 , 22);
    [self.invoiceNoNeedBtn setImage:[UIImage imageNamed:@"indent_icon_choose"] forState:UIControlStateNormal];
    self.invoiceNoNeedBtn.tag = kInvoiceBtnTag;
    [self.invoiceNoNeedBtn addTarget:self action:@selector(chooseInvoice:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.invoiceNoNeedBtn];
    
    UILabel *noNeedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.invoiceNoNeedBtn.x + 60, 0, 50, OrderCommitChooseInvoiceCell.cellHeight)];
    noNeedLabel.textColor = LYZTheme_BlackFontColorFontColor;
    noNeedLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16.0f];
    noNeedLabel.text = @"不需要";
    [self addSubview:noNeedLabel];
    
    self.needInvoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.needInvoiceBtn.frame = CGRectMake(noNeedLabel.right - 10,12.5, 80 , 22);
    [self.needInvoiceBtn setImage:[UIImage imageNamed:@"indent_icon_unchoose"] forState:UIControlStateNormal];
    self.needInvoiceBtn.tag = kInvoiceBtnTag + 1;
    [self.needInvoiceBtn addTarget:self action:@selector(chooseInvoice:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.needInvoiceBtn];
    
    UILabel *needLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.needInvoiceBtn.x + 60, 0, 50, OrderCommitChooseInvoiceCell.cellHeight)];
    needLabel.textColor = LYZTheme_BlackFontColorFontColor;
    needLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16.0f];
    needLabel.text = @"需要";
    [self addSubview:needLabel];
    
}


- (void)loadContent {
    OrderInvoiceModel *model = (OrderInvoiceModel *)self.data;
    if (model.type == OrderInvoiceType_none) {
          [self.invoiceNoNeedBtn setImage:[UIImage imageNamed:@"indent_icon_choose"] forState:UIControlStateNormal];
         [self.needInvoiceBtn setImage:[UIImage imageNamed:@"indent_icon_unchoose"] forState:UIControlStateNormal];
        self.selected = NO;
        
    }else{
        [self.invoiceNoNeedBtn setImage:[UIImage imageNamed:@"indent_icon_unchoose"] forState:UIControlStateNormal];
        [self.needInvoiceBtn setImage:[UIImage imageNamed:@"indent_icon_choose"] forState:UIControlStateNormal];
        self.selected = YES;

    }
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _OrderChooseInvoinceCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderChooseInvoinceCellHeight;
}

#pragma mark  - Btn Actions

-(void)chooseInvoice:(UIButton *)sender{
    
    if (sender.tag == kInvoiceBtnTag) {
        //no need
        [self.needInvoiceBtn setImage:[UIImage imageNamed:@"indent_icon_unchoose"] forState:UIControlStateNormal];
        [self.invoiceNoNeedBtn setImage:[UIImage imageNamed:@"indent_icon_choose"] forState:UIControlStateNormal];
        if ([self.controller respondsToSelector:@selector(needInvoice:)]) {
            [(LYZOrderCommitViewController *)(self.controller) needInvoice:NO];
        }
    }else{
        //need
        [self.needInvoiceBtn setImage:[UIImage imageNamed:@"indent_icon_choose"] forState:UIControlStateNormal];
        [self.invoiceNoNeedBtn setImage:[UIImage imageNamed:@"indent_icon_unchoose"] forState:UIControlStateNormal];
        if ([self.controller respondsToSelector:@selector(needInvoice:)]) {
            [(LYZOrderCommitViewController *)(self.controller) needInvoice:YES];
        }
    }
}




@end
