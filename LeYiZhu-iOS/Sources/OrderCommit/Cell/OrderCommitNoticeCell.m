//
//  OrderCommitNoticeCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/10.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderCommitNoticeCell.h"

static CGFloat _OrderNoticeCellHeight = 340.0f;

@implementation OrderCommitNoticeCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.backgroundColor = LYZTheme_BackGroundColor;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 15, 100, 18)];
    title.textColor = LYZTheme_warmGreyFontColor;
    title.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    title.text = @"预订须知";
    [self addSubview:title];
    
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, title.bottom + 4 , SCREEN_WIDTH - 2* DefaultLeftSpace, 0)];
    noticeLabel.numberOfLines = 0;
    noticeLabel.backgroundColor = LYZTheme_BackGroundColor;
    noticeLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
    noticeLabel.textColor = LYZTheme_warmGreyFontColor;
    noticeLabel.text  = @"1.本酒店无前台，可通过乐易住微信公众号/小程序/APP在线预订；\n2.订单填写入住人姓名及手机号码时，请务必填写真实有效信息，否则可能导致无法办理入住或获取不到酒店信息；\n3.为了您和他人的身体健康，严禁携带宠物入住酒店；\n4.建议在14:00后办理入住，如提前到店，视酒店空房情况安排；\n5.最晚办理入住时间为次日凌晨6:00前；\n6.入住当日凭本人二代身份证到酒店自助机“刷脸”办理入住；\n7.退房后，房门密码将失效，房间供电也会相应切断，请提前安排好时间。实际退房时间与会员等级相关；\n8.支付后订单不可修改、不可取消；\n9.24小时客服热线：“400-967-0533”" ;
    [noticeLabel sizeToFit];
    [self addSubview:noticeLabel];
    
}

- (void)loadContent {
    
  }

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderNoticeCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderNoticeCellHeight;
}


@end
