//
//  LYZInvoiceCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZInvoiceCell.h"
#import "OrderInvoiceModel.h"

#define kInvoiceCellHeight 62.0f
#define kTitle_content_space 20.0f
#define kTFWidth 250.0f

@interface LYZInvoiceCell ()<UITextFieldDelegate>

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UITextField *contentTF;

@end

@implementation LYZInvoiceCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 60, kInvoiceCellHeight)];
    self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self addSubview:self.titleLabel];
    self.contentTF = [[UITextField alloc] initWithFrame:CGRectMake(self.titleLabel.right + kTitle_content_space, 0, kTFWidth, kInvoiceCellHeight)];
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
    OrderInvoiceModel *model = (OrderInvoiceModel *)[dic objectForKey:@"content"];
    if ([[dic objectForKey:@"title"] isEqualToString:@"发票明细"]) {
        self.contentTF.text = model.detail;
    }else if ([[dic objectForKey:@"title"] isEqualToString:@"邮寄方式"]){
        self.contentTF.text = model.postType;
    }
    self.contentTF.enabled = NO;
}

- (void)selectedEvent {
    
}

#pragma mark -- UITextfield Delegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSDictionary *dic = self.data;
    OrderInvoiceModel *model = (OrderInvoiceModel *)[dic objectForKey:@"content"];
    if ([[dic objectForKey:@"title"] isEqualToString:@"发票明细"]) {
        model.detail = textField.text;
    }else if ([[dic objectForKey:@"title"] isEqualToString:@"邮寄方式"]){
        model.postType = textField.text;
    }
    
}




@end
