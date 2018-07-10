//
//  MyProfileCommonCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "MyProfileCommonCell.h"
#import "UIView+SetRect.h"

@interface MyProfileCommonCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

static CGFloat _profileCommonCellHeight = 45.0f;

@implementation MyProfileCommonCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.titleLabel.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.titleLabel];
    
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 10, (MyProfileCommonCell.cellHeight  - 10) /2.0, 10, 10)];
    img.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:img];
    
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, MyProfileCommonCell.cellHeight)];
    self.subTitleLabel.right = img.x - 20;
    self.subTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.subTitleLabel.textColor = [UIColor blackColor];
    self.subTitleLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.subTitleLabel];

}


- (void)loadContent {
    NSDictionary *dic = (NSDictionary *)self.data;
    self.titleLabel.text = dic[@"title"];
    [self.titleLabel sizeToFit];
    self.titleLabel.x = DefaultLeftSpace;
    self.titleLabel.centerY = MyProfileCommonCell.cellHeight/2.0;
    self.subTitleLabel.text = dic[@"subtitle"];
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _profileCommonCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _profileCommonCellHeight;
}


-(void)dealloc{
    LYLog(@"dealloc");
}


@end
