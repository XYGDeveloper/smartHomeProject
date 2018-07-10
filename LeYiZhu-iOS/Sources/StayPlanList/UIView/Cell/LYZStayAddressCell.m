//
//  LYZStayAddressCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayAddressCell.h"
#import "UserStaysModel.h"
#import "NSString+Size.h"
#import "UIView+SetRect.h"


@interface LYZStayAddressCell ()

@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView * arrowImgView;

@end

//static CGFloat _stayPlanHotelAddressCellHeight = 53.0;

@implementation LYZStayAddressCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 25, LYZStayAddressCell.cellHeight);
    self.width = SCREEN_WIDTH -25;
}

- (void)buildSubview {
    
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 15, 43, 20)];
//    title.textColor = LYZTheme_greyishBrownFontColor;
//    title.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15.0];
//    title.text = @"地址：";
//    [title sizeToFit];
//    [self addSubview:title];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace  , 15, self.width - 2* DefaultLeftSpace - 73, 0)];
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.textColor =LYZTheme_greyishBrownFontColor;
    CGFloat addressFont = iPhone5_5s ? 12 : 15;
    self.addressLabel.font= [UIFont fontWithName:LYZTheme_Font_Regular size:addressFont];
    [self addSubview:self.addressLabel];
    
    self.arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - DefaultLeftSpace - 22, 0 , 18 , 18)];
    self.arrowImgView.image = [UIImage imageNamed:@"will_live_icon_loction"];
    [self addSubview:self.arrowImgView];
   
}

- (void)loadContent {
     UserStaysModel *model = (UserStaysModel *)self.data;
    self.addressLabel.text = [NSString stringWithFormat:@"地址：%@",model.address];
    CGFloat addressFont = iPhone5_5s ? 12 : 15;
    CGFloat totalStringHeight = [ self.addressLabel.text heightWithFont:[UIFont fontWithName:LYZTheme_Font_Regular size:addressFont] constrainedToWidth:(SCREEN_WIDTH - 25 - 2* DefaultLeftSpace - 73)];
    self.addressLabel.height = totalStringHeight;
    
    [self layoutSubviews];
}

-(void)layoutSubviews{
    self.arrowImgView.centerY = self.height /2.0;
}

- (void)selectedEvent {
    
    
}

#pragma mark - class property.

//+ (void)setCellHeight:(CGFloat)cellHeight {
//
//    _stayPlanHotelAddressCellHeight = cellHeight;
//}
//
//+ (CGFloat)cellHeight {
//
//    return _stayPlanHotelAddressCellHeight;
//}

+(CGFloat)cellHeightWithData:(id)data{
     UserStaysModel *model = (UserStaysModel *)data;
     CGFloat addressFont = iPhone5_5s ? 12 : 15;
    CGFloat totalStringHeight = [ [NSString stringWithFormat:@"地址：%@",model.address] heightWithFont:[UIFont fontWithName:LYZTheme_Font_Regular size:addressFont] constrainedToWidth:(SCREEN_WIDTH - 25 - 2* DefaultLeftSpace - 73)];
//    if (totalStringHeight <= 53) {
//        realHeight = 53.0f;
//    }else{
//        realHeight = totalStringHeight + 32;
//    }
    return  totalStringHeight + 30;
}


@end
