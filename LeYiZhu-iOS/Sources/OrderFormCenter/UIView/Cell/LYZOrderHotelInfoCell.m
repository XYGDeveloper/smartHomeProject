//
//  LYZOrderHotelInfoCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderHotelInfoCell.h"
#import "BaseOrderDetailModel.h"


@interface LYZOrderHotelInfoCell ()

@property (nonatomic ,strong) UILabel *hotelNameLabel;

@property (nonatomic , strong) UILabel *roomTypeLabel;

@property (nonatomic, strong) UILabel *roomCountLabel;

@end

static CGFloat _OrderHotelInfoCellHeight = 80.0f;

@implementation LYZOrderHotelInfoCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    self.hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 15, 200, 25)];
    self.hotelNameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.hotelNameLabel.textColor = [UIColor blackColor];
    [self addSubview:self.hotelNameLabel];
    
    self.roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, self.hotelNameLabel.bottom, SCREEN_WIDTH -2 *DefaultLeftSpace , 25)];
    self.roomTypeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.roomTypeLabel.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.roomTypeLabel];
    
//    self.roomCountLabel = [[UILabel alloc]  initWithFrame:CGRectMake(self.roomTypeLabel.right + 10 , self.hotelNameLabel.bottom, 100, 25)];
////    self.roomCountLabel.textAlignment = NSTextAlignmentRight;
//    self.roomCountLabel.textColor = LYZTheme_warmGreyFontColor;
//    self.roomCountLabel.font =  [UIFont fontWithName:LYZTheme_Font_Regular size:14];
//    [self addSubview:self.roomCountLabel];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -DefaultLeftSpace -10  , (LYZOrderHotelInfoCell.cellHeight -10)/2.0, 10, 10)];
    imgView.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:imgView];
    
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBtn.frame = CGRectMake(SCREEN_WIDTH -LYZOrderHotelInfoCell.cellHeight  , 0, LYZOrderHotelInfoCell.cellHeight, LYZOrderHotelInfoCell.cellHeight);
    [arrowBtn addTarget:self action:@selector(arrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:arrowBtn];
}


- (void)loadContent {
  
    
    if ([self.data isKindOfClass:[BaseOrderDetailModel class]]) {
        BaseOrderDetailModel *model = (BaseOrderDetailModel *)self.data;
        self.hotelNameLabel.text = model.hotelJson.hotelName;
        self.roomTypeLabel.text = [NSString stringWithFormat:@"%@     %@间",model.hotelJson.roomType,model.orderJson.payNum];
        self.roomCountLabel.text = [NSString stringWithFormat:@"%@间",model.orderJson.payNum];
    }
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderHotelInfoCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _OrderHotelInfoCellHeight;
}

#pragma mark -- Btn Actions

-(void)arrowBtnClick:(id)sender{
    if (self.toHotel) {
        self.toHotel();
    }
}

-(void)dealloc{
    LYLog(@"dealloc");
}

@end
