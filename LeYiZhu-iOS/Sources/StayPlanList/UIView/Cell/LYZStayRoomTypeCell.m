//
//  LYZStayRoomTypeCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayRoomTypeCell.h"
#import "UserStaysModel.h"
#import "UIView+SetRect.h"

@interface LYZStayRoomTypeCell ()

@property (nonatomic, strong) UILabel *hotelNameLabel;

@property (nonatomic, strong) UILabel *roomTypeLabel;

@property (nonatomic, strong) UIImageView * arrowImgView;

@end

//static CGFloat _stayPlanHotelInfoCellHeight = 81.0;

@implementation LYZStayRoomTypeCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 25, LYZStayRoomTypeCell.cellHeight);
    self.width = SCREEN_WIDTH - 25;
}

- (void)buildSubview {
    
    self.hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.hotelNameLabel.textColor = [UIColor blackColor];
    CGFloat hotelNameFont = iPhone5_5s ? 15.0 : 17.0;
    self.hotelNameLabel.font= [UIFont fontWithName:LYZTheme_Font_Regular size:hotelNameFont];
    [self addSubview:self.hotelNameLabel];
    
    self.roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.roomTypeLabel.textColor =LYZTheme_greyishBrownFontColor;
    CGFloat roomTypeFont = iPhone5_5s ? 14.0 : 16.0;
    self.roomTypeLabel.font= [UIFont fontWithName:LYZTheme_Font_Regular size:roomTypeFont];
    [self addSubview:self.roomTypeLabel];
    
    self.arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - DefaultLeftSpace - 18, 0 , 18 , 18)];
    self.arrowImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.arrowImgView.image = [UIImage imageNamed:@"will_live_icon_show"];
    [self addSubview:self.arrowImgView];
}

- (void)loadContent {
     UserStaysModel *model = (UserStaysModel *)self.data;
    self.hotelNameLabel.text = model.hotelName;
    [self.hotelNameLabel sizeToFit];
   
    self.roomTypeLabel.text = [NSString stringWithFormat:@"房型：%@",model.roomType];
    [self.roomTypeLabel sizeToFit];
  
    [self layoutSubviews];
    
}

-(void)layoutSubviews{
    self.hotelNameLabel.x = DefaultLeftSpace;
    self.hotelNameLabel.bottom = self.height /2.0 - 3;
    
    self.roomTypeLabel.x = DefaultLeftSpace;
    self.roomTypeLabel.y = self.height /2.0 + 3;
    
    self.arrowImgView.centerY = self.height /2.0;
}

- (void)selectedEvent {
    
    
}

#pragma mark - class property.

//+ (void)setCellHeight:(CGFloat)cellHeight {
//
//    _stayPlanHotelInfoCellHeight = cellHeight;
//}
//
//+ (CGFloat)cellHeight {
//
//    return _stayPlanHotelInfoCellHeight;
//}


@end
