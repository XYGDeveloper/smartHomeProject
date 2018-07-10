//
//  VipApplyCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "VipApplyCell.h"
#import "UIView+SetRect.h"
#import "VipApplyInfoModel.h"

@interface VipApplyCell  ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *contentTextField;

@end

static CGFloat _VipApplyCellHeight = 52.f;

@implementation VipApplyCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, VipApplyCell.cellHeight)];
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.titleLabel];
    
    self.contentTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.titleLabel.right + 15, 0, 180, VipApplyCell.cellHeight)];
    self.contentTextField.delegate = self;
    self.contentTextField.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.contentTextField.textColor = LYZTheme_BlackFontColorFontColor;
    self.contentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.contentTextField];
}


- (void)loadContent {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self.data;
        self.titleLabel.text = dic[@"title"];
        if ([dic[@"title"] isEqualToString:@"姓名"]) {
            self.contentTextField.placeholder = @"请填写身份证上姓名";
        }else if ([dic[@"title"] isEqualToString:@"身份证号"]) {
            self.contentTextField.placeholder = @"请填写身份证号码";
        }else if ([dic[@"title"] isEqualToString:@"Email(选填)"]) {
            self.contentTextField.placeholder = @"请填写电子邮箱";
            self.contentTextField.keyboardType = UIKeyboardTypeEmailAddress;
        }else {
            self.contentTextField.placeholder = @"请填写好友邀请码";
        }
    }
}

- (void)selectedEvent {
    
}
#pragma mark - TextField Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
     NSDictionary *dic = (NSDictionary *)self.data;
    VipApplyInfoModel *model = dic[@"data"];
    if ([dic[@"title"] isEqualToString:@"姓名"]) {
        model.name = textField.text;
    }else if ([dic[@"title"] isEqualToString:@"身份证号"]) {
        model.IDNum = textField.text;
    }else if ([dic[@"title"] isEqualToString:@"Email(选填)"]) {
        model.email = textField.text;
    }else {
        model.inviteCode = textField.text;
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _VipApplyCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _VipApplyCellHeight;
}


-(void)dealloc{
    LYLog(@"dealloc");
}


@end
