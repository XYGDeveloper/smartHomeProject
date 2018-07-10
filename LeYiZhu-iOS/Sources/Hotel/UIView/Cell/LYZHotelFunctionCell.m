//
//  LYZHotelFunctionCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZHotelFunctionCell.h"
#import "LYZHotelViewController.h"

#define kImgHeight 32.0f
#define kBtnTag 100

@interface LYZHotelFunctionCell ()

@end

static CGFloat _OrderHotelFunctionCellHeight = 79.0f;

@implementation LYZHotelFunctionCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    //faceCheckIn
    UIImageView *faceImgView = [[UIImageView alloc]  initWithFrame:CGRectMake(38, 9.5, kImgHeight, kImgHeight)];
    faceImgView.image = [UIImage imageNamed:@"hotle_icon_face"];
    [self addSubview:faceImgView];
    
    UILabel *faceTitleLabel = [[UILabel alloc] init];
    faceTitleLabel.height = 20.0f;
    faceTitleLabel.width =  100.0f;
    faceTitleLabel.center = faceImgView.center;
    faceTitleLabel.y = faceImgView.bottom + 9;
    faceTitleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    faceTitleLabel.textAlignment = NSTextAlignmentCenter;
    faceTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    faceTitleLabel.text = @"刷脸入住";
    [self addSubview:faceTitleLabel];
    
    UIButton *faceCheckinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faceCheckinBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3.0, LYZHotelFunctionCell.cellHeight);
    faceCheckinBtn.tag = kBtnTag;

    [faceCheckinBtn addTarget:self action:@selector(hotelFeature:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:faceCheckinBtn];
    

    //OpenDoor
    
    UIImageView *openImgView = [[UIImageView alloc]  initWithFrame:CGRectMake((SCREEN_WIDTH - kImgHeight) / 2.0, 9.5, kImgHeight, kImgHeight)];
    openImgView.image = [UIImage imageNamed:@"hotle_icon_key"];
    [self addSubview:openImgView];
    
    UILabel *keyTitleLabel = [[UILabel alloc] init];
    keyTitleLabel.height = 20.0f;
    keyTitleLabel.width =  100.0f;
    keyTitleLabel.center = openImgView.center;
    keyTitleLabel.y = openImgView.bottom + 9;
    keyTitleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    keyTitleLabel.textAlignment = NSTextAlignmentCenter;
    keyTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    keyTitleLabel.text = @"无卡开锁";
    [self addSubview:keyTitleLabel];
    
    UIButton *openDoorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openDoorBtn.frame = CGRectMake(SCREEN_WIDTH/3.0, 0 ,SCREEN_WIDTH/3.0 , LYZHotelFunctionCell.cellHeight);
    openDoorBtn.tag = kBtnTag+ 1;
    [openDoorBtn addTarget:self action:@selector(hotelFeature:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:openDoorBtn];
    
    
    // free
    
    UIImageView *freeImgView = [[UIImageView alloc]  initWithFrame:CGRectMake(SCREEN_WIDTH - 38 - kImgHeight, 9.5, kImgHeight, kImgHeight)];
    freeImgView.image = [UIImage imageNamed:@"hotle_icon_free"];
    [self addSubview:freeImgView];
    
    UILabel *freeTitleLabel = [[UILabel alloc] init];
    freeTitleLabel.height = 20.0f;
    freeTitleLabel.width =  100.0f;
    freeTitleLabel.center = freeImgView.center;
    freeTitleLabel.y = freeImgView.bottom + 9;
    freeTitleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    freeTitleLabel.textAlignment = NSTextAlignmentCenter;
    freeTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    freeTitleLabel.text = @"免排队/查房";
    [self addSubview:freeTitleLabel];
    
    UIButton *freeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    freeBtn.frame = CGRectMake(SCREEN_WIDTH*2/3.0, 0 ,SCREEN_WIDTH/3.0 , LYZHotelFunctionCell.cellHeight);
    freeBtn.tag = kBtnTag + 2;
    [freeBtn addTarget:self action:@selector(hotelFeature:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:freeBtn];
    
    
}


- (void)loadContent {
    
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _OrderHotelFunctionCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderHotelFunctionCellHeight;
}

#pragma mark --Btn Actions

-(void)hotelFeature:(UIButton *)sender{
    LYZHotelViewController *vc = (LYZHotelViewController *)self.controller;
    if ([vc respondsToSelector:@selector(showHotelFeature:)]) {
        [vc showHotelFeature:sender.tag  - kBtnTag];
    }

}


@end
