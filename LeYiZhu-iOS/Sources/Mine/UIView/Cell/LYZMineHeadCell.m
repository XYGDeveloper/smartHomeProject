//
//  LYZMineHeadCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/17.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZMineHeadCell.h"
#import "UIButton+WebCache.h"
#import "UIButton+LYZLoginButton.h"
#import "User.h"
#import "LYZMineViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+SetRect.h"
#import "GradientImgaeGenerator.h"
#import "Math.h"
#import "UIView+AnimationProperty.h"
#import "BaseMineInfoModel.h"
#import "LoginManager.h"
#import "VipInfoModel.h"
#import "GradientImgaeGenerator.h"

#define HeadImgWidth 48.0f

#define kSignBtnXScale 0.236
#define kSignBtnYScale 0.06

@interface LYZMineHeadCell ()

@property (nonatomic, strong) UIView      *backgroundContentView;
@property (nonatomic, strong) UIView      *scaleContentView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic ,strong) UIButton *iconImageBtn;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong)  UIButton *vipTagBtn;
@property (nonatomic, strong) UIButton *vipDescriptionBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *signBtn;

@end

static CGFloat _HeaderIconCellHeight = 140.0f;

@implementation LYZMineHeadCell{
      Math *_scale;
}

- (void)setupCell {
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
     _scale               = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, 1.f) PointB:MATHPointMake(-120, 2.f)];
}

- (void)buildSubview {
    
    self.backgroundContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, LYZMineHeadCell.cellHeight)];
    [self addSubview:self.backgroundContentView];
    
    // Used for scale.
    self.scaleContentView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, LYZMineHeadCell.cellHeight)];
    self.scaleContentView.layer.anchorPoint   = CGPointMake(0.5f, 1.f);
    self.scaleContentView.top                 = 0.f;
    self.scaleContentView.layer.masksToBounds = YES;
    [self.backgroundContentView addSubview:self.scaleContentView];
    
    // Normal imageView.
    self.backgroundImageView             = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, LYZMineHeadCell.cellHeight)];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.image       = [UIImage imageNamed:@"mine_nav_bar"];
    [self.scaleContentView addSubview:self.backgroundImageView];


    // Icon imageView.
//    self.iconImageBtn                     = [[UIImageView alloc] init];
     self.iconImageBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImageBtn .frame = CGRectMake(27.5, 0, HeadImgWidth, HeadImgWidth);
    self.iconImageBtn.bottom = LYZMineHeadCell.cellHeight - 18;
     self.iconImageBtn.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageBtn.layer.cornerRadius  = HeadImgWidth / 2.f;
    self.iconImageBtn.clipsToBounds = YES;
    self.iconImageBtn.layer.shadowColor   = LYZTheme_paleBrown.CGColor;
    self.iconImageBtn.layer.shadowOffset = CGSizeMake(0, 0);
    self.iconImageBtn.needLogin = YES;
      [self.iconImageBtn addTarget:self action:@selector(headClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.iconImageBtn];
    //添加背景
    CALayer *layer=[[CALayer alloc]init];
    layer.frame = self.iconImageBtn.frame;
    layer.cornerRadius=self.iconImageBtn.layer.cornerRadius;
    layer.backgroundColor=[UIColor blackColor].CGColor;//这里必须设置layer层的背景颜色，默认应该是透明的，导致设置的阴影颜色无法显示出来
    layer.shadowColor=LYZTheme_paleBrown.CGColor;//设置阴影的颜色
    layer.shadowRadius=5.0f;//设置阴影的宽度
    layer.shadowOffset=CGSizeMake(0, 0);//设置偏移
    layer.shadowOpacity=1;
    [self.layer addSublayer:layer];
    [self bringSubviewToFront:self.iconImageBtn];
    
//    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    headBtn.frame = self.iconImageBtn.bounds;
//
//    [self addSubview:headBtn];
    
    self.signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH * kSignBtnXScale, 30);
    self.signBtn.x = SCREEN_WIDTH - ( self.signBtn.width - self.signBtn.height / 2.0);
    self.signBtn.centerY = self.iconImageBtn.centerY;
    self.signBtn.layer.cornerRadius = self.signBtn.height / 2.0;
    self.signBtn.clipsToBounds = YES;
//    [self.signBtn setBackgroundImage:[GradientImgaeGenerator generatorImageWithImageSize:CGSizeMake(self.signBtn.width, self.signBtn.height) startPoint:CGPointMake(self.signBtn.width /2.0, 0) endPoint:CGPointMake(self.signBtn.width /2.0, self.signBtn.height) startColor:[UIColor whiteColor] endColor:RGB(198, 198, 198)] forState:UIControlStateNormal];
    [self.signBtn setTitle:@"立即签到" forState:UIControlStateNormal];
    self.signBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(0.0189 * SCREEN_WIDTH), 0, 0.0189 * SCREEN_WIDTH);
    self.signBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat signFont = iPhone5_5s ? 9.0f : 11.0f;
    self.signBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:signFont];
    [self.signBtn setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
    [self.signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.signBtn.layer.borderWidth = 1;
    self.signBtn.layer.borderColor = LYZTheme_paleBrown.CGColor;
    
    self.signBtn.needLogin = YES;
    [self addSubview:self.signBtn];
    
    
}


#pragma mark - lazy load

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame  = CGRectMake(0, 0, 90, 26);
        _loginBtn.layer.cornerRadius = _loginBtn.height /2.0;
        _loginBtn.clipsToBounds = YES;
        [_loginBtn setBackgroundImage:[GradientImgaeGenerator generatorImageWithImageSize:_loginBtn.frame.size startPoint: CGPointMake(0, 0) endPoint:CGPointMake(_loginBtn.width, 0) startColor:RGB(210, 182, 143) endColor:LYZTheme_paleBrown] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"注册/登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:15];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        CGFloat nameFont = iPhone5_5s ? 14.0f : 16.0f;
        _nameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:nameFont];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

-(UIButton *)vipTagBtn{
    if (!_vipTagBtn) {
        _vipTagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _vipTagBtn.frame = CGRectMake(0, 0, 60, 20);
        CGFloat vipFont = iPhone5_5s ? 13.0f : 15.0f;
        _vipTagBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:vipFont];
        _vipTagBtn.layer.cornerRadius = _vipTagBtn.height /2.0;
        _vipTagBtn.clipsToBounds = YES;
    }
    return _vipTagBtn;
}

-(UIButton *)vipDescriptionLabel{
    if (!_vipDescriptionBtn) {
        _vipDescriptionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _vipDescriptionBtn.frame = CGRectZero;
        _vipDescriptionBtn.backgroundColor = [UIColor clearColor];
         CGFloat descriptionFont = iPhone5_5s ? 11.0f : 13.0f;
        _vipDescriptionBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:descriptionFont];
    }
    return _vipDescriptionBtn;
}

- (void)loadContent {
   
    BaseMineInfoModel *mineInfo = (BaseMineInfoModel *)self.data;
    
    NSString *sign = [mineInfo.isSign isEqualToString:@"Y"] ? @"已签到":@"立即签到";
    [self.signBtn setTitle:sign forState:UIControlStateNormal];
    
    User *user = [LoginManager instance].userInfo;
//    [self.iconImageBtn sd_setImageWithURL:[NSURL URLWithString:user.facePath] placeholderImage:[UIImage imageNamed:@"me_icon_me"]];
    if ([LoginManager instance].isLogin ) {
           [self.iconImageBtn sd_setImageWithURL:[NSURL URLWithString:mineInfo.facepath]  forState:UIControlStateNormal];
    }else{
         [self.iconImageBtn setImage:[UIImage imageNamed:@"me_icon_me"] forState:UIControlStateNormal];
    }
 
    if (user.appUserID) {
        if ( _loginBtn && _loginBtn.superview) {
            [_loginBtn removeFromSuperview];
        }
        if (_vipTagBtn && _vipTagBtn.superview) {
            [_vipTagBtn removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
            [_vipTagBtn removeFromSuperview];
        }
        if (_nameLabel && _nameLabel.superview) {
            [_nameLabel removeFromSuperview];
        }
        if (_vipDescriptionBtn && _vipDescriptionBtn.superview) {
            [_vipDescriptionBtn removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
            [_vipDescriptionBtn removeFromSuperview];
        }
        
        self.nameLabel.text = mineInfo.username;
        [self.nameLabel sizeToFit];
        self.nameLabel.y = self.iconImageBtn.y;
        self.nameLabel.x = self.iconImageBtn.right + 0.0533 * SCREEN_WIDTH;
        [self addSubview:self.nameLabel];
        self.vipTagBtn.x = self.nameLabel.right + 0.02 *SCREEN_WIDTH;
        self.vipTagBtn.centerY = self.nameLabel.centerY;
        [self addSubview:self.vipTagBtn];
        self.vipDescriptionLabel.x = self.nameLabel.x;
        self.vipDescriptionLabel.y = self.nameLabel.bottom + 2;
        [self addSubview:self.vipDescriptionBtn];
        if ([mineInfo.isvip isEqualToString:@"Y"]) {
            self.vipTagBtn.layer.borderWidth = 1;
            [self.vipTagBtn setBackgroundImage:nil forState:UIControlStateNormal];
            self.vipTagBtn.layer.borderColor = LYZTheme_paleBrown.CGColor;
            [self.vipTagBtn setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
             self.vipTagBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:12];
            [self.vipTagBtn setTitle:mineInfo.vipinfo.vipname forState:UIControlStateNormal];
            [self.vipTagBtn addTarget:self action:@selector(toVipLevel:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.vipDescriptionBtn setTitleColor:RGB(184, 184, 184) forState:UIControlStateNormal];
            NSString *descr = [NSString stringWithFormat:@"%@ | %@ | %@",mineInfo.vipinfo.discountrule,mineInfo.vipinfo.pointsrule,mineInfo.vipinfo.checkouttimerule];
            [self.vipDescriptionBtn setTitle:descr forState:UIControlStateNormal];
            [self.vipDescriptionBtn sizeToFit];
            
        }else{
            [self.vipTagBtn setBackgroundImage:[GradientImgaeGenerator generatorImageWithImageSize:self.vipTagBtn.frame.size startPoint: CGPointMake(0, 0) endPoint:CGPointMake(_vipTagBtn.width, 0) startColor:RGB(210, 182, 143) endColor:LYZTheme_paleBrown] forState:UIControlStateNormal];
            [self.vipTagBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.vipTagBtn setTitle:@"加入会员" forState:UIControlStateNormal];
            self.vipTagBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:12];
            [self.vipTagBtn addTarget:self action:@selector(joinVip:) forControlEvents:UIControlEventTouchUpInside];
            [self.vipDescriptionBtn setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
            [self.vipDescriptionBtn setTitle:@"查看会员特权 >>" forState:UIControlStateNormal];
            [self.vipDescriptionBtn addTarget:self action:@selector(toVipRules:) forControlEvents:UIControlEventTouchUpInside];
            [self.vipDescriptionBtn sizeToFit];
        }
        
    }else{
        if (_nameLabel && _nameLabel.superview) {
            [_nameLabel removeFromSuperview];
        }
        if (_vipTagBtn && _vipTagBtn.superview) {
            [_vipTagBtn removeFromSuperview];
        }
        if (_vipDescriptionBtn  && _vipDescriptionBtn.superview) {
            [_vipDescriptionBtn removeFromSuperview];
        }
        self.loginBtn.x = _iconImageBtn.right + 20;
        self.loginBtn.centerY = self.iconImageBtn.centerY;
        [self addSubview:self.loginBtn];
    }
}

- (void)offsetY:(CGFloat)offsetY {
    
    if (offsetY <= 0) {
        self.scaleContentView.scale = offsetY * _scale.k + _scale.b;
        self.backgroundImageView.y  = 0.f;
    } else {
        self.scaleContentView.scale = 1.f;
        self.backgroundImageView.y  = offsetY / 2.f;
        }
}


#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _HeaderIconCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _HeaderIconCellHeight;
}

#pragma mark - Btn Actions

-(void)loginBtnClicked:(UIButton *)sender{
 
    LYZMineViewController *vc = (LYZMineViewController *)self.controller;
    if (![LoginManager instance].appUserID) {
        //to login
        if ([vc respondsToSelector:@selector(toLogin)]) {
            [vc toLogin];
        }
    }
}


-(void)toVipLevel:(UIButton *)sender{
      LYZMineViewController *vc = (LYZMineViewController *)self.controller;
    if ([vc respondsToSelector:@selector(toVipLevel)]) {
        [vc toVipLevel];
    }
}

-(void)toVipRules:(UIButton *)sender{
    LYZMineViewController *vc = (LYZMineViewController *)self.controller;
    if ([vc respondsToSelector:@selector(vipPrivilege)]) {
        [vc vipPrivilege];
    }
}


-(void)joinVip:(UIButton *)sender{
    LYZMineViewController *vc = (LYZMineViewController *)self.controller;
    if ([vc respondsToSelector:@selector(joinVip)]) {
        [vc joinVip];
    }
}

-(void)headClicked:(id)sender{
    LYZMineViewController *vc = (LYZMineViewController *)self.controller;
    if ([vc respondsToSelector:@selector(headBtnClick)]) {
        [vc headBtnClick];
    }
}

-(void)signBtnClick:(id)sender{
    LYZMineViewController *vc = (LYZMineViewController *)self.controller;
    if ([vc respondsToSelector:@selector(userSign)]) {
        [vc userSign];
    }
}




@end
