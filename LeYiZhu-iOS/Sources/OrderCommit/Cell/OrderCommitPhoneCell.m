//
//  OrderCommitPhoneCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/6.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderCommitPhoneCell.h"
#import "OrderCommitCellMarcos.h"
#import "LYZOrderGuestInfoModel.h"
#import "LYZOrderCommitViewController.h"

@interface OrderCommitPhoneCell()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *phoneTF;

@end

static CGFloat _OrderPhoneCellHeight = 47.0f;

@implementation OrderCommitPhoneCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    UILabel *phoneTitltLabel =  [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, OrderCommitPhoneCell.cellHeight)];
    phoneTitltLabel.textColor = LYZTheme_warmGreyFontColor;
    phoneTitltLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14.0f];
    phoneTitltLabel.text = @"联系人电话";
    [self addSubview:phoneTitltLabel];
    
    
    self.phoneTF =  [[UITextField alloc] initWithFrame:CGRectMake(phoneTitltLabel.right +  kTitle_Content_Space, 0, 160, OrderCommitPhoneCell.cellHeight)];
    self.phoneTF.delegate = self;
    self.phoneTF.textColor = LYZTheme_greyishBrownFontColor;
    self.phoneTF.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0f];
//    self.phoneTF.clearsOnBeginEditing = YES;
    self.phoneTF.clearButtonMode =  UITextFieldViewModeWhileEditing;
    self.phoneTF.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.phoneTF];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kTitle_Content_Space - 10, (OrderCommitPhoneCell.cellHeight  - 10) /2.0, 10, 10)];
    img.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:img];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 50, 0, 50 +DefaultLeftSpace, OrderCommitPhoneCell.cellHeight);
    [btn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}


- (void)loadContent {
    LYZOrderGuestInfoModel *model = (LYZOrderGuestInfoModel *)self.data;
    self.phoneTF.text = model.phoneNum;
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _OrderPhoneCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderPhoneCellHeight;
}

#pragma mark --TF Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    LYZOrderGuestInfoModel *model = (LYZOrderGuestInfoModel *)self.data;
    model.phoneNum = textField.text;
}

-(void)phoneBtnClick:(UIButton *)sender{
    if ([self.controller respondsToSelector:@selector(chooseLocalContact)]) {
        [(LYZOrderCommitViewController *)(self.controller) chooseLocalContact];
    }
}


@end
