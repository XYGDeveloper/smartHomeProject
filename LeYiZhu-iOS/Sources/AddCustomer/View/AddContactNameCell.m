//
//  AddContactCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/4.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AddContactNameCell.h"
#import "LYZContactsModel.h"

@interface AddContactNameCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTF;

@end

static CGFloat _contactNameCellHeight = 60.0f;

@implementation AddContactNameCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    UILabel *titltLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 100, AddContactNameCell.cellHeight)];
    titltLabel.textColor = LYZTheme_warmGreyFontColor;
    titltLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    titltLabel.text = @"* 姓    名";
    [self addSubview:titltLabel];
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(titltLabel.right, 0, 150, AddContactNameCell.cellHeight)];
    _nameTF.delegate = self;
    _nameTF.textColor = [UIColor blackColor];
    _nameTF.placeholder = @"输入联系人姓名";
    _nameTF.clearButtonMode =     UITextFieldViewModeWhileEditing
    ;
    _nameTF.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [self addSubview:_nameTF];
}

- (void)loadContent {
    LYZContactsModel *model = (LYZContactsModel *)self.data;
    self.nameTF.text = model.name;
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _contactNameCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return  _contactNameCellHeight;
}


#pragma mark - Btn Actions

-(void)textFieldDidEndEditing:(UITextField *)textField{
      LYZContactsModel *model = (LYZContactsModel *)self.data;
    model.name = textField.text;
}
@end
