//
//  LYZHotelBannerCollectionViewCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZHotelBannerCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "LYZHotelViewController.h"
#import "LoginManager.h"

@interface LYZHotelBannerCollectionViewCell ()

@property (nonatomic, strong) UIImageView *hotelImgView;

@property (nonatomic , strong) UILabel *roomTypeLabel;

@property (nonatomic , strong) UILabel * roomInfoLabel;

@property (nonatomic, strong) UILabel *remainCountLabel;


@end

@implementation LYZHotelBannerCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;
        self.hotelImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:self.hotelImgView];
        
        
        UIView *bottomBGView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.width, 40)];
        bottomBGView.backgroundColor = [UIColor blackColor];
        bottomBGView.alpha = 0.75;
        [self addSubview:bottomBGView];
        
        self.roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 2, self.width,20)];
        self.roomTypeLabel.font =[UIFont fontWithName:LYZTheme_Font_Regular size:14];
        self.roomTypeLabel.textColor = [UIColor whiteColor];
        [bottomBGView addSubview:self.roomTypeLabel];
        
        self.roomInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.roomTypeLabel.bottom, self.width, 20)];
        self.roomInfoLabel.font =[UIFont fontWithName:LYZTheme_Font_Regular size:12];
        self.roomInfoLabel.textColor = [UIColor whiteColor];
        [bottomBGView addSubview:self.roomInfoLabel];
        
//        self.remainCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
//        self.remainCountLabel.right = self.width - 10;
//        self.remainCountLabel.centerY = 22;
//        self.remainCountLabel.textAlignment = NSTextAlignmentRight;
//        self.remainCountLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
//        self.remainCountLabel.textColor = [UIColor whiteColor];
//        [bottomBGView addSubview:self.remainCountLabel];

    }
    
    return self;
    
}




-(void)setHotelRoomsModel:(HotelRoomsModel *)model{
  
    
    [self.hotelImgView sd_setImageWithURL:[NSURL URLWithString:model.imgPath]];
    

    self.roomTypeLabel.text = model.roomType;
    self.roomInfoLabel.text = [NSString stringWithFormat:@"%@m² %@",model.roomSize,model.bedType];
//    self.remainCountLabel.text = [NSString stringWithFormat:@"剩余%@间",model.validRoomSize];
 
}



-(void)orderBtnClick:(UIButton *)sender{
    if (self.orderRoom) {
        self.orderRoom();
    }
}

@end
