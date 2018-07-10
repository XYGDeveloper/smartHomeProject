//
//  CarTypeCell.m
//  LeYiZhu-iOS
//
//  Created by L on 2018/1/5.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "CarTypeCell.h"
#import "LYZContactsModel.h"
#import "BRPickerView.h"

@interface CarTypeCell()<UITextFieldDelegate>

@end

static CGFloat _contactNameCellHeight = 60.0f;

@implementation CarTypeCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    UILabel *titltLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 100, CarTypeCell.cellHeight)];
    titltLabel.textColor = LYZTheme_warmGreyFontColor;
    titltLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    titltLabel.text = @"  证件类型";
    [self addSubview:titltLabel];
    _genderTF = [[UILabel alloc] initWithFrame:CGRectMake(titltLabel.right, 0, 150, CarTypeCell.cellHeight)];
    _genderTF.textColor = [UIColor blackColor];
    _genderTF.text = @"身份证";
    _genderTF.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [self addSubview:_genderTF];
    
}

- (void)loadContent {
    self.genderTF.text = @"身份证";
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

//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    LYZContactsModel *model = (LYZContactsModel *)self.data;
//    model.paperworkType = textField.text;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
