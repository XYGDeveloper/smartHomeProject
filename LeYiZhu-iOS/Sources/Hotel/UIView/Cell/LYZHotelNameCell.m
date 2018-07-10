//
//  LYZHotelNameLabel.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZHotelNameCell.h"
#import "LYZHotelDetailModel.h"
#import "LYZHotelViewController.h"

@interface LYZHotelNameCell ()

@property (nonatomic ,strong) UILabel *hotelAdressLabel;
@property (nonatomic, strong) UILabel *hotelStatusLabel;

@end

static CGFloat _OrderNoCellHeight = 45.0f;

@implementation LYZHotelNameCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
   
    
    self.hotelStatusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.hotelStatusLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.hotelStatusLabel.textColor = LYZTheme_paleBrown;
    [self addSubview:self.hotelStatusLabel];
    
    self.hotelAdressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.hotelAdressLabel.textColor =  LYZTheme_warmGreyFontColor;
    self.hotelAdressLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self addSubview:self.hotelAdressLabel];
    
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(SCREEN_WIDTH -LYZHotelNameCell.cellHeight- DefaultLeftSpace , 0, LYZHotelNameCell.cellHeight, LYZHotelNameCell.cellHeight);
    [navBtn setImage:[UIImage imageNamed:@"will_live_icon_loction"] forState:UIControlStateNormal];
    [navBtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:navBtn];
    
}


- (void)loadContent {
    LYZHotelDetailModel *model = (LYZHotelDetailModel *)self.data;
   
    if (model.status.integerValue == 2) {
        self.hotelStatusLabel.text = @"即将营业";
    }else if (model.status.integerValue == 3){
        self.hotelStatusLabel.text = @"停业中";
    }
    [self.hotelStatusLabel sizeToFit];
    self.hotelStatusLabel.centerY = _OrderNoCellHeight/2.0;
    self.hotelStatusLabel.right = SCREEN_WIDTH -LYZHotelNameCell.cellHeight - DefaultLeftSpace;
    
    self.hotelAdressLabel.text = model.address;
    self.hotelAdressLabel.width = SCREEN_WIDTH -_OrderNoCellHeight - 2*DefaultLeftSpace - 20 - self.hotelStatusLabel.width;
    self.hotelAdressLabel.height = _OrderNoCellHeight;
    self.hotelAdressLabel.x = DefaultLeftSpace;
    self.hotelAdressLabel.centerY = _OrderNoCellHeight/2.0;
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

#pragma mark - Btn Actions

-(void)navBtnClick:(id)sender{
    LYZHotelViewController *vc = (LYZHotelViewController *)self.controller;
    if ([vc respondsToSelector:@selector(navToBaiDuMap)]) {
        [vc navToBaiDuMap];
    }
}


@end
