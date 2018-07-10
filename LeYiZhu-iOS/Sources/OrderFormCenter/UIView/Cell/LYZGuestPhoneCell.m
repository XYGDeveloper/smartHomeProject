//
//  LYZGuestPhoneCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZGuestPhoneCell.h"
#import "BaseOrderDetailModel.h"
#import "BaseOrderDetailModel.h"

@interface LYZGuestPhoneCell ()
@property (nonatomic , strong) UILabel *phoneLabel;
@end

static CGFloat _OrderGuestPhoneCellHeight = 50.0f;

@implementation LYZGuestPhoneCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)buildSubview {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, LYZGuestPhoneCell.cellHeight)];
    title.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    title.textColor = LYZTheme_warmGreyFontColor;
    title.text = @"联系电话";
    [self addSubview:title];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(title.right, 0, 300,  LYZGuestPhoneCell.cellHeight)];
    self.phoneLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    self.phoneLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.phoneLabel];
    
}


- (void)loadContent {
  
    if ([self.data isKindOfClass:[BaseOrderDetailModel class]]) {
        BaseOrderDetailModel *model = (BaseOrderDetailModel *)self.data;
        self.phoneLabel.text = model.orderJson.phone;
    }
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderGuestPhoneCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _OrderGuestPhoneCellHeight;
}

@end
