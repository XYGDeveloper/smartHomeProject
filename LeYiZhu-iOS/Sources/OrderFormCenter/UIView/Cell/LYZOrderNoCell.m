//
//  LYZOrderNoCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderNoCell.h"
#import "BaseOrderDetailModel.h"


@interface LYZOrderNoCell ()

@property (nonatomic, strong) UILabel *orderNoLabel;

@end

static CGFloat _OrderNoCellHeight = 50.0f;

@implementation LYZOrderNoCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, LYZOrderNoCell.cellHeight)];
    titleLabel.textColor = LYZTheme_warmGreyFontColor;
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    titleLabel.text = @"订单编号";
    [self addSubview:titleLabel];
    
    self.orderNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right , 0, 200,  LYZOrderNoCell.cellHeight)];
    self.orderNoLabel.textColor = LYZTheme_warmGreyFontColor;
    self.orderNoLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self addSubview:self.orderNoLabel];
}


- (void)loadContent {
    if ([self.data isKindOfClass:[BaseOrderDetailModel class]]) {
        BaseOrderDetailModel *model = (BaseOrderDetailModel *)self.data;
        self.orderNoLabel.text = model.orderJson.orderNO;
    }
}

- (void)selectedEvent {
    
 }

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _OrderNoCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderNoCellHeight;
}


-(void)dealloc{
    LYLog(@"dealloc");
}

@end
