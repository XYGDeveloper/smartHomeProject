//
//  LYZCommentDetailTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/23.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "LYZCommentDetailTableViewCell.h"
#import "FriendCircleImageView.h"
#import "LYZcommentDetailModel.h"
#import "LTUITools.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "CWStarRateView.h"

@interface LYZCommentDetailTableViewCell()


@property (nonatomic,strong) UIImageView * nameIcon;    //头像

@property (nonatomic,strong) UILabel * nameLabel;    //昵称

@property (nonatomic, strong)CWStarRateView *starRateView; //xing

@property (nonatomic, strong)UIView *baseView;

@property (nonatomic,strong) UILabel * creatLabel;

@property (nonatomic,strong) UILabel * roomtype;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UILabel * replayContent;  //问题内容


@property (nonatomic,strong) UIImageView * scanImg;

@property (nonatomic,strong) UILabel * scanCount;

@property (nonatomic,strong) UIImageView * commentImg;

@property (nonatomic,strong) UILabel * commentCount;

@property (nonatomic,strong) UIImageView * headImage;

@property (nonatomic,strong) FriendCircleImageView * friendCircleImageView;   //图片

@property (nonatomic,strong) HotelCommentsModel * model;

@property (nonatomic,strong) UIView * bgview;

@end

@implementation LYZCommentDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //头像
        self.nameIcon = [LTUITools lt_creatImageView];
        self.nameIcon.layer.cornerRadius = 20;
        self.nameIcon.layer.masksToBounds = YES;
        [self.contentView addSubview:self.nameIcon];
        //昵称
        self.nameLabel = [LTUITools lt_creatLabel];
        self.nameLabel.textColor = [UIColor colorWithRed:119/255.0 green:134/255.0 blue:184/255.0 alpha:1.0f];
        [self.nameLabel sizeToFit];

        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:self.nameLabel];
        //星级
        self.baseView = [[UIView alloc]init];
        [self.contentView addSubview:self.baseView];
        
        self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0,0, 90, 15) numberOfStars:5];
        self.starRateView.scorePercent = 0.0;
        self.starRateView.allowIncompleteStar = NO;
        self.starRateView.hasAnimation = YES;
        self.starRateView.needGesture = NO;
        [self.baseView addSubview:self.starRateView];
        //时间
        self.creatLabel = [LTUITools lt_creatLabel];
        self.creatLabel.textColor = LYZTheme_PinkishGeryColor;
        [self.creatLabel sizeToFit];
        self.creatLabel.textAlignment = NSTextAlignmentLeft;
        self.creatLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:self.creatLabel];
        //房型
        self.roomtype = [LTUITools lt_creatLabel];
        self.roomtype.textColor = LYZTheme_PinkishGeryColor;
        [self.roomtype sizeToFit];
        self.roomtype.textAlignment = NSTextAlignmentLeft;
        self.roomtype.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:self.roomtype];
        //内容
        self.contentLabel = [LTUITools lt_creatLabel];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        self.contentLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.contentLabel];
        //图片容器
        self.friendCircleImageView = [FriendCircleImageView new];
        self.friendCircleImageView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.friendCircleImageView];
        //浏览数
     
        self.scanCount = [LTUITools lt_creatLabel];
        self.scanCount.font = [UIFont systemFontOfSize:14];
        self.scanCount.textAlignment = NSTextAlignmentLeft;
        self.scanCount.textColor = LYZTheme_PinkishGeryColor;
        [self.contentView addSubview:self.scanCount];
        //点赞数
        self.commentImg = [LTUITools lt_creatImageView];
        self.commentImg.image = [UIImage imageNamed:@"comment_skcan"];
        [self.contentView addSubview:self.commentImg];
        self.commentCount = [LTUITools lt_creatLabel];
        self.commentCount.font = [UIFont systemFontOfSize:14];
        self.commentCount.textAlignment = NSTextAlignmentLeft;
        self.commentCount.textColor = LYZTheme_PinkishGeryColor;
        [self.contentView addSubview:self.commentCount];
        
        [self setConstant];
    }
    return self;
}

#pragma mark - 设置约束
- (void)setConstant
{
    [self.nameIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameIcon.mas_right).mas_equalTo(10);
        make.top.equalTo(self.nameIcon.mas_top);
        make.height.mas_equalTo(20);
    }];
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.left.mas_equalTo(self.nameLabel.mas_right).mas_equalTo(10);
    }];
    
    [self.creatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.bottom.mas_equalTo(self.nameIcon.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    [self.roomtype mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.creatLabel.mas_left);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.friendCircleImageView.mas_bottom).mas_equalTo(10);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.creatLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(-20);
    }];
    
#pragma mark - friendCircleImageView每部已经自动自动计算高度
    [self.friendCircleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(5);
        make.right.left.equalTo(self.contentLabel);
    }];
    
    [self.scanCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.commentImg.mas_centerY);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(15);
    }];
    
    [self.commentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.creatLabel.mas_right).mas_equalTo(60);
        make.centerY.mas_equalTo(self.creatLabel.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(12);
    }];
    [self.commentCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentImg.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(self.scanCount.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
}

- (void)cellDataWithModel:(LYZcommentDetailModel *)model
{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (LYZCommentImage *images in model.images) {
        [arr addObject:images.path];
    }
    
    [self.nameIcon sd_setImageWithURL:[NSURL URLWithString:model.facePath]];
    self.scanCount.text  = [model.likeCount stringValue];
    self.commentCount.text =  [model.viewingCount stringValue];
    
    if ([model.commentType intValue] == 1) {
        self.nameLabel.text = @"游客";
    }else{
        self.nameLabel.text = model.nikeName;
    }
    self.starRateView.scorePercent = model.satisfaction.floatValue/5.0;
    self.contentLabel.text = model.content;
    NSArray *arr0 = [model.commentTime componentsSeparatedByString:@" "];
    self.creatLabel.text = [arr0 firstObject];
    self.roomtype.text  =[NSString stringWithFormat:@"房型:%@",model.roomType];
    self.commentCount.text = [model.viewingCount stringValue];
    self.scanCount.text = [NSString stringWithFormat:@"%@人觉得很棒",[model.likeCount stringValue]];
    [self.friendCircleImageView cellDataWithImageArray:arr];
    CGFloat contentHeight = [self contentHeight:model.content];
//    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(contentHeight);
//    }];
}


- (CGFloat)getWidthWithTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    [label sizeToFit];
    return label.frame.size.width;
}

- (CGFloat)contentHeight:(NSString *)content
{
    CGRect textRect = [content boundingRectWithSize:CGSizeMake([self contentLabelMaxWidth], MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil];
    return textRect.size.height;
}

- (CGFloat)contentLabelMaxWidth
{
    return kScreenWidth - 80;
}

@end
