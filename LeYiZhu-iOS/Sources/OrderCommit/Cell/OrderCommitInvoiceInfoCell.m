//
//  OrderCommitInvoiceInfoCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/8.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderCommitInvoiceInfoCell.h"
#import "OrderCommitCellMarcos.h"
#import "OrderInvoiceModel.h"
#import "NSString+Size.h"
#import "LYZOrderCommitViewController.h"

@interface OrderCommitInvoiceInfoCell ()
@property (nonatomic, strong) UILabel *invoiceTitleLabel;
@property (nonatomic ,strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *invocieTypeLabel;
@property (nonatomic, strong) UIButton *invoiceBtn ;

@property (nonatomic, strong) UIImageView *arrowImg;

@end

@implementation OrderCommitInvoiceInfoCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, 47)];
    titleLabel.textColor = LYZTheme_warmGreyFontColor;
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0f];
    titleLabel.text = @"发票详情";
    [self addSubview:titleLabel];
    
    self.invocieTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right + kTitle_Content_Space, 0, 200, 47)];
    self.invocieTypeLabel.textColor = LYZTheme_warmGreyFontColor;
    self.invocieTypeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    [self addSubview:self.invocieTypeLabel];
    
    self.invoiceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right + kTitle_Content_Space, self.invocieTypeLabel.bottom -3, SCREEN_WIDTH - 2*kTitle_Content_Space - 10 - DefaultLeftSpace - 80 , 0)];
    self.invoiceTitleLabel.numberOfLines = 0;
    [self addSubview:self.invoiceTitleLabel];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right + kTitle_Content_Space, self.invoiceTitleLabel.bottom + 5, SCREEN_WIDTH - 2*kTitle_Content_Space - 10 - DefaultLeftSpace - 80 , 0)];
    self.addressLabel.numberOfLines = 0;
    [self addSubview:self.addressLabel];
    
    
   _invoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _invoiceBtn.frame = CGRectMake(titleLabel.right,  0  , SCREEN_WIDTH - titleLabel.right,  0);
    [_invoiceBtn addTarget:self action:@selector(invoiceDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_invoiceBtn];

}

-(UIImageView *)arrowImg{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kTitle_Content_Space - 10, ([OrderCommitInvoiceInfoCell cellHeightWithData:self.data]  - 10) /2.0, 10, 10)];
        _arrowImg.image = [UIImage imageNamed:@"indent_icon_show"];
    }
    return _arrowImg;
}

- (void)loadContent {
    OrderInvoiceModel *model = self.data;
    InvoiceTitleModel *titleModel = model.title;
    RecieverInfoModel *addressModel = model.recieverInfo;
    NSString *titleContent = titleModel.taxTitle;
    NSString *taxNum = titleModel.taxNum;
    NSString *name = addressModel.recipient;
    NSString *phone = addressModel.phone;
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",addressModel.province,addressModel.city,addressModel.area,addressModel.address];
  // InvoiceTilt
    if (model.type == OrderInvoiceType_Paper) {
          self.invocieTypeLabel.text = @"纸质发票";
        if (titleModel.type == enterpriseType) {
            NSMutableAttributedString * attriStr_title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",titleContent,taxNum]];
            // 创建文字属性
            NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
            [attriStr_title addAttributes:attriBute1 range:NSMakeRange(0, titleContent.length)];
            NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
            [attriStr_title addAttributes:attriBute2 range:NSMakeRange(titleContent.length + 1, taxNum.length)];
                NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect titleRect = [attriStr_title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 160, CGFLOAT_MAX) options:options context:nil];
            self.invoiceTitleLabel.frame = CGRectMake(DefaultLeftSpace + 90 + kTitle_Content_Space, self.invocieTypeLabel.bottom -3, SCREEN_WIDTH - 2*kTitle_Content_Space - 10 - DefaultLeftSpace - 90 , titleRect.size.height);
            self.invoiceTitleLabel.attributedText = attriStr_title;
        }else{
            self.invoiceTitleLabel.textColor = LYZTheme_BlackFontColorFontColor;
            CGFloat titleHeight = [titleContent heightWithFont: [UIFont fontWithName:LYZTheme_Font_Regular size:16.0f] constrainedToWidth:SCREEN_WIDTH - 160];
            self.invoiceTitleLabel.frame =CGRectMake(DefaultLeftSpace + 90 + kTitle_Content_Space, self.invocieTypeLabel.bottom -3, SCREEN_WIDTH - 2*kTitle_Content_Space - 10 - DefaultLeftSpace - 90 , titleHeight);
            self.invoiceTitleLabel.text = titleContent;
        }
        
    //InvoiceAddress
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   %@\n%@",name,phone,address]];
        // 创建文字属性
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
        [attriStr addAttributes:attriBute1 range:NSMakeRange(0, name.length + phone.length +  3)]; //3 为空格数
        NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
        [attriStr addAttributes:attriBute2 range:NSMakeRange(name.length + phone.length +  3 + 1, address.length)];
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect addressRect = [attriStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 160, CGFLOAT_MAX) options:options context:nil];
        CGFloat addressHeight = addressRect.size.height;

        self.addressLabel.frame = CGRectMake(DefaultLeftSpace + 90 + kTitle_Content_Space, self.invoiceTitleLabel.bottom + 5, SCREEN_WIDTH - 2*kTitle_Content_Space - 10 - DefaultLeftSpace - 90 , addressHeight);
        self.addressLabel.attributedText = attriStr;
    }
    else if (model.type == OrderInvoiceType_Electronic){
        //TODO: 电子发票
        
        self.invocieTypeLabel.text = @"电子发票";
    }
   
    [self addSubview:self.arrowImg];
     _invoiceBtn.frame = CGRectMake(DefaultLeftSpace + 50,  0  , SCREEN_WIDTH - DefaultLeftSpace - 100,  [OrderCommitInvoiceInfoCell cellHeightWithData:self.data] );
    
}


- (void)selectedEvent {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:self.data];
    }
}

+ (CGFloat)cellHeightWithData:(id)data{
    
    OrderInvoiceModel *model = data;
    InvoiceTitleModel *titleModel = model.title;
    RecieverInfoModel *addressModel = model.recieverInfo;
    NSString *titleContent = titleModel.taxTitle;
    NSString *taxNum = titleModel.taxNum;
    NSString *name = addressModel.recipient;
    NSString *phone = addressModel.phone;
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",addressModel.province,addressModel.city,addressModel.area,addressModel.address];
    CGFloat addressHeight;

    CGFloat titleHeight;
    if (model.type == OrderInvoiceType_Paper) {
        if (titleModel.type == enterpriseType) {
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",titleContent,taxNum]];
            // 创建文字属性
            NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
            [attriStr addAttributes:attriBute1 range:NSMakeRange(0, titleContent.length)];
            NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
            [attriStr addAttributes:attriBute2 range:NSMakeRange(titleContent.length + 1, taxNum.length)];
            NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect titleRect = [attriStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 150, CGFLOAT_MAX) options:options context:nil];
            titleHeight = titleRect.size.height;
        }else{
            titleHeight = [titleContent heightWithFont: [UIFont fontWithName:LYZTheme_Font_Light size:16.0f] constrainedToWidth:SCREEN_WIDTH - 150];
        }
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   %@\n%@",name,phone,address]];
            // 创建文字属性
            NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
            [attriStr addAttributes:attriBute1 range:NSMakeRange(0, name.length + phone.length +  3)]; //3 为空格数
            NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
            [attriStr addAttributes:attriBute2 range:NSMakeRange(name.length + phone.length +  3 + 1, address.length)];
            NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect addressRect = [attriStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 150, CGFLOAT_MAX) options:options context:nil];
            addressHeight = addressRect.size.height;

    }else {
        titleHeight = 30;
        addressHeight = 30;
    }
    
    return addressHeight + titleHeight + 47 + 5 + 15;
}

-(void)invoiceDetail:(UIButton *)sender{
    if ([self.controller respondsToSelector:@selector(toInvoiceDetail)]) {
        [(LYZOrderCommitViewController *)(self.controller) toInvoiceDetail];
    }
}

@end
