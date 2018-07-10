//
//  LYZInvoceMarkTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by L on 2018/1/19.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "LYZInvoceMarkTableViewCell.h"
#import "OrderInvoiceModel.h"
#define kInvoiceCellHeight 120.0f
#define kTitle_content_space 20.0f
#define kTFWidth 250.0f
#import "BRPlaceholderTextView.h"

@interface LYZInvoceMarkTableViewCell()<UITextViewDelegate>

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) BRPlaceholderTextView *contentTF;

@end

@implementation LYZInvoceMarkTableViewCell
- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)buildSubview {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 60, 30)];
    self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self addSubview:self.titleLabel];
    self.contentTF = [[BRPlaceholderTextView alloc] initWithFrame:CGRectMake(self.titleLabel.right + kTitle_content_space-5, 0, kTFWidth, kInvoiceCellHeight)];
    self.contentTF.placeholder=@"请输入120字内的备注";
    self.contentTF.textColor = LYZTheme_BlackFontColorFontColor;
    self.contentTF.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.contentTF.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.contentTF.delegate = self;
    [self addSubview:self.contentTF];
    
    [self.contentTF setPlaceholderColor:[UIColor lightGrayColor]];
    [self.contentTF setPlaceholderOpacity:0.6];

    [self.contentTF addMaxTextLengthWithMaxLength:120 andEvent:^(BRPlaceholderTextView *text) {
        
        NSLog(@"----------");
    }];
    
    [self.contentTF addTextViewBeginEvent:^(BRPlaceholderTextView *text) {
        NSLog(@"begin");
    }];
    
    weakify(self);
    [self.contentTF addTextViewEndEvent:^(BRPlaceholderTextView *text) {
        NSLog(@"end");
        strongify(self);
        NSDictionary *dic = self.data;
        OrderInvoiceModel *model = (OrderInvoiceModel *)[dic objectForKey:@"content"];
        if ([[dic objectForKey:@"title"] isEqualToString:@"备注"]) {
            model.invoiceremark = self.contentTF.text;
        }
    }];

}

- (void)loadContent {
    NSDictionary *dic = self.data;
    self.titleLabel.text = [dic objectForKey:@"title"];
    self.contentTF.placeholder = [dic objectForKey:@"placeHolder"];
    OrderInvoiceModel *model = (OrderInvoiceModel *)[dic objectForKey:@"content"];
    if ([[dic objectForKey:@"title"] isEqualToString:@"备注"]) {
        self.contentTF.text = model.invoiceremark;
    }
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
