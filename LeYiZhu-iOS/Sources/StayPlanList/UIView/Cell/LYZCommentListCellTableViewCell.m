//
//  LYZCommentListCellTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by L on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "LYZCommentListCellTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "CWStarRateView.h"
#import "FriendCircleImageView.h"
#import "LTUITools.h"
@interface LYZCommentListCellTableViewCell()

@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *nikeLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *roomTypeLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong) UIButton * allContentButton;

@property (nonatomic, strong)CWStarRateView *starRateView;
@property (nonatomic, strong)UIView *baseView;
@property (nonatomic,strong) FriendCircleImageView * friendCircleImageView;   //图片

@property (nonatomic,copy) dispatch_block_t btClickBlock;

//@property (nonatomic,strong) UILabel * timeLabel1;    //发布时间
//
//@property (nonatomic,strong) UIImageView * scanImg;
//
//@property (nonatomic,strong) UILabel * scanCount;
//
//@property (nonatomic,strong) UIImageView * commentImg;
//
//@property (nonatomic,strong) UILabel * commentCount;

@property (nonatomic,strong) UIImageView * scanImg1;

@property (nonatomic,strong) UILabel * scanCount1;

@property (nonatomic,strong) UILabel * timeLabel1;    //发布时间

@end

@implementation LYZCommentListCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        [self setUI];
        [self setConstant];
   
    }
    return self;
}

- (void)setUI{
    
    self.headImage = [[UIImageView alloc]init];
    self.headImage.layer.cornerRadius = 20;
    self.headImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImage];
    
    self.nikeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.nikeLabel];
    self.nikeLabel.textColor = [UIColor colorWithRed:119/255.0 green:134/255.0 blue:184/255.0 alpha:1.0f];
    self.nikeLabel.textAlignment = NSTextAlignmentLeft;
    self.nikeLabel.font = [UIFont systemFontOfSize:15.0f];
    
    self.baseView = [[UIView alloc]init];
    [self.contentView addSubview:self.baseView];
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0,0, 90, 15) numberOfStars:5];
    self.starRateView.scorePercent = 0.0;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = YES;
    self.starRateView.needGesture = NO;
    [self.baseView addSubview:self.starRateView];
    self.timeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.textColor = [UIColor colorWithRed:161/255.0 green:162/255.0 blue:163/255.0 alpha:1.0f];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.font = [UIFont systemFontOfSize:15.0f];
    
    self.roomTypeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.roomTypeLabel];
    self.roomTypeLabel.textColor = [UIColor colorWithRed:161/255.0 green:162/255.0 blue:163/255.0 alpha:1.0f];
    self.roomTypeLabel.textAlignment = NSTextAlignmentLeft;
    self.roomTypeLabel.font = [UIFont systemFontOfSize:15.0f];
    
    self.contentLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.font = [UIFont systemFontOfSize:16.0f];
    self.contentLabel.numberOfLines = 0;
    
    self.allContentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.allContentButton.backgroundColor = [UIColor redColor];
    [self.allContentButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.allContentButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.allContentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:self.allContentButton];
    
    
    
    self.friendCircleImageView = [FriendCircleImageView new];
    [self.contentView addSubview:self.friendCircleImageView];

    self.scanImg1 = [LTUITools lt_creatImageView];
    
    self.scanImg1.backgroundColor = [UIColor redColor];
    self.scanImg1.image = [UIImage imageNamed:@"thumb_up_button"];
    
    [self.contentView addSubview:self.scanImg1];
    
    self.scanCount1 = [LTUITools lt_creatLabel];
    
    self.scanCount1.textAlignment = NSTextAlignmentLeft;
    
    self.scanCount1.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:self.scanCount1];
    
    self.timeLabel = [LTUITools lt_creatLabel];
    
    self.timeLabel.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:self.timeLabel];
    
}

- (void)setConstant{
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.nikeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).mas_equalTo(10);
        make.top.mas_equalTo(self.headImage.mas_top);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(20);
    }];
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nikeLabel.mas_right);
        make.centerY.mas_equalTo(self.nikeLabel.mas_centerY);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).mas_equalTo(10);
        make.bottom.mas_equalTo(self.headImage.mas_bottom);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    
    [self.roomTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel.mas_right).mas_equalTo(0);
        make.bottom.mas_equalTo(self.headImage.mas_bottom);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).mas_equalTo(10);
        make.top.mas_equalTo(self.headImage.mas_bottom).mas_equalTo(13);
        make.width.mas_lessThanOrEqualTo([self contentLabelMaxWidth]);
    }];
    
    [self.allContentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentLabel.mas_left);
        make.height.mas_equalTo(16);
    }];
    [self.friendCircleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allContentButton.mas_bottom).offset(10);
        make.right.left.equalTo(self.contentLabel.mas_left);
    }];
    
    [self.timeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(self.contentLabel.mas_left);
        make.height.mas_equalTo(25);
        make.bottom.mas_equalTo(-20);
    }];
    
}


- (void)refreshWithModel:(HotelCommentsModel *)model{
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.facePath]];
    self.nikeLabel.text = model.nikeName;
    self.roomTypeLabel.text = model.roomType;
    self.timeLabel.text = model.commentTime;
//    self.contentLabel.text = model.content;
    self.starRateView.scorePercent = model.satisfaction.floatValue/5.0;
    NSLog(@"%@",model.images);
    NSMutableArray *arr = [NSMutableArray array];
//    for (NSDictionary *imageDic in model.images) {
//        [arr addObject:[imageDic objectForKey:@"path"]];
//    }
//    [self layoutUI:model.content imgArr:arr];
//    NSLog(@"%@",arr);
    
    NSArray *arr1 =@[@"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg",@"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg",@"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg",@"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg",@"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg",@"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg",@"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg",@"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg"];
    [self.friendCircleImageView cellDataWithImageArray:arr1];

    [self layoutUI:model.content imgArr:arr1];

}

- (void)layoutUI:(NSString *)content imgArr:(NSArray *)imagesArray
{
    //计算正文高度
    CGFloat contentHeight = [self contentHeight:content];
    //friendCircleImageView 图片参照view
    UIView * targetViewOfFriendCircleImageView;
    //如果大于60  显示全部查看按钮
    if (contentHeight >60) {
        [self.allContentButton setTitle:@"" forState:UIControlStateNormal];
        [self.allContentButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
        }];
        //限制正文label高度小于60
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_lessThanOrEqualTo(60);
        }];
        targetViewOfFriendCircleImageView = self.allContentButton;
        
    } else{
        [self.allContentButton setTitle:@"" forState:UIControlStateNormal];
        //这里得重置contentLabel的约束
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nikeLabel.mas_bottom).offset(10);
            make.left.equalTo(self.nikeLabel.mas_left);
            make.width.mas_lessThanOrEqualTo([self contentLabelMaxWidth]);
        }];
        
        [self.allContentButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        targetViewOfFriendCircleImageView = self.contentLabel;
        
    }
    //设置friendCircleImageView 参数
    [self.friendCircleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(targetViewOfFriendCircleImageView.mas_bottom).offset(10);
        make.right.equalTo(self.contentLabel);
        make.left.mas_equalTo(self.contentLabel.mas_left);
    }];
    
    //如果 "查看全部" 按钮被点击 则重置label约束
    //    if (self.model.isSelect == YES) {
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nikeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.nikeLabel.mas_left);
        make.width.mas_lessThanOrEqualTo([self contentLabelMaxWidth]);
    }];
    //        [self.allContentButton setTitle:@"收起" forState:UIControlStateNormal];
    //    }
    //timeLabel 参照View
    UIView * targetViewOfTimeLabel;
    //如果没有图片并且正文高度大于60
    if (imagesArray.count == 0 && contentHeight > 60) {
        targetViewOfTimeLabel = self.allContentButton;
        //如果没有图片并且正文内容小于等于60
    } else if (imagesArray.count == 0 && contentHeight <= 60) {
        targetViewOfTimeLabel = self.contentLabel;
        //如果有图片
    } else {
        targetViewOfTimeLabel = self.friendCircleImageView;
    }
    
    [self.timeLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel.mas_left);
        make.width.mas_equalTo(160);
        make.top.equalTo(targetViewOfTimeLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(25);
        make.bottom.mas_equalTo(-20);

    }];
    
}

- (void)cellClickBt:(dispatch_block_t)clickBtBlock
{
    self.btClickBlock = clickBtBlock;
}

- (CGFloat)contentHeight:(NSString *)content
{
    CGRect textRect = [content boundingRectWithSize:CGSizeMake([self contentLabelMaxWidth], MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil];
    return textRect.size.height;
}

- (CGFloat)contentLabelMaxWidth
{
    return kScreenWidth - 40;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
