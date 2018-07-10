//
//  LYZCommentCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZHotelCommentCell.h"
#import "CWStarRateView.h"
#import "LYZHotelDetailModel.h"

@interface LYZHotelCommentCell ()

@property (nonatomic, strong) CWStarRateView *starRateView;

@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, strong) UILabel *commentCountLabel;

@end

static CGFloat _HotelCommentCellHeight = 45.0f;

@implementation LYZHotelCommentCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(DefaultLeftSpace ,0 , 80, LYZHotelCommentCell.cellHeight) numberOfStars:5];
    self.starRateView.scorePercent = 1.0;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    self.starRateView.needGesture = NO;
    [self addSubview:self.starRateView];
    
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.starRateView.right + 10, 0, 50, LYZHotelCommentCell.cellHeight)];
    self.scoreLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.scoreLabel.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.scoreLabel];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 15 ,(LYZHotelCommentCell.cellHeight - 15)/2.0  , 15, 15)];
    arrowImg.image = [UIImage imageNamed:@"hotle_icon_show"];
    [self addSubview:arrowImg];
    
    self.commentCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - arrowImg.width - 10 - 150, (LYZHotelCommentCell.cellHeight - 20)/2.0, 150, 20)];
    self.commentCountLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.commentCountLabel.textColor = LYZTheme_paleBrown;
    self.commentCountLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.commentCountLabel];
}


- (void)loadContent {
    LYZHotelDetailModel *model = (LYZHotelDetailModel *)self.data;
    self.starRateView.scorePercent = model.avgSatisfaction.floatValue/5.0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f分",model.avgSatisfaction.floatValue];
    self.commentCountLabel.text = [NSString stringWithFormat:@"%@条评论",model.commentCount];
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _HotelCommentCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _HotelCommentCellHeight;
}

#pragma mark - Btn Actions

@end
