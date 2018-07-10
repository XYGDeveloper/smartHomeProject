//
//  LYZOrderPaperInvoiceCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderPaperInvoiceCell.h"
#import "NSString+Size.h"
#import "BaseOrderDetailModel.h"


@interface LYZOrderPaperInvoiceCell ()

@property (nonatomic, strong) UILabel *invoiceDetailsContent;
@property (nonatomic, strong) UILabel *lookupTitle;
@property (nonatomic ,strong) UILabel *lookupContent;
@property (nonatomic, strong) UILabel *addressTitle;
@property (nonatomic, strong) UILabel *addressContent;
@property (nonatomic, strong) UILabel *mailTypeTitle;
@property (nonatomic, strong) UILabel *mailTypeContent;
@property (nonatomic, strong) UILabel *remarkTitle;
@property (nonatomic, strong) UILabel *remarkContent;
@end

@implementation LYZOrderPaperInvoiceCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)buildSubview {
    //明细
    UILabel *detail_title = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, 47)];
    detail_title.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    detail_title.textColor = LYZTheme_warmGreyFontColor;
    detail_title.text = @"发票明细";
    [self addSubview:detail_title];
    
    self.invoiceDetailsContent = [[UILabel alloc] initWithFrame:CGRectMake(detail_title.right, detail_title.y, SCREEN_WIDTH -2*DefaultLeftSpace - 90, 47)];
    self.invoiceDetailsContent.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15.0];
    self.invoiceDetailsContent.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.invoiceDetailsContent];
    
    //抬头
    self.lookupTitle = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, self.invoiceDetailsContent.bottom - [self spaceHeight], 90, 47)];
    self.lookupTitle.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    self.lookupTitle.textColor = LYZTheme_warmGreyFontColor;
    self.lookupTitle.text = @"发票抬头";
    [self addSubview:self.lookupTitle];
    
    self.lookupContent = [[UILabel alloc] initWithFrame:CGRectMake(_lookupTitle.right, self.lookupTitle.y , SCREEN_WIDTH -2*DefaultLeftSpace - 90,  0)];
    self.lookupContent.numberOfLines = 0;
    [self addSubview:self.lookupContent];
    
    //配送地址
    self.addressTitle = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, self.lookupContent.bottom, 90, 47)];
      self.addressTitle.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
      self.addressTitle.textColor = LYZTheme_warmGreyFontColor;
      self.addressTitle.text = @"配送地址";
    [self addSubview:  self.addressTitle];
    
    self.addressContent = [[UILabel alloc] initWithFrame:CGRectMake(self.addressTitle.right, self.addressTitle.y, SCREEN_WIDTH -2*DefaultLeftSpace - 90, 0)];
    self.addressContent.numberOfLines = 0;
    [self addSubview:self.addressContent];
    
    //发票备注
    self.remarkTitle = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, self.addressContent.bottom - [self spaceHeight], 90, 47)];
    self.remarkTitle.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    self.remarkTitle.textColor = LYZTheme_warmGreyFontColor;
    self.remarkTitle.text = @"发票备注";
    [self addSubview:self.remarkTitle];
    
    self.remarkContent = [[UILabel alloc] initWithFrame:CGRectMake(_remarkTitle.right, self.remarkTitle.y , SCREEN_WIDTH -2*DefaultLeftSpace - 90,  0)];
    self.remarkContent.numberOfLines = 0;
    [self addSubview:self.remarkContent];
    
    //邮件方式
    self.mailTypeTitle =  [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, self.addressContent.bottom , 90, 47)];
    self.mailTypeTitle.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    self.mailTypeTitle.textColor = LYZTheme_warmGreyFontColor;
    self.mailTypeTitle.text = @"邮件方式";
    [self addSubview:self.mailTypeTitle];
    
    self.mailTypeContent = [[UILabel alloc] initWithFrame:CGRectMake(self.mailTypeTitle.right, self.mailTypeTitle.y, SCREEN_WIDTH -2*DefaultLeftSpace - 90, 47)];
    self.mailTypeContent.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15.0];
    self.mailTypeContent.textColor = LYZTheme_BlackFontColorFontColor;
    [self addSubview:self.mailTypeContent];
    
}

- (void)loadContent {
     BaseOrderInvoiceModel *model = (BaseOrderInvoiceModel *)self.data;
    NSString *titleContent = model.lookup;
    NSString *taxNum = model.taxNumber;
    NSString *name = model.recipient;
    NSString *phone = model.phone;
    NSString *address = model.address;
    NSString *remark = model.invoiceremark;

    //明细
    self.invoiceDetailsContent.text = model.invoiceDetail;
    // 抬头
    if (model.invoiceType.integerValue == 2) {
        if (model.taxNumber && ![model.taxNumber isEqualToString:@""]) {
            NSMutableAttributedString * attriStr_title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",titleContent,taxNum]];
            // 创建文字属性
            NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
            [attriStr_title addAttributes:attriBute1 range:NSMakeRange(0, titleContent.length)];
            NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
            [attriStr_title addAttributes:attriBute2 range:NSMakeRange(titleContent.length + 1, taxNum.length)];
            NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect titleRect = [attriStr_title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 130, CGFLOAT_MAX) options:options context:nil];
            self.lookupContent.frame = CGRectMake(_lookupTitle.right, self.lookupTitle.y + [self spaceHeight], SCREEN_WIDTH -2*DefaultLeftSpace - 90,  titleRect.size.height);
            self.lookupContent.attributedText = attriStr_title;
            
        }else{
            self.lookupContent.textColor = LYZTheme_BlackFontColorFontColor;
            self.lookupContent.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16.0f];
            CGFloat titleHeight = [titleContent heightWithFont: [UIFont fontWithName:LYZTheme_Font_Regular size:16.0f] constrainedToWidth:SCREEN_WIDTH - 130];
            self.lookupContent.frame =CGRectMake(_lookupTitle.right, self.lookupTitle.y+[self spaceHeight], SCREEN_WIDTH -2*DefaultLeftSpace - 90,  titleHeight);
            self.lookupContent.text = titleContent;
        }
        
        //收件地址
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   %@\n%@",name,phone,address]];
        // 创建文字属性
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
        [attriStr addAttributes:attriBute1 range:NSMakeRange(0, name.length + phone.length +  3)]; //3 为空格数
        NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
        [attriStr addAttributes:attriBute2 range:NSMakeRange(name.length + phone.length +  3 + 1, address.length)];
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect addressRect = [attriStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 130, CGFLOAT_MAX) options:options context:nil];
        CGFloat addressHeight = addressRect.size.height;
        self.addressTitle.frame =CGRectMake(DefaultLeftSpace, self.lookupContent.bottom, 90, 47);
        self.addressContent.frame = CGRectMake(self.addressTitle.right, self.addressTitle.y + [self spaceHeight] , SCREEN_WIDTH -2*DefaultLeftSpace - 90, addressHeight);
        self.addressContent.attributedText = attriStr;
      
        self.remarkTitle.frame =CGRectMake(DefaultLeftSpace, self.addressContent.bottom, 90, 47);
        
        //收件地址
        NSMutableAttributedString * attriStr0 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",remark]];
      
        NSDictionary * attriBute02 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
        [attriStr0 addAttributes:attriBute02 range:NSMakeRange(0, remark.length)];
        NSStringDrawingOptions options0 = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect remarkRect = [attriStr0 boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 130, CGFLOAT_MAX) options:options0 context:nil];
        CGFloat remar = remarkRect.size.height;
        
        self.remarkContent.frame = CGRectMake(self.remarkTitle.right, self.remarkTitle.y + [self spaceHeight], SCREEN_WIDTH -2*DefaultLeftSpace - 90, remar);
        self.remarkContent.attributedText = attriStr0;
        self.mailTypeTitle.frame =CGRectMake(DefaultLeftSpace, self.remarkContent.bottom , 90, 47);
        self.mailTypeContent.frame = CGRectMake(self.mailTypeTitle.right, self.mailTypeTitle.y, SCREEN_WIDTH -2*DefaultLeftSpace - 90, 47);
        self.mailTypeContent.text = @"货到付款";
        
    }else if (model.invoiceType.integerValue == 1){
        //TODO: 电子发票
    
    }
}

- (void)selectedEvent {
    
}

#pragma mark - class property.


#pragma mark -- Private Method


+(CGFloat)cellHeightWithData:(id)data{
     BaseOrderInvoiceModel *model = (BaseOrderInvoiceModel *)data;
    NSString *titleContent = model.lookup;
    NSString *taxNum = model.taxNumber;
    NSString *name = model.recipient;
    NSString *phone = model.phone;
    NSString *address = model.address;
    NSString *remark = model.invoiceremark;

    CGFloat addressHeight;
    CGFloat remarkHeight = 0.0;
    CGFloat titleHeight;
    if (model.invoiceType.integerValue == 2) {
        if (model.taxNumber && ![model.taxNumber isEqualToString:@""]) {
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",titleContent,taxNum]];
            // 创建文字属性
            NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
            [attriStr addAttributes:attriBute1 range:NSMakeRange(0, titleContent.length)];
            NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
            [attriStr addAttributes:attriBute2 range:NSMakeRange(titleContent.length + 1, taxNum.length)];
            NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect titleRect = [attriStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 130, CGFLOAT_MAX) options:options context:nil];
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
        CGRect addressRect = [attriStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 130, CGFLOAT_MAX) options:options context:nil];
        addressHeight = addressRect.size.height;
        
        NSMutableAttributedString * attriStr0 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",remark]];
        
        NSDictionary * attriBute02 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
        [attriStr0 addAttributes:attriBute02 range:NSMakeRange(0, remark.length)];
        NSStringDrawingOptions options0 = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect remarkRect = [attriStr0 boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 130, CGFLOAT_MAX) options:options0 context:nil];
        remarkHeight = remarkRect.size.height;
        
    }else {
        titleHeight = 30;
        addressHeight = 30;
    }
    CGFloat spaceHeight =  (47 - [@"temp" heightWithFont: [UIFont fontWithName:LYZTheme_Font_Light size:14.0f] constrainedToWidth:SCREEN_WIDTH - 130])/2.0;
    return 47 + titleHeight + spaceHeight + addressHeight + remarkHeight + 47;
}

-(CGFloat) spaceHeight {
      return (47 - [@"temp" heightWithFont: [UIFont fontWithName:LYZTheme_Font_Light size:14.0f] constrainedToWidth:SCREEN_WIDTH - 130])/2.0;
}

@end
