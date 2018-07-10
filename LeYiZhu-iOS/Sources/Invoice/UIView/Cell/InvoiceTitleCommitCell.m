//
//  InvoiceTitleCommitCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "InvoiceTitleCommitCell.h"
#import "NSString+Size.h"
#import "InvoiceTitleModel.h"
#import "OrderInvoiceModel.h"

@interface InvoiceTitleCommitCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *arrowImgView;

@end

@implementation InvoiceTitleCommitCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self addSubview:self.titleLabel];

    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    
    self.arrowImgView = [[UIImageView alloc]  initWithFrame:CGRectZero];
    self.arrowImgView.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:self.arrowImgView];
}


- (void)loadContent {
    NSDictionary *dic = self.data;
    self.titleLabel.text = [dic objectForKey:@"title"];
    OrderInvoiceModel *model = (OrderInvoiceModel *)[dic objectForKey:@"content"];
    CGFloat cellHeight = [[self class] cellHeightWithData:model.title];
    self.titleLabel.frame = CGRectMake(DefaultLeftSpace ,0, 60, cellHeight);
    self.contentLabel.frame = CGRectMake(self.titleLabel.right + 20 , 0, SCREEN_WIDTH - 150, cellHeight);
    self.arrowImgView.frame = CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 10, (cellHeight - 10)/2.0, 10, 10);
    if (!model.title) { // 为空
        self.contentLabel.textColor = RGB(200, 200, 200);
        self.contentLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
        self.contentLabel.text =  [dic objectForKey:@"placeHolder"];
    }else{
        InvoiceTitleModel *titleModel =model.title;
        NSString *titleContent = titleModel.taxTitle;
        NSString *taxNum = titleModel.taxNum;
        
        if (titleModel.type == enterpriseType) {
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",titleContent,taxNum]];
            // 创建文字属性
            NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
            [attriStr addAttributes:attriBute1 range:NSMakeRange(0, titleContent.length)];
            NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
            [attriStr addAttributes:attriBute2 range:NSMakeRange(titleContent.length + 1, taxNum.length)];
            self.contentLabel.attributedText = attriStr;
        }else{
            self.contentLabel.font =[UIFont fontWithName:LYZTheme_Font_Regular size:16];
            self.contentLabel.textColor = LYZTheme_BlackFontColorFontColor;
            self.contentLabel.text = titleContent;
        }
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
    if (model) {
        if (model.type == enterpriseType) {
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",titleContent,taxNum]];
            // 创建文字属性
            NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
            [attriStr addAttributes:attriBute1 range:NSMakeRange(0, titleContent.length)];
            NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
            [attriStr addAttributes:attriBute2 range:NSMakeRange(titleContent.length + 1, taxNum.length)];
            NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect labelRect = [attriStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 150, CGFLOAT_MAX) options:options context:nil];
            height = labelRect.size.height;
        }else{
            height = [titleContent heightWithFont: [UIFont fontWithName:LYZTheme_Font_Light size:16.0f] constrainedToWidth:SCREEN_WIDTH - 150];
        }
        height += 20;
        if (height < 62) {
            height = 62;
        }
        return height ;
    }else{
        return 62;
    }
    
}

@end
