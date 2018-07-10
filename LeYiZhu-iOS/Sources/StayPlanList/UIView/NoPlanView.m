//
//  NoPlanView.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "NoPlanView.h"

#define NoPlanImgView 140.f

@interface NoPlanView()


@end

@implementation NoPlanView

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
        label.textColor = LYZTheme_warmGreyFontColor;
        label.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16.0f];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        label.frame = CGRectMake(SCREEN_WIDTH * 0.1, imgView.bottom + 30, SCREEN_WIDTH*0.8, 30);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH * 0.1, label.bottom + 30, SCREEN_WIDTH*0.8, 48);
        [btn setBackgroundColor:LYZTheme_paleBrown];
        [btn setTitle:@"预订酒店" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 4;
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
