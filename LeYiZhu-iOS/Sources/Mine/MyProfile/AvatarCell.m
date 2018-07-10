//
//  AvatarCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AvatarCell.h"
#import "UIView+SetRect.h"
#import "UIImageView+WebCache.h"

@interface AvatarCell()

@property (nonatomic, strong) UIImageView *avatarImgView;

@end

static CGFloat _avatarCellHeight = 80.0f;

@implementation AvatarCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 50, AvatarCell.cellHeight)];
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    titleLabel.textColor = LYZTheme_warmGreyFontColor;
    titleLabel.text = @"头像";
    [self addSubview:titleLabel];
    
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 10, (AvatarCell.cellHeight  - 10) /2.0, 10, 10)];
    img.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:img];
    
    self.avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.avatarImgView.right = img.x -20;
    self.avatarImgView.centerY = AvatarCell.cellHeight/2.0;
    self.avatarImgView.layer.cornerRadius = 30.0f;
    self.avatarImgView.clipsToBounds = YES;
    [self addSubview:self.avatarImgView];
    
    
    
}


- (void)loadContent {
    
    [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:self.data]];
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _avatarCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _avatarCellHeight;
}


-(void)dealloc{
    LYLog(@"dealloc");
}

@end
