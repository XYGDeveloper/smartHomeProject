//
//  SelectInvoiceTitleCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "SelectInvoiceTitleCell.h"
#import "NSString+Size.h"
#import "InvoiceTitleModel.h"
#import "ChooseTaxTitleViewController.h"

#define EditBtnWidth 62.0f
#define SelectImgWidth 22.0f

@interface SelectInvoiceTitleCell ()

@property (nonatomic, strong) UIImageView *selectImgView;
@property (nonatomic, strong) UILabel *invoiceTitleLabel;
@property (nonatomic, strong) UIButton *editBtn;


@end


@implementation SelectInvoiceTitleCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.selectImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.selectImgView.image = [UIImage imageNamed:@"indent_icon_unchoose"];
    [self addSubview:self.selectImgView];
    
    self.invoiceTitleLabel           = [[UILabel alloc] initWithFrame:CGRectZero];
    self.invoiceTitleLabel.numberOfLines = 0;
    [self addSubview:self.invoiceTitleLabel];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame = CGRectZero;
    [self.editBtn setImage:[UIImage imageNamed:@"EditContacts"] forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editBtn];

}


- (void)loadContent {
    CGFloat cellHeight = [[self class] cellHeightWithData:self.data];
    InvoiceTitleModel *model = (InvoiceTitleModel *)self.data;
    NSString *titleContent = model.taxTitle;
    NSString *taxNum = model.taxNum;
    self.selectImgView.frame = CGRectMake(DefaultLeftSpace , (cellHeight - SelectImgWidth)/2.0, SelectImgWidth, SelectImgWidth);
    self.editBtn.frame = CGRectMake(SCREEN_WIDTH - EditBtnWidth , (cellHeight - EditBtnWidth)/2.0, EditBtnWidth, EditBtnWidth);
    self.invoiceTitleLabel.frame = CGRectMake(self.selectImgView.right + 20, 0, SCREEN_WIDTH - 124, [[self class] cellHeightWithData:self.data]);
    if (model.isSelected) {
        [self.selectImgView setImage:[UIImage imageNamed:@"indent_icon_choose"]];
    }else{
        [self.selectImgView setImage:[UIImage imageNamed:@"indent_icon_unchoose"]];
    }
    if (model.type == enterpriseType) {
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",titleContent,taxNum]];
        // 创建文字属性
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
        [attriStr addAttributes:attriBute1 range:NSMakeRange(0, titleContent.length)];
        NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
        [attriStr addAttributes:attriBute2 range:NSMakeRange(titleContent.length + 1, taxNum.length)];
        self.invoiceTitleLabel.attributedText = attriStr;
    }else{
        self.invoiceTitleLabel.font =[UIFont fontWithName:LYZTheme_Font_Regular size:16];
        self.invoiceTitleLabel.textColor = LYZTheme_BlackFontColorFontColor;
        self.invoiceTitleLabel.text = titleContent;
    }
}

- (void)selectedEvent {
    
  
}

#pragma mark - class property.

+(CGFloat)cellHeightWithData:(id)data{
    InvoiceTitleModel *model = (InvoiceTitleModel *)data;
    NSString *titleContent = model.taxTitle;
    NSString *taxNum = model.taxNum;
    CGFloat height;
    if (model.type == enterpriseType) {
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",titleContent,taxNum]];
        // 创建文字属性
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
        [attriStr addAttributes:attriBute1 range:NSMakeRange(0, titleContent.length)];
        NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
        [attriStr addAttributes:attriBute2 range:NSMakeRange(titleContent.length + 1, taxNum.length)];
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect labelRect = [attriStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 124, CGFLOAT_MAX) options:options context:nil];
        height = labelRect.size.height;
    }else{
        height = [titleContent heightWithFont: [UIFont fontWithName:LYZTheme_Font_Light size:16.0f] constrainedToWidth:SCREEN_WIDTH - 124];
    }
    height += 20;
    if (height < 62) {
        height = 62;
    }
    return height ;
}


#pragma mark - Btn Actions

-(void)editBtnClick:(id)sender{
    ChooseTaxTitleViewController *vc = (ChooseTaxTitleViewController *)self.controller;
    InvoiceTitleModel *model = (InvoiceTitleModel *)self.data;
    if ([vc respondsToSelector:@selector(editBtnClick:)]) {
        [vc editBtnClick:model];
    }
}

@end
