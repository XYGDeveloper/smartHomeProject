//
//  LYZGuestInfoCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZGuestInfoCell.h"
#import "OrderCheckInsModel.h"

@interface LYZGuestInfoCell ()

@property (nonatomic , strong) UILabel *roomNumLabel;
@property (nonatomic, strong)  UILabel *guestNameLabel;
@property (nonatomic ,strong)  UILabel *guestPaperworkNumLabel;

@end

static CGFloat _OrderGuestInfoCellHeight = 52.0f;

@implementation LYZGuestInfoCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
   self.roomNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, LYZGuestInfoCell.cellHeight)];
    self.roomNumLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0];
    self.roomNumLabel.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.roomNumLabel];
    
    self.guestNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.roomNumLabel.right, 0, 60,  LYZGuestInfoCell.cellHeight)];
    self.guestNameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    self.guestNameLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.guestNameLabel];
    
    self.guestPaperworkNumLabel = [[UILabel  alloc] initWithFrame:CGRectMake(self.guestNameLabel.right + 20 , 0, 100, LYZGuestInfoCell.cellHeight)];
    self.guestPaperworkNumLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    self.guestPaperworkNumLabel.textColor = LYZTheme_warmGreyFontColor;
    self.guestPaperworkNumLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.guestPaperworkNumLabel];
}


- (void)loadContent {
    NSDictionary *dic = (NSDictionary *)self.data;
    NSNumber *roomNum = [dic objectForKey:@"roomNum"];
    OrderCheckInsModel *model = [dic objectForKey:@"Model"];
    self.roomNumLabel.text = [NSString stringWithFormat:@"房间%@",roomNum];
    self.guestNameLabel.text = model.liveUserName;
    self.guestPaperworkNumLabel.text = model.liveUserPhone;
    
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderGuestInfoCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _OrderGuestInfoCellHeight;
}



@end
