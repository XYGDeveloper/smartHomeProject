//
//  LYZHotelEquipmentAndNoticeCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZHotelEquipmentAndNoticeCell.h"


@interface LYZHotelEquipmentAndNoticeCell ()

@property(nonatomic , strong) UILabel *titleLabel;
@property(nonatomic , strong)  UITextView *textView;

@end


@implementation LYZHotelEquipmentAndNoticeCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 20)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(DefaultLeftSpace - 3, self.titleLabel.bottom + 15, SCREEN_WIDTH - 2*DefaultLeftSpace, 0)];
    self.textView.textColor = LYZTheme_warmGreyFontColor;
    self.textView.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    self.textView.scrollEnabled = NO;
    self.textView.editable = NO;
    self.textView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textView];
}


- (void)loadContent {
   
    if ([self.data isKindOfClass:[NSDictionary class]]) {
         NSDictionary *dic = (NSDictionary *)self.data;
        if ([dic objectForKey:@"title"]) {
            self.titleLabel.text = dic[@"title"];
        }
        
        if ([dic objectForKey:@"content"]) {
            self.textView.text = dic[@"content"];
            self.textView.height =  [self.textView sizeThatFits:CGSizeMake(SCREEN_WIDTH - 2*DefaultLeftSpace , FLT_MAX)].height;
        }
    }
    
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+(CGFloat)cellHeightWithData:(id)data{
    NSString *str = nil;
    if ([data isKindOfClass:[NSDictionary class]]) {
           NSDictionary *dic = (NSDictionary *)data;
           if ([dic objectForKey:@"content"]) {
               str = dic[@"content"];
          }
    }

    UITextView *textview = [[UITextView alloc] init];
    textview.textColor = LYZTheme_BlackFontColorFontColor;
    textview.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    textview.text = str;
    CGFloat height = [textview sizeThatFits:CGSizeMake(SCREEN_WIDTH - 2*DefaultLeftSpace , FLT_MAX)].height ;
    return 20 + 20 + 15 +height + 20;
}


@end
