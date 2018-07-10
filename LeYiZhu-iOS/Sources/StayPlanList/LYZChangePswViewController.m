//
//  LYZChangePswViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/1.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZChangePswViewController.h"
#import "Masonry.h"
#import "CLVerificationCodeView.h"
#import "LYZPassWordView.h"
#import "UIView+Shake.h"

@interface LYZChangePswViewController ()<LYZPassWordViewDelegate>

@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic)  UIView *contentView;
@property (nonatomic, strong) CLVerificationCodeView *verCodeView;
@property (nonatomic, strong) LYZPassWordView *passwordView;

@end

@implementation LYZChangePswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self configUI];
}

-(void)configUI{
    self.backGroundView.alpha = 0;
    self.backGroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.backGroundView];
    self.contentView.alpha = 0;
    [self.view addSubview:self.contentView];
}


-(UIView *)backGroundView {
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backGroundView.backgroundColor = [UIColor blackColor];
    }
    return _backGroundView;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 80, 225)];
        _contentView.center = self.view.center;
        _contentView.y -= 100;
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5.0f;
        _contentView.clipsToBounds = YES;
        [self.view addSubview:_contentView];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(_contentView.width - 25, 10, 15, 15);
        [closeBtn setImage:[UIImage imageNamed:@"icon_close_small"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:closeBtn];
        
        UILabel *titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, _contentView.width, 20)];
        titleLabel.text = @"更换密码";
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:18];
        [_contentView addSubview:titleLabel];
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,titleLabel.bottom + 10, _contentView.width, 20)];
        subTitleLabel.text = @"正确输入下方验证码即可更换房门密码";
        subTitleLabel.textColor =LYZTheme_warmGreyFontColor;
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        subTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
        [_contentView addSubview:subTitleLabel];
        
        self.verCodeView = [[CLVerificationCodeView alloc] initWithFrame:CGRectMake((_contentView.width - 160)/2.0,subTitleLabel.bottom + 15 , 160, 40)];
        [_contentView addSubview:self.verCodeView];
        
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        refreshBtn.frame = CGRectMake(self.verCodeView.right + 10, self.verCodeView.y ,self.verCodeView.height, self.verCodeView.height);
        [refreshBtn setImage:[UIImage imageNamed:@"icon_refresh"] forState:UIControlStateNormal];
        [refreshBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        [refreshBtn addTarget:self action:@selector(changeVercode:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:refreshBtn];
        
        self.passwordView = [[LYZPassWordView alloc] initWithFrame:CGRectMake(0, self.verCodeView.bottom + 15, _contentView.width, 60)];
        self.passwordView.backgroundColor = [UIColor whiteColor];
        self.passwordView.rectColor = LYZTheme_PinkishGeryColor;
        self.passwordView.passWordNum = 4;
        self.passwordView.squareWidth = 40;
        self.passwordView.gap = 20.0f;
        self.passwordView.delegate = self;
        [_contentView addSubview:self.passwordView];
    }
    return _contentView;
}



- (void)showInViewController:(UIViewController *)vc{
    if (vc) {
        [vc addChildViewController:self];
        [vc.view addSubview:self.view];
        [self show];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}


- (void)show {
    self.backGroundView.alpha = 0.7;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentView.alpha = 1;
    } completion:nil];
    [self addKeyAnimation];
}


- (void)addKeyAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.calculationMode = kCAAnimationCubic;
    animation.values = @[@1.07,@1.06,@1.05,@1.03,@1.02,@1.01,@1.0];
    animation.duration = 0.4;
    [self.contentView.layer addAnimation:animation forKey:@"transform.scale"];
}

- (void)disMiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

-(void)changeVercode:(UIButton *)sender{
    [self.verCodeView CLChangeCode];
}


/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(LYZPassWordView *)passWord{
    
}

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(LYZPassWordView *)passWord{
    LYLog(@"vercode -----> %@\n enter ------> %@",self.passwordView.textStore,self.verCodeView.changeString);
    if ([[self.passwordView.textStore uppercaseString] isEqualToString:[self.verCodeView.changeString uppercaseString]]) {
        [self disMiss];
        if (self.vercodeCallBack) {
            self.vercodeCallBack();
        }
    }else{
        [_contentView shakeWithOptions:SCShakeOptionsDirectionHorizontal | SCShakeOptionsForceInterpolationNone | SCShakeOptionsAtEndComplete force:0.05 duration:1 iterationDuration:0.03 completionHandler:nil];
        [self.passwordView redrawError];
    }
}


/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(LYZPassWordView *)passWord{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
