//
//  LYZRenewGuestInfoCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRenewGuestInfoCell.h"
#import "RefillInfoModel.h"
#import "LYZRefillGuestInfoModel.h"
#import "LYZRenewViewController.h"

@interface LYZRenewGuestInfoCell ()

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic ,strong) UILabel *roomNumLabel;
@property (nonatomic ,strong) UILabel *guestNameLabel;
@property (nonatomic , strong) UILabel *dateStatusLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

static CGFloat _RenewGuestInfoCellHeight = 85.0f;

@implementation LYZRenewGuestInfoCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(DefaultLeftSpace,( LYZRenewGuestInfoCell.cellHeight - 22)/2.0, 22, 22);
    [self.selectBtn setImage:[UIImage imageNamed:@"indent_icon_unchoose"] forState:UIControlStateNormal];
    [self.selectBtn addTarget:self action:@selector(renewBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.selectBtn.right, ( LYZRenewGuestInfoCell.cellHeight - 20)/2.0, 48, 20)];
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0f];
    titleLabel.textColor = LYZTheme_paleBrown;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"续住";
    [self addSubview:titleLabel];
    
    self.roomNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 18, 70, 22)];
    self.roomNumLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16.0f];
    self.roomNumLabel.textColor =  RGB(192, 192, 192);
    self.roomNumLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.roomNumLabel];
    
    self.guestNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, self.roomNumLabel.bottom + 5,70, 22)];
    self.guestNameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16.0f];
    self.guestNameLabel.textColor = RGB(192, 192, 192);
    self.guestNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.guestNameLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 148, 16, 0.5, 53)];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
    
    self.dateStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(line.right, 17, SCREEN_WIDTH - line.right, 15)];
    self.dateStatusLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15.0f];
    self.dateStatusLabel.textColor = LYZTheme_paleGreyFontColor;
    self.dateStatusLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dateStatusLabel];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(line.right, self.dateStatusLabel.bottom + 8, SCREEN_WIDTH - line.right, 28)];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dateLabel];
    
    UIButton *datePickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    datePickBtn.frame = CGRectMake(line.right, 0,  SCREEN_WIDTH - line.right, LYZRenewGuestInfoCell.cellHeight);
    [datePickBtn addTarget:self action:@selector(datePickClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:datePickBtn];
    
}

- (void)loadContent {
    LYZRefillGuestInfoModel *model = (LYZRefillGuestInfoModel *)self.data;
    UIImage *statusImg = model.isSelect ? [UIImage imageNamed:@"indent_icon_choose"]: [UIImage imageNamed:@"indent_icon_unchoose"];
    [self.selectBtn setImage:statusImg forState:UIControlStateNormal];
    self.roomNumLabel.text = model.roomNum;
    self.guestNameLabel.text = model.liveUserName;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter_1  = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"MM月dd日"];
    NSDate *renewDate = [formatter dateFromString:model.renewDate];
 
    self.dateLabel.text = [formatter_1 stringFromDate:renewDate];
    //入住至  原住至
    if (!model.isSelect) {
        self.dateStatusLabel.text =  @"原住至";
        self.dateStatusLabel.textColor = RGB(192, 192, 192);
        self.dateLabel.textColor = RGB(192, 192, 192);
        self.dateLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:20];
    }else{
        self.dateStatusLabel.text = @"续住至";
        self.dateStatusLabel.textColor = LYZTheme_BrownishGreyFontColor;
        self.dateLabel.textColor  = LYZTheme_paleBrown;
        self.dateLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:20];
    }
    
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _RenewGuestInfoCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _RenewGuestInfoCellHeight;
}

#pragma mark - Btn actions

-(void)renewBtnSelect:(UIButton *)sender{
    LYZRenewViewController *vc = (LYZRenewViewController *)self.controller;
    LYZRefillGuestInfoModel *model = (LYZRefillGuestInfoModel *)self.data;
    if ([vc respondsToSelector:@selector(renewBtnSelect:)]) {
        [vc renewBtnSelect:model.index];
    }
}

-(void)datePickClick:(id)sender{
    LYZRenewViewController *vc = (LYZRenewViewController *)self.controller;
    LYZRefillGuestInfoModel *model = (LYZRefillGuestInfoModel *)self.data;
    if ([vc respondsToSelector:@selector(datePick:)]) {
        [vc datePick:model.index];
    }
}

@end
