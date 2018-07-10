//
//  LYZRenewOrderLiveUserInfoCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRenewOrderLiveUserInfoCell.h"
#import "OrderCheckInsModel.h"



@interface LYZRenewOrderLiveUserInfoCell  ()

@property (nonatomic, strong) UILabel *roomNumLabel;
@property (nonatomic, strong) UILabel  *guestNameLabel;
@property (nonatomic, strong) UILabel *dateDetailLabel;

@end

static CGFloat _RenewOrderLiveUserInfoCellHeight = 50.0f;

@implementation LYZRenewOrderLiveUserInfoCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    self.roomNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, LYZRenewOrderLiveUserInfoCell.cellHeight)];
    self.roomNumLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    self.roomNumLabel.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.roomNumLabel];
    
    self.guestNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.roomNumLabel.right, 0, 50,  LYZRenewOrderLiveUserInfoCell.cellHeight)];
    self.guestNameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    self.guestNameLabel.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.guestNameLabel];
    
    self.dateDetailLabel = [[UILabel  alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -DefaultLeftSpace - 200, 0, 200, LYZRenewOrderLiveUserInfoCell.cellHeight)];
    self.dateDetailLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    self.dateDetailLabel.textColor = LYZTheme_warmGreyFontColor;
    self.dateDetailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.dateDetailLabel];
}


- (void)loadContent {
    NSDictionary *dic = (NSDictionary *)self.data;
    NSNumber *roomNum = [dic objectForKey:@"roomNum"];
    OrderCheckInsModel *model = [dic objectForKey:@"Model"];
    self.roomNumLabel.text = [NSString stringWithFormat:@"房间%@",roomNum];
    self.guestNameLabel.text =   model.liveUserName;
    self.dateDetailLabel.text = [NSString stringWithFormat:@"续住至%@(共%@天)",model.checkOutDate,model.liveDay];
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _RenewOrderLiveUserInfoCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _RenewOrderLiveUserInfoCellHeight;
}


@end
