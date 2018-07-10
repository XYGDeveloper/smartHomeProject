//
//  OrderRoomCountCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderCommitRoomCountCell.h"
#import "LYZOrderGuestInfoModel.h"
#import "OrderCommitCellMarcos.h"
#import "LYZOrderCommitViewController.h"

@interface OrderCommitRoomCountCell ()

@property (nonatomic, strong) UILabel *roomCountLabel;

@end

static CGFloat _OrderRoomCountCellHeight = 47.0f;

@implementation OrderCommitRoomCountCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    UILabel *roomCountTitleLabel =  [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, OrderCommitRoomCountCell.cellHeight)];
    roomCountTitleLabel.textColor = LYZTheme_warmGreyFontColor;
    roomCountTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14.0f];
    roomCountTitleLabel.text = @"房间数量";
    [self addSubview:roomCountTitleLabel];
    
    self.roomCountLabel =  [[UILabel alloc] initWithFrame:CGRectMake(roomCountTitleLabel.right +  kTitle_Content_Space, 0, 100, OrderCommitRoomCountCell.cellHeight)];
    self.roomCountLabel.textColor = LYZTheme_greyishBrownFontColor;
    self.roomCountLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0f];
    [self addSubview:self.roomCountLabel];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kTitle_Content_Space - 10, (OrderCommitRoomCountCell.cellHeight  - 10) /2.0, 10, 10)];
    img.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:img];
    
    UIButton *roomCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    roomCountBtn.frame = CGRectMake(self.roomCountLabel.x, 0  , SCREEN_WIDTH - self.roomCountLabel.x,  OrderCommitRoomCountCell.cellHeight);
    [roomCountBtn addTarget:self action:@selector(chooseRoomCount:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:roomCountBtn];
    
}

- (void)loadContent {
    LYZOrderGuestInfoModel *model = (LYZOrderGuestInfoModel*)self.data;
    self.roomCountLabel.text =model.roomCount;
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _OrderRoomCountCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderRoomCountCellHeight;
}

#pragma mark --Btn Actions
-(void)chooseRoomCount:(UIButton *)sender{
    if ([self.controller respondsToSelector:@selector(chooseRoomCount)]) {
        [(LYZOrderCommitViewController *)(self.controller) chooseRoomCount];
    }
}

@end
