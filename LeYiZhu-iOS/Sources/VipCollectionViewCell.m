//
//  VipCollectionViewCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "VipCollectionViewCell.h"
#import "LocalVipModel.h"
#import "UIView+SetRect.h"

@interface VipCollectionViewCell ()

@property (nonatomic, strong) UIImageView *backgroundImgView;
@property (nonatomic, strong) UILabel *currentVipLevelLabel;
@property (nonatomic, strong) UIProgressView *vipProgress;
@property (nonatomic, strong) UILabel *growingValueLabel;

@end

@implementation VipCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.layer.shadowColor = RGB(201, 201, 201).CGColor;
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowOpacity = .7f;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backgroundImgView.layer.cornerRadius = 5.0f;
        self.backgroundImgView.clipsToBounds = YES;
        [self addSubview:self.backgroundImgView];
    }
    return self;
}

-(void)setVipModel:(LocalVipModel *)vipModel{
    _vipModel = vipModel;
    self.backgroundImgView.image = [UIImage imageNamed:vipModel.imageName];
    
    if (!vipModel.growingValue) {
       
        if (vipModel.vipType == eCardType) {
            self.growingValueLabel.textColor = LYZTheme_warmGreyFontColor;
            self.growingValueLabel.text =@"注册会员或入住酒店即可获取";
        }else {
            self.growingValueLabel.textColor = [UIColor whiteColor];
            self.growingValueLabel.text = [NSString stringWithFormat:@"需要成长值: %@", vipModel.targetGrowingValue];
        }
         [self.growingValueLabel sizeToFit];
       
    }else{
        UIColor *currentVipColor;
        if (vipModel.vipType == eCardType) {
            currentVipColor = LYZTheme_warmGreyFontColor;
        }else {
            currentVipColor = [UIColor whiteColor];
        }
        if (vipModel.currentVip == vipModel.vipType) {
            if (_vipProgress && _vipProgress.superview) {
                [_vipProgress removeFromSuperview];
            }
            self.currentVipLevelLabel.textColor = currentVipColor;
            [self addSubview:self.currentVipLevelLabel];
            self.growingValueLabel.text = [NSString stringWithFormat:@"成长值: %@",vipModel.growingValue];
            [self.growingValueLabel sizeToFit];
        }else{
            if (_currentVipLevelLabel && _currentVipLevelLabel.superview) {
                [_currentVipLevelLabel removeFromSuperview];
            }
            self.vipProgress.progress = vipModel.growingValue.integerValue / vipModel.targetGrowingValue.floatValue;
            self.growingValueLabel.text = [NSString stringWithFormat:@"成长值：%@/%@",vipModel.growingValue,vipModel.targetGrowingValue];
            [self.growingValueLabel sizeToFit];
            if (vipModel.vipType == goldType) {
                self.vipProgress.trackTintColor = [UIColor colorWithHexString:@"#B79263"];
            }else{
                self.vipProgress.trackTintColor = RGB(194, 199, 208);
            }
        }
        self.growingValueLabel.textColor = currentVipColor;
    }
}

-(UILabel *)currentVipLevelLabel{
    if (!_currentVipLevelLabel) {
        _currentVipLevelLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _currentVipLevelLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
        _currentVipLevelLabel.text = @"当前等级";
        [_currentVipLevelLabel sizeToFit];
        _currentVipLevelLabel.y = 34;
        _currentVipLevelLabel.right = self.width - 15;
    }
    return _currentVipLevelLabel;
}

-(UILabel *)growingValueLabel{
    if (!_growingValueLabel) {
        _growingValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _growingValueLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
        _growingValueLabel.x = 23;
        _growingValueLabel.bottom =self.height - 50;
        [self addSubview:_growingValueLabel];
    }
    return _growingValueLabel;
}


-(UIProgressView *)vipProgress{
    if (!_vipProgress) {
        _vipProgress = [[UIProgressView alloc]  initWithFrame:CGRectMake(0, 0, 178, 14)];
        _vipProgress.x = 23.f;
        _vipProgress.bottom =self.height - 60.0f;
        _vipProgress.layer.cornerRadius = 7.f;
        _vipProgress.trackTintColor = RGB(194, 199, 208);
        _vipProgress.progressTintColor = [UIColor whiteColor];
        [self addSubview:_vipProgress];
    }
    return _vipProgress;
}



@end
