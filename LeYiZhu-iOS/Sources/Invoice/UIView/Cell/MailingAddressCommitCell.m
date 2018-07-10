//
//  MailingAddressCommitCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "MailingAddressCommitCell.h"
#import "NSString+Size.h"
#import "RecieverInfoModel.h"
#import "OrderInvoiceModel.h"

@interface MailingAddressCommitCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *arrowImgView;

@end


@implementation MailingAddressCommitCell

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
    CGFloat cellHeight = [[self class] cellHeightWithData:model.recieverInfo];
    self.titleLabel.frame = CGRectMake(DefaultLeftSpace ,0, 60, cellHeight);
    self.contentLabel.frame = CGRectMake(self.titleLabel.right + 20 , 0, SCREEN_WIDTH - 150, cellHeight);
    self.arrowImgView.frame = CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 10, (cellHeight - 10)/2.0, 10, 10);
    if (!model.recieverInfo) { // 为空
        self.contentLabel.textColor = RGB(200, 200, 200);
        self.contentLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
        self.contentLabel.text =  [dic objectForKey:@"placeHolder"];
    }else{
        RecieverInfoModel *reciever = model.recieverInfo;
        NSString *name = reciever.recipient;
        NSString *phone = reciever.phone;
         NSString *address = [NSString stringWithFormat:@"%@%@%@%@",reciever.province,reciever.city,reciever.area,reciever.address];
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   %@\n%@",name,phone,address]];
        // 创建文字属性
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
        [attriStr addAttributes:attriBute1 range:NSMakeRange(0, name.length + phone.length +  3)]; //3 为空格数
        NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
        [attriStr addAttributes:attriBute2 range:NSMakeRange(name.length + phone.length +  3 + 1, address.length)];
        self.contentLabel.attributedText = attriStr;
    }
}

- (void)selectedEvent {
    
    
}

#pragma mark - class property.

+(CGFloat)cellHeightWithData:(id)data{
    RecieverInfoModel *model = (RecieverInfoModel *)data;
    NSString *name = model.recipient;
    NSString *phone = model.phone;
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.area,model.address];
    CGFloat height;
    if (model) {
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   %@\n%@",name,phone,address]];
        // 创建文字属性
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
        [attriStr addAttributes:attriBute1 range:NSMakeRange(0, name.length + phone.length +  3)]; //3 为空格数
        NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
        [attriStr addAttributes:attriBute2 range:NSMakeRange(name.length + phone.length +  3 + 1, address.length)];
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect labelRect = [attriStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 150, CGFLOAT_MAX) options:options context:nil];
        height = labelRect.size.height;
        
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
