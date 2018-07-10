//
//  LYZRenewHotelNameCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRenewHotelNameCell.h"
#import "LYZHotelRoomDetailModel.h"

@interface LYZRenewHotelNameCell ()

@property (nonatomic, strong) UILabel *hotelNameLabel;



@end

static CGFloat _RenewHotelNameCellHeight = 47.0f;

@implementation LYZRenewHotelNameCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, SCREEN_WIDTH ,   LYZRenewHotelNameCell.cellHeight)];
    self.hotelNameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0f];
    self.hotelNameLabel.textColor = LYZTheme_BlackFontColorFontColor;
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
    
    _RenewHotelNameCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _RenewHotelNameCellHeight;
}


@end
