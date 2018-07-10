//
//  LYZHotelIntroductionCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZHotelIntroductionCell.h"
#import "NSString+Size.h"
#import "UIView+SetRect.h"
#import "Math.h"
#import "HotelIntroModel.h"


@interface LYZHotelIntroductionCell  ()

@property(nonatomic , strong) UILabel *titleLabel;
@property(nonatomic , strong)  UITextView *textView;


@end

@implementation LYZHotelIntroductionCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 20)];
    self.titleLabel.text = @"酒店介绍";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(DefaultLeftSpace , self.titleLabel.bottom + 10, SCREEN_WIDTH - 2*DefaultLeftSpace, 0)];
    self.textView.textColor = LYZTheme_warmGreyFontColor;
    self.textView.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    self.textView.scrollEnabled = NO;
    self.textView.editable = NO;
    [self addSubview:self.textView];
    
}



- (void)loadContent {
    HotelIntroModel *hotelIntro = (HotelIntroModel *)self.data;
    self.textView.text = hotelIntro.intro;
    self.textView.height =  [self.textView sizeThatFits:CGSizeMake(SCREEN_WIDTH - 2*DefaultLeftSpace , FLT_MAX)].height ;
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+(CGFloat)cellHeightWithData:(id)data{
    NSString *str = data;
    UITextView *textview = [[UITextView alloc] init];
    textview.textColor = LYZTheme_BlackFontColorFontColor;
    textview.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    textview.text = str;
    CGFloat height = [textview sizeThatFits:CGSizeMake(SCREEN_WIDTH - 2*DefaultLeftSpace , FLT_MAX)].height ;
    return 20 + 20 + 10 + height + 10;
}

#pragma mark - Btn Actions

@end
