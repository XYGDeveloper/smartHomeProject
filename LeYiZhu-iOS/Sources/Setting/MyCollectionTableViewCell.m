//
//  MyCollectionTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/13.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "MyCollectionTableViewCell.h"
#import "UIImageView+WebCache.h"

#define IMG_WIDTH  330
#define IMG_HEIGHT 200
#define LeftSideSpace ((SCREEN_WIDTH - IMG_WIDTH)/2.0)
#define TopSpace  30
#define DeleBtnWidth 40

@interface MyCollectionTableViewCell()

@property (nonatomic ,strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic ,strong) UIButton *collectBtn;

@end

@implementation MyCollectionTableViewCell


-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView =[ [UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imgView];
      
    }
    return _imgView;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLable.font = [UIFont systemFontOfSize:16];
        _titleLable.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLable];
    }
    return _titleLable;
}

-(UIButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectBtn.frame = CGRectMake(SCREEN_WIDTH  - 47, 8, 47, 47);
     
        [_collectBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_collectBtn];
    }
    return _collectBtn;
}


-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
        _addressLabel.textColor = LYZTheme_warmGreyFontColor;
        [_addressLabel sizeToFit];
        [self.contentView addSubview:_addressLabel];
    }
    return _addressLabel;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, IMG_HEIGHT);
    self.titleLable.frame = CGRectMake(DefaultLeftSpace, self.imgView.bottom + 13, IMG_WIDTH, 15);
    self.addressLabel.frame = CGRectMake(LeftSideSpace, self.titleLable.bottom + 10, IMG_WIDTH, 12);
    
}

-(void)setFavoriteModel:(MyFavoriteModel *)favoriteModel{
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:favoriteModel.imgPath]];
    self.titleLable.text = favoriteModel.hotelName;
    self.addressLabel.text = favoriteModel.address;
    [self.collectBtn setImage:[UIImage imageNamed:@"icon_keep_c"] forState:UIControlStateNormal];
    [self layoutSubviews];
}



-(void)deleteBtnClick:(id)sender{
    if (self.delBtnClick) {
        self.delBtnClick(self.cellIndex);
    }
}


@end
