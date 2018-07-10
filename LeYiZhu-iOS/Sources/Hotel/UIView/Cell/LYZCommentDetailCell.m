//
//  LYZCommentDetailCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZCommentDetailCell.h"
#import "CWStarRateView.h"
#import "UIImageView+WebCache.h"
#import "HotelCommentsModel.h"
#import "NSString+Size.h"
#import "UILabel+SizeToFit.h"

#define kMinContentHeight 40

#define kProtraitImgWidth 40

#define kDefaultRateStarWidth 90

#define kDefaultRateStarHeight 15

#define kProtrait_Content_Space 15

#define kSizeOfContentSizeFont 16

#define kMoreCommentBtnHeight 20

#define kRemainFootHeight 40

@interface LYZCommentDetailCell ()

@property (nonatomic, strong) UIImageView *protraitImgView;

@property (nonatomic, strong) UILabel * userNameLabel;

@property (nonatomic, strong) UILabel * commnetDateLabel;

@property (nonatomic, strong)CWStarRateView *starRateView;

@property (nonatomic, strong) UILabel * commentLabel;

@end


@implementation LYZCommentDetailCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    _protraitImgView = [[UIImageView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 15, kProtraitImgWidth, kProtraitImgWidth)];
    _protraitImgView.layer.cornerRadius = kProtraitImgWidth/2.0;
    _protraitImgView.clipsToBounds = YES;
    [self addSubview:_protraitImgView];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_protraitImgView.right + 15, _protraitImgView.y , 200, 20)];
    _userNameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    _userNameLabel.textColor = [UIColor blackColor];
    [self addSubview:_userNameLabel];
    
    _commnetDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100 - DefaultLeftSpace, _userNameLabel.y, 100, 20)];
    _commnetDateLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:12];
    _commnetDateLabel.textAlignment = NSTextAlignmentRight;
    _commnetDateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self addSubview:_commnetDateLabel];
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(_userNameLabel.x, _protraitImgView.bottom - kDefaultRateStarHeight , kDefaultRateStarWidth, kDefaultRateStarHeight) numberOfStars:5];
    self.starRateView.scorePercent = 0.0;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = YES;
    self.starRateView.needGesture = NO;
    [self addSubview:self.starRateView];
    
    self.commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(DefaultLeftSpace, self.protraitImgView.bottom + 15, SCREEN_WIDTH - 2*DefaultLeftSpace, 0)
    self.commentLabel.textColor = [UIColor blackColor];
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    [self addSubview:self.commentLabel];
}


- (void)loadContent {
    HotelCommentsModel *model = self.data;
    [_protraitImgView sd_setImageWithURL:[NSURL URLWithString:model.facePath]];
    _userNameLabel.text = model.nikeName;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *formatter_1 = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:model.commentTime];
    _commnetDateLabel.text = [formatter_1 stringFromDate:date];
    _starRateView.scorePercent = model.satisfaction.floatValue/5.0;
    _commentLabel.text = model.content;
//    [_commentLabel sizeToFit];
    [self layoutSubviews];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.commentLabel.x = DefaultLeftSpace;
    self.commentLabel.y = self.protraitImgView.bottom + 15;
    self.commentLabel.width = SCREEN_WIDTH - 2*DefaultLeftSpace;
    [_commentLabel sizeToFit];
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+(CGFloat)cellHeightWithData:(id)data{
     HotelCommentsModel *model = data;
    NSString *str = model.content;
    CGFloat totalStringHeight = [str heightWithFont:[UIFont fontWithName:LYZTheme_Font_Light size:14] constrainedToWidth:(SCREEN_WIDTH -  2* DefaultLeftSpace )];
    return 15 + kProtraitImgWidth + 15 + totalStringHeight + 15;
}

#pragma mark - Btn Actions

@end
