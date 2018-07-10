//
//  LYZRenewPhoneCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRenewPhoneCell.h"

@interface LYZRenewPhoneCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneTF;

@end

static CGFloat _RenewPhoneCellHeight = 47.0f;

@implementation LYZRenewPhoneCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    UILabel *phoneTitltLabel =  [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 100, LYZRenewPhoneCell.cellHeight)];
    phoneTitltLabel.textColor = LYZTheme_warmGreyFontColor;
    phoneTitltLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14.0f];
    phoneTitltLabel.text = @"联系人电话";
    [self addSubview:phoneTitltLabel];
    
    
    self.phoneTF =  [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 160, LYZRenewPhoneCell.cellHeight)];
    self.phoneTF.delegate = self;
    self.phoneTF.textColor = LYZTheme_greyishBrownFontColor;
    self.phoneTF.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0f];
    self.phoneTF.clearsOnBeginEditing = YES;
    self.phoneTF.clearButtonMode =  UITextFieldViewModeWhileEditing;
    self.phoneTF.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.phoneTF];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 10, (LYZRenewPhoneCell.cellHeight  - 10) /2.0, 10, 10)];
    img.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:img];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 50, 0, 50 +DefaultLeftSpace, LYZRenewPhoneCell.cellHeight);
    [btn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}


- (void)loadContent {
    NSString *phone = (NSString *)self.data;
    self.phoneTF.text = phone;
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _RenewPhoneCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _RenewPhoneCellHeight;
}

#pragma mark --TF Delegate



-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *phone = (NSString *)self.data;
    phone = textField.text;
}


-(void)phoneBtnClick:(UIButton *)sender{
    
}

@end
