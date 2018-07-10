//
//  OrderCommitHotelNameCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderCommitHotelNameCell.h"
#import "LYZHotelRoomDetailModel.h"

@interface OrderCommitHotelNameCell ()

@property (nonatomic, strong) UILabel *hotelNameLabel;

@end

static CGFloat _OrderHotelNameCellHeight = 47.0f;

@implementation OrderCommitHotelNameCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, SCREEN_WIDTH ,   OrderCommitHotelNameCell.cellHeight)];
    self.hotelNameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0f];
    self.hotelNameLabel.textColor =LYZTheme_BlackFontColorFontColor;
    [self addSubview:self.hotelNameLabel];
}

- (void)loadContent {
    LYZHotelRoomDetailModel *model = (LYZHotelRoomDetailModel *)self.data;
    self.hotelNameLabel.text = model.hotelname;
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _OrderHotelNameCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderHotelNameCellHeight;
}


@end
