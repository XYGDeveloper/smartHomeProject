//
//  LYZHotelPolicyCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZHotelPolicyCell.h"
#import "NSString+Size.h"

@implementation LYZHotelPolicyCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 15, 100, 20)];
    titleLabel.text = @"酒店政策";
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(DefaultLeftSpace - 3, titleLabel.bottom + 5, SCREEN_WIDTH - 2*DefaultLeftSpace, 0)];
    textView.textColor = LYZTheme_warmGreyFontColor;
    textView.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    textView.scrollEnabled = NO;
    textView.editable = NO;
    textView.text = @"乐易住新会员最高可领201元现金券，住店99元起；\n根据会员等级不同，退房时间不同：\nE卡会员退房时间为12:00；银卡、金卡、钻石会员退房时间为13:00";
    [textView sizeToFit];
    [self addSubview:textView];
}


- (void)loadContent {
    
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+(CGFloat)cellHeightWithData:(id)data{
    NSString *str = @"乐易住新会员最高可领201元现金券，住店95元起；\n根据会员等级不同，退房时间不同：\nE卡会员退房时间为12:00；银卡、金卡、钻石会员退房时间为13:00";
     CGFloat totalStringHeight = [str heightWithFont:[UIFont fontWithName:LYZTheme_Font_Regular size:13] constrainedToWidth:(SCREEN_WIDTH -  2* DefaultLeftSpace )];
    return totalStringHeight + 15 + 20 + 10 + 15;
}

#pragma mark - Btn Actions

@end
