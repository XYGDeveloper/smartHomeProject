//
//  LYZStayFunctionCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayFunctionCell.h"

@interface LYZStayFunctionCell ()

@end

//static CGFloat _stayPlanShareCellHeight = 50.0f;

@implementation LYZStayFunctionCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 25, LYZStayFunctionCell.cellHeight);
    self.width = SCREEN_WIDTH - 25;
}

- (void)buildSubview {
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, self.width/3.0, 0.07 * SCREEN_HEIGHT);
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    shareBtn.backgroundColor = LYZTheme_paleBrown;
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(shareBtn.right, 0, 0.5, 0.07 * SCREEN_HEIGHT)];
    line.backgroundColor = LYZTheme_PinkishGeryColor;
    [self addSubview:line];
    
    UIButton *renewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    renewBtn.frame = CGRectMake(line.right, 0, self.width/3.0, 0.07 * SCREEN_HEIGHT);
    [renewBtn setTitle:@"续住" forState:UIControlStateNormal];
    renewBtn.backgroundColor = LYZTheme_paleBrown;
    [renewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [renewBtn addTarget:self action:@selector(renewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:renewBtn];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(renewBtn.right, 0, 0.5, 0.07 * SCREEN_HEIGHT)];
    line2.backgroundColor = LYZTheme_PinkishGeryColor;
    [self addSubview:line2];
    
    UIButton *checkOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkOutBtn.frame = CGRectMake(line2.right, 0, self.width/3.0, 0.07 * SCREEN_HEIGHT);
    [checkOutBtn setTitle:@"退房" forState:UIControlStateNormal];
    checkOutBtn.backgroundColor = LYZTheme_paleBrown;
    [checkOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [checkOutBtn addTarget:self action:@selector(checkOutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:checkOutBtn];
    
}

- (void)loadContent {
    
}

- (void)selectedEvent {
    
    
}

#pragma mark - class property.

//+ (void)setCellHeight:(CGFloat)cellHeight {
//
//    _stayPlanShareCellHeight = cellHeight;
//}
//
//+ (CGFloat)cellHeight {
//
//    return _stayPlanShareCellHeight;
//}

#pragma mark -- Btn Actions

-(void)shareBtnClick:(UIButton *)sender{
    if (self.shareBtn) {
        self.shareBtn();
    }
}

-(void)renewBtnClick:(UIButton *)sender{
    if (self.renewBtn) {
        self.renewBtn();
    }
}

-(void)checkOutBtnClick:(UIButton *)sender{
    if (self.checkOutBtn) {
        self.checkOutBtn();
    }
}

@end
