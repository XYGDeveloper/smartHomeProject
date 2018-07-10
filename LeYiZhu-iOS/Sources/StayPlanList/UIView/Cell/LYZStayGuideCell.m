//
//  LYZStayNoticeCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayGuideCell.h"
#import "UIView+SetRect.h"

@interface LYZStayGuideCell ()

@end

//static CGFloat _stayPlanGuideCellHeight = 105.0;

@implementation LYZStayGuideCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 25, LYZStayGuideCell.cellHeight);
}

- (void)buildSubview {
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 15, self.width - 2*DefaultLeftSpace - 30, 18)];
    title.textColor = [UIColor blackColor];
    CGFloat titleFont = iPhone5_5s ? 13 : 15;
    title.font = [UIFont fontWithName:LYZTheme_Font_Regular size:titleFont];
    title.text = @"入住指南";
    [self addSubview:title];
    
    UITextView *notice = [[UITextView alloc] initWithFrame:CGRectMake(DefaultLeftSpace -5,title.bottom + 2, self.width - 2*DefaultLeftSpace,0)];
  
    notice.backgroundColor = [UIColor clearColor];
//    notice.textColor = LYZTheme_warmGreyFontColor;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName: [UIFont fontWithName:LYZTheme_Font_Regular size:12.0f],
//                                 NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:LYZTheme_warmGreyFontColor
//                                 };
    CGFloat noticeFont = iPhone5_5s ? 10 : 12;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:LYZTheme_Font_Regular size:noticeFont],NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,[UIColor colorWithHexString:@"#999999"], NSForegroundColorAttributeName,nil];
    notice.attributedText = [[NSAttributedString alloc] initWithString:@"1.前往酒店使用自助机验证身份证并进行人脸识别。\n2.认证成功后，会获得含有房号和开门密码的短信。" attributes:attributes];
     CGSize sizeToFit = [notice sizeThatFits:CGSizeMake(SCREEN_WIDTH  - 25 - 2*DefaultLeftSpace, MAXFLOAT)];
    notice.height = sizeToFit.height;
    notice.scrollEnabled = NO;
    notice.editable = NO;
    [self addSubview:notice];
    
//    UIButton *guidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    guidBtn.frame = CGRectMake(self.width - DefaultLeftSpace  - 18, notice.y, 18, 18);
//    [guidBtn setImage:[UIImage imageNamed:@"will_live_icon_loction"] forState:UIControlStateNormal];
//    [guidBtn addTarget:self action:@selector(guidBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:guidBtn];
}

- (void)loadContent {
    
}

- (void)selectedEvent {
    
    
}

#pragma mark - class property.

//+ (void)setCellHeight:(CGFloat)cellHeight {
//
//    _stayPlanGuideCellHeight = cellHeight;
//}

+ (CGFloat)cellHeight {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    
     CGFloat noticeFont = iPhone5_5s ? 10 : 12;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:LYZTheme_Font_Regular size:noticeFont],NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,[UIColor colorWithHexString:@"#999999"], NSForegroundColorAttributeName,nil];
    NSAttributedString * attributedText = [[NSAttributedString alloc] initWithString:@"1.前往酒店使用自助机验证身份证并进行人脸识别。\n2.认证成功后，会获得含有房号和开门密码的短信。" attributes:attributes];
    UITextView *textview = [[UITextView alloc] init];
    textview.attributedText = attributedText;
    CGSize sizeToFit = [textview sizeThatFits:CGSizeMake(SCREEN_WIDTH  - 25 - 2*DefaultLeftSpace, MAXFLOAT)];
    return sizeToFit.height + 30 + 20;
}

-(void)guidBtnClick:(id)sender{
    if (self.userGuid) {
        self.userGuid();
    }
}


@end
