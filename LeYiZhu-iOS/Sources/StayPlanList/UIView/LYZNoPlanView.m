//
//  LYZNoPlanView.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/30.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZNoPlanView.h"
#define NoPlanImgView 160.f


@interface LYZNoPlanView()

@end

@implementation LYZNoPlanView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = LYZTheme_BackGroundColor;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NoPlanImgView, NoPlanImgView)];
        imgView.center = CGPointMake(self.center.x, self.center.y-180);
        imgView.image = [UIImage imageNamed:@"no_live_luggage"];
        [self addSubview:imgView];
        UILabel *label = [[UILabel alloc]init];
        label.text = @"暂无入住信息";
        label.textColor =LYZTheme_warmGreyFontColor;
        label.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16.0f];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        label.frame = CGRectMake(SCREEN_WIDTH * 0.1, imgView.bottom + 20, SCREEN_WIDTH*0.8, 30);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH * 0.1, label.bottom + 30, SCREEN_WIDTH*0.8, 48);
        UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, btn.bottom + 10, SCREEN_WIDTH*0.8, 40)];
        infoLabel.textColor = [UIColor colorWithRed:145/255.0f green:145/255.0f blue:145/255.0f alpha:1.0f];
        infoLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:13.0f];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.numberOfLines = 0;
        infoLabel.text = @"注册/登录即可查看您的入住信息，并可通过网络进行开锁";
        [self addSubview:infoLabel];
        [btn setBackgroundColor:LYZTheme_paleBrown];
        [btn setTitle:@"注册/登录即可获取您的入住信息" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 2;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(orderNow:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    return self;
}

-(void)orderNow:(id)sender{
    if (self.orderBtnHandler) {
        self.orderBtnHandler();
    }
}


@end
