//
//  EditContactTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/12.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "EditContactTableViewCell.h"

@interface EditContactTableViewCell()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *keyLable;

@property (nonatomic, strong) UITextField *valueTextField;

@property (nonatomic,strong) UIButton *btn;

@end

@implementation EditContactTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _keyLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _keyLable.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_keyLable];
        
        _valueTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _valueTextField.delegate = self;
        [self.contentView addSubview:_valueTextField];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectZero;
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _btn.enabled = NO;
        [self.contentView addSubview:_btn];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setIkey:(NSString *)ikey{
    
    self.keyLable.text = ikey;
    [self layoutSubviews];
    
}

-(void)setIvalue:(NSString *)ivalue{
    self.valueTextField.text = ivalue;
}

-(void)setCanEdit:(BOOL)canEdit{
    _btn.enabled = canEdit;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
     self.keyLable.frame = CGRectMake(30, 0, 80, self.height);
    _btn.frame = _valueTextField.frame;
    self.valueTextField.frame = CGRectMake(_keyLable.right, 0, 160, self.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.cellEdited) {
        self.cellEdited(_keyLable.text,_valueTextField.text);
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([_keyLable.text isEqualToString:@"证件类型"] ) {
        
        return NO;
    }else{
        return YES;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
}

-(void)btnClick{
    if (self.textFieldClick) {
        self.textFieldClick();
    }
}
@end
