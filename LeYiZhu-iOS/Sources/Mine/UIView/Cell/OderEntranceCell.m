//
//  OderEntranceCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/31.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "OderEntranceCell.h"
#import "LCVerticalBadgeBtn.h"
#import "LYZMineViewController.h"

#define IconBtnWidth (SCREEN_WIDTH - 17.5*2)/4.0
#define kOrderBtnTag 250

@interface OderEntranceCell ()

@property (nonatomic, strong) UIView *floatBackGroud;
@property (nonatomic, strong) LCVerticalBadgeBtn *allOrderBtn;
@property (nonatomic, strong) LCVerticalBadgeBtn *unpayOrderBtn;
@property (nonatomic, strong) LCVerticalBadgeBtn *uncheckInOrderBtn;
@property (nonatomic, strong) LCVerticalBadgeBtn *checkInOrderBtn;

@end

static CGFloat _OderEntranceCellHeight = 68.0f;

@implementation OderEntranceCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = NO;
}


- (void)buildSubview {
    UIImageView *backGoundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, OderEntranceCell.cellHeight/2.0)];
    backGoundImgView.image = [UIImage imageNamed:@"nav_bg_black"];
    [self addSubview:backGoundImgView];
    
    self.floatBackGroud = [[UIView alloc] initWithFrame:CGRectMake(17.5,0, SCREEN_WIDTH - 17.5*2, OderEntranceCell.cellHeight)];
    self.floatBackGroud.backgroundColor =[UIColor whiteColor];
    [self insertSubview:self.floatBackGroud atIndex:100];
    
    //全部订单
    self.allOrderBtn = [LCVerticalBadgeBtn buttonWithType:UIButtonTypeCustom];
    self.allOrderBtn.frame = CGRectMake(0, 0, IconBtnWidth, OderEntranceCell.cellHeight);
    self.allOrderBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:12];
    [self.allOrderBtn setTitleColor:LYZTheme_BlackFontColorFontColor forState:UIControlStateNormal];
    [self.allOrderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.allOrderBtn.tag = kOrderBtnTag;
    [self.allOrderBtn setImage:[UIImage imageNamed:@"me_icon_allorder"] forState:UIControlStateNormal];
    [self.allOrderBtn setTitle:@"全部订单" forState:UIControlStateNormal];
    [self.floatBackGroud addSubview:self.allOrderBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.allOrderBtn.right, (OderEntranceCell.cellHeight - 48)/2.0, 0.5, 48)];
    line.backgroundColor = kLineColor;
    [self.floatBackGroud addSubview:line];
    
    //待支付
    self.unpayOrderBtn = [LCVerticalBadgeBtn buttonWithType:UIButtonTypeCustom];
    self.unpayOrderBtn.frame = CGRectMake(line.right, 0, IconBtnWidth, OderEntranceCell.cellHeight);
    self.unpayOrderBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:12];
    [self.unpayOrderBtn setTitleColor:LYZTheme_BlackFontColorFontColor forState:UIControlStateNormal];
    [self.unpayOrderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.unpayOrderBtn.tag = kOrderBtnTag + 1;
    [self.unpayOrderBtn setImage:[UIImage imageNamed:@"me_icon_willpay"] forState:UIControlStateNormal];
    [self.unpayOrderBtn setTitle:@"待支付" forState:UIControlStateNormal];
    [self.floatBackGroud addSubview:self.unpayOrderBtn];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(self.unpayOrderBtn.right, (OderEntranceCell.cellHeight - 48)/2.0, 0.5, 48)];
    line2.backgroundColor = kLineColor;
    [self.floatBackGroud addSubview:line2];
    
    //待入住
    self.uncheckInOrderBtn = [LCVerticalBadgeBtn buttonWithType:UIButtonTypeCustom];
    self.uncheckInOrderBtn.frame = CGRectMake(line2.right, 0, IconBtnWidth, OderEntranceCell.cellHeight);
    self.uncheckInOrderBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:12];
    [self.uncheckInOrderBtn setTitleColor:LYZTheme_BlackFontColorFontColor forState:UIControlStateNormal];
    [self.uncheckInOrderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.uncheckInOrderBtn.tag = kOrderBtnTag + 2;
    [self.uncheckInOrderBtn setImage:[UIImage imageNamed:@"me_icon_willlive"] forState:UIControlStateNormal];
    [self.uncheckInOrderBtn setTitle:@"待入住" forState:UIControlStateNormal];
    [self.floatBackGroud addSubview:self.uncheckInOrderBtn];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(self.uncheckInOrderBtn.right, (OderEntranceCell.cellHeight - 48)/2.0, 0.5, 48)];
    line3.backgroundColor = kLineColor;
    [self.floatBackGroud addSubview:line3];
    
    //已入住
    self.checkInOrderBtn = [LCVerticalBadgeBtn buttonWithType:UIButtonTypeCustom];
    self.checkInOrderBtn.frame = CGRectMake(line3.right, 0, IconBtnWidth, OderEntranceCell.cellHeight);
    self.checkInOrderBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:12];
    [self.checkInOrderBtn setTitleColor:LYZTheme_BlackFontColorFontColor forState:UIControlStateNormal];
    [self.checkInOrderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.checkInOrderBtn.tag = kOrderBtnTag + 3;
    [self.checkInOrderBtn setImage:[UIImage imageNamed:@"me_icon_finishlive"] forState:UIControlStateNormal];
    [self.checkInOrderBtn setTitle:@"已入住" forState:UIControlStateNormal];
    [self.floatBackGroud addSubview:self.checkInOrderBtn];
    
    [self layoutSubviews];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.floatBackGroud.layer.cornerRadius = 2.5f;
    self.floatBackGroud.layer.shadowColor = [UIColor grayColor].CGColor;
    self.floatBackGroud.layer.shadowOffset = CGSizeMake(3, 3);
    self.floatBackGroud.layer.shadowOpacity = 0.7f;
}


- (void)loadContent {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self.data;
        NSNumber *unpay = dic[@"unpay"];
        NSNumber *uncheckIn = dic[@"uncheckin"];
        if (unpay.integerValue && ![unpay isKindOfClass:[NSNull class]]) {
            self.unpayOrderBtn.badgeString = [NSString stringWithFormat:@"%@",unpay];
        }else{
            self.unpayOrderBtn.badgeString = nil;
        }
        if (uncheckIn.integerValue && ![uncheckIn isKindOfClass:[NSNull class]]) {
            self.uncheckInOrderBtn.badgeString = [NSString stringWithFormat:@"%@",uncheckIn];
        }else{
            self.uncheckInOrderBtn.badgeString = nil;
        }
    }
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _OderEntranceCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OderEntranceCellHeight;
}

#pragma mark - Btn Actions

-(void)orderBtnClicked:(UIButton *)sender{
    LYZMineViewController *vc = (LYZMineViewController *)self.controller;
    if ([vc respondsToSelector:@selector(didSelectedOrderTypeItemAtIndex:)]) {
        [vc didSelectedOrderTypeItemAtIndex:sender.tag - kOrderBtnTag];
    }

}

@end
