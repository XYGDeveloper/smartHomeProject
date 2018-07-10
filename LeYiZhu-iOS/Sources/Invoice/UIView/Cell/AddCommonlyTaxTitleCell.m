//
//  AddCommonlyTaxTitleCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AddCommonlyTaxTitleCell.h"

#define kAddImgWidth 13.0f

@interface AddCommonlyTaxTitleCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

static CGFloat _addTaxTitleCellHeight = 62.0f;

@implementation AddCommonlyTaxTitleCell


- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *addImgView = [[UIImageView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, (AddCommonlyTaxTitleCell.cellHeight - kAddImgWidth )/2.0, kAddImgWidth, kAddImgWidth)];
    addImgView.image = [UIImage imageNamed:@"icon_addTax"];
    [self addSubview:addImgView];
    
    self.titleLabel = [[UILabel alloc]  initWithFrame:CGRectMake(addImgView.right + 12, 0, 200, AddCommonlyTaxTitleCell.cellHeight)];
     self.titleLabel.textColor = LYZTheme_BlackFontColorFontColor;
     self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [self addSubview: self.titleLabel];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 10, (AddCommonlyTaxTitleCell.cellHeight - 10) /2.0, 10, 10)];
    img.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:img];
}


- (void)loadContent {
    self.titleLabel.text = self.data;
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _addTaxTitleCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _addTaxTitleCellHeight;
}


@end
