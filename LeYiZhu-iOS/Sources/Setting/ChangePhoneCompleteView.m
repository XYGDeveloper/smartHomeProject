//
//  ChangePhoneComplete.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/10.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ChangePhoneCompleteView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationSpring.h"
#import "LoginManager.h"



@interface ChangePhoneCompleteView ()

@property (nonatomic ,strong) UILabel * phoneLabel;

@end

@implementation ChangePhoneCompleteView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addAllViews];
        
    }
    return self;
}

-(void)addAllViews
{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView * sucImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 85)/2.0, 20, 85, 85)];
    sucImgView.image = [UIImage imageNamed:@"icon_finish"];
    [self addSubview:sucImgView];
    
    UILabel * sucMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, sucImgView.bottom + 15, self.width, 20)];
    sucMsgLabel.textAlignment = NSTextAlignmentCenter;
    sucMsgLabel.textColor = [UIColor blackColor];
    sucMsgLabel.font = [UIFont boldSystemFontOfSize:14];
    sucMsgLabel.text = @"手机号码修改成功";
    [self addSubview:sucMsgLabel];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, sucMsgLabel.bottom + 15, self.width, 20)];
    _phoneLabel.textAlignment = NSTextAlignmentCenter;
    _phoneLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _phoneLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_phoneLabel];
    
    UIButton * completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completeBtn.frame = CGRectMake((self.width - 265)/2.0, _phoneLabel.bottom + 18, 265, 50);
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    completeBtn.backgroundColor = LYZTheme_paleBrown;
    [completeBtn addTarget:self action:@selector(completeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:completeBtn];
    
}

-(void)setPhoneNum:(NSString *)phoneNum{
    _phoneLabel.text = [NSString stringWithFormat:@"您的手机号码为：%@",phoneNum];
}

-(void)completeBtnClick:(id)sender{
    
     [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
      [self performSelector:@selector(back:) withObject:nil afterDelay:.4];
}

-(void)back:(id)sender
{
    [self.parentVC.navigationController popViewControllerAnimated:NO];
    [[LoginManager instance] userLogin];
}




@end
