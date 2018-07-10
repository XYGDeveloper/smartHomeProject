//
//  AddressFillInCommonlyCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AddressFillInCommonlyCell.h"
#import "RecieverInfoModel.h"

#define kTitle_content_space 20.0f
#define kTFWidth 250.0f

@interface AddressFillInCommonlyCell ()

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UITextField *contentTF;

@end

static CGFloat _InvoiceAddressCommonlyCellHeight = 62.0f;

@implementation AddressFillInCommonlyCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 60, AddressFillInCommonlyCell.cellHeight)];
    self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self addSubview:self.titleLabel];
    self.contentTF = [[UITextField alloc] initWithFrame:CGRectMake(self.titleLabel.right + kTitle_content_space, 0, kTFWidth, AddressFillInCommonlyCell.cellHeight)];
    self.contentTF.textColor = LYZTheme_BlackFontColorFontColor;
    self.contentTF.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.contentTF.delegate = self;
    [self addSubview:self.contentTF];
}


- (void)loadContent {
    NSDictionary *dic = self.data;
    self.titleLabel.text = [dic objectForKey:@"title"];
    self.contentTF.placeholder = [dic objectForKey:@"placeHolder"];
    RecieverInfoModel *model = (RecieverInfoModel *)[dic objectForKey:@"content"];
    if ([[dic objectForKey:@"title"] isEqualToString:@"收件人"]) {
        self.contentTF.text = model.recipient;
    }else if ([[dic objectForKey:@"title"] isEqualToString:@"手机"]){
        self.contentTF.text = model.phone;
    }
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _InvoiceAddressCommonlyCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _InvoiceAddressCommonlyCellHeight;
}


#pragma mark -- UITextfield Delegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSDictionary *dic = self.data;
    RecieverInfoModel *model = (RecieverInfoModel *)[dic objectForKey:@"content"];
    if ([[dic objectForKey:@"title"] isEqualToString:@"收件人"]) {
        model.recipient = textField.text;
    }else if ([[dic objectForKey:@"title"] isEqualToString:@"手机"]){
        model.phone = textField.text;
    }
}


@end
