//
//  LYZOrderCheckInDateCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderCheckInDateCell.h"
#import "BaseOrderDetailModel.h"

@interface LYZOrderCheckInDateCell ()

@property (nonatomic ,strong) UILabel *checkInLabel;

@end

static CGFloat _OrderCheckInCellHeight = 50.0f;

@implementation LYZOrderCheckInDateCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, LYZOrderCheckInDateCell.cellHeight)];
    title.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    title.textColor = LYZTheme_warmGreyFontColor;
    title.text = @"入住时间";
    [self addSubview:title];
    
    self.checkInLabel = [[UILabel alloc] initWithFrame:CGRectMake(title.right, 0, 300,  LYZOrderCheckInDateCell.cellHeight)];
    self.checkInLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    self.checkInLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.checkInLabel];
    
}


- (void)loadContent {
    BaseOrderDetailModel *model = (BaseOrderDetailModel *)self.data;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter_1  = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"MM月dd日"];
    NSDate *checkIn = [formatter dateFromString:model.orderJson.checkInDate];
    NSDate *checkOut = [formatter dateFromString:model.orderJson.checkOutDate];
    OrderCheckInsModel *checkInsModel = model.childOrderInfoJar[0];
    self.checkInLabel.text = [NSString stringWithFormat:@"%@ 至 %@(共%@天)",[formatter_1 stringFromDate:checkIn], [formatter_1 stringFromDate:checkOut],checkInsModel.liveDay ];
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderCheckInCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _OrderCheckInCellHeight;
}

-(void)dealloc{

}

@end
