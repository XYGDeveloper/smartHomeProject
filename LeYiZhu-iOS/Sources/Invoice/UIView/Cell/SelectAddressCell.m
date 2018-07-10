//
//  SelectAddressCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "SelectAddressCell.h"
#import "RecieverInfoModel.h"
#import "NSString+Size.h"
#import "ChooseAddressViewController.h"

#define EditBtnWidth 62.0f
#define SelectImgWidth 22.0f

@interface SelectAddressCell ()

@property (nonatomic, strong) UIImageView *selectImgView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *editBtn;

@end

@implementation SelectAddressCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.selectImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.selectImgView.image = [UIImage imageNamed:@"indent_icon_unchoose"];
    [self addSubview:self.selectImgView];
    
    self.addressLabel           = [[UILabel alloc] initWithFrame:CGRectZero];
    self.addressLabel.numberOfLines = 0;
    [self addSubview:self.addressLabel];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame = CGRectZero;
    [self.editBtn setImage:[UIImage imageNamed:@"EditContacts"] forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editBtn];
    
}


- (void)loadContent {
    CGFloat cellHeight = [[self class] cellHeightWithData:self.data];
    RecieverInfoModel *model = (RecieverInfoModel *)self.data;
    NSString *reciever_phone =[NSString stringWithFormat:@"%@  %@",model.recipient,model.phone];
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.area,model.address];
    self.selectImgView.frame = CGRectMake(DefaultLeftSpace , (cellHeight - SelectImgWidth)/2.0, SelectImgWidth, SelectImgWidth);
    self.editBtn.frame = CGRectMake(SCREEN_WIDTH - EditBtnWidth , (cellHeight - EditBtnWidth)/2.0, EditBtnWidth, EditBtnWidth);
    self.addressLabel.frame = CGRectMake(self.selectImgView.right + 20, 0, SCREEN_WIDTH - 124, [[self class] cellHeightWithData:self.data]);
    if (model.isSelected) {
        [self.selectImgView setImage:[UIImage imageNamed:@"indent_icon_choose"]];
    }else{
        [self.selectImgView setImage:[UIImage imageNamed:@"indent_icon_unchoose"]];
    }
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",reciever_phone,address]];
        // 创建文字属性
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
        [attriStr addAttributes:attriBute1 range:NSMakeRange(0, reciever_phone.length)];
        NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
        [attriStr addAttributes:attriBute2 range:NSMakeRange(reciever_phone.length + 1, address.length)];
        self.addressLabel.attributedText = attriStr;
}

- (void)selectedEvent {
    
    
}

#pragma mark - class property.

+(CGFloat)cellHeightWithData:(id)data{
    RecieverInfoModel *model = (RecieverInfoModel *)data;
    NSString *reciever_phone =[NSString stringWithFormat:@"%@  %@",model.recipient,model.phone];
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.area, model.address];
    CGFloat height;
  
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",reciever_phone,address]];
    // 创建文字属性
    NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BlackFontColorFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:16]};
    [attriStr addAttributes:attriBute1 range:NSMakeRange(0, reciever_phone.length)];
    NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14]};
    [attriStr addAttributes:attriBute2 range:NSMakeRange(reciever_phone.length + 1, address.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect labelRect = [attriStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 124, CGFLOAT_MAX) options:options context:nil];
    height = labelRect.size.height;
    
    height += 20;
    if (height < 62) {
        height = 62;
    }
    return height ;
}


#pragma mark - Btn Actions

-(void)editBtnClick:(id)sender{
    ChooseAddressViewController *vc = (ChooseAddressViewController *)self.controller;
    RecieverInfoModel *model = (RecieverInfoModel *)self.data;
    if ([vc respondsToSelector:@selector(editBtnClick:)]) {
        [vc editBtnClick:model];
    }
}


@end
