//
//  ChooseRoomCountView.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/3/13.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "ChooseRoomCountView.h"

#define KCountBtnHeight 75
#define kCountBtnTag 100

@interface ChooseRoomCountView()

@property (nonatomic, strong) NSArray *btnsArr;

@end

@implementation ChooseRoomCountView

-(id)initWithFrame:(CGRect)frame {
    if ( [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor]
        ;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
        title.textColor = LYZTheme_warmGreyFontColor;
        title.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0f];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"选择房间数量";
        [self addSubview:title];
        
        UIView *Hline_one = [[UIView alloc] initWithFrame:CGRectMake(0, title.bottom, SCREEN_WIDTH, 0.5)];
        Hline_one.backgroundColor = LYZTheme_paleGreyFontColor;
        [self addSubview:Hline_one];
        UIView *Hline_two = [[UIView alloc] initWithFrame:CGRectMake(0, Hline_one.bottom + KCountBtnHeight, SCREEN_WIDTH,0.5)];
        Hline_two.backgroundColor = LYZTheme_paleGreyFontColor;
        [self addSubview:Hline_two];
        
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 1; i < 6; i ++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((SCREEN_WIDTH/5.0) *(i - 1), Hline_one.bottom, SCREEN_WIDTH/5.0, KCountBtnHeight);
            NSString *btnTitle = [NSString stringWithFormat:@"%i间",i];
            [btn setTitle:btnTitle forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
            btn.tag = kCountBtnTag + i;
            [btn addTarget:self action:@selector(roomCountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            if (i > count) {
//                btn.userInteractionEnabled = NO;
//                btn.alpha = 0.4;
//            }
            [self addSubview:btn];
            [temp addObject:btn];
            
            UIView *Vline = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/5.0) *i, Hline_one.bottom, 0.5, KCountBtnHeight)];
            Vline.backgroundColor = LYZTheme_paleGreyFontColor;
            [self addSubview:Vline];
        }
        self.btnsArr = [NSArray arrayWithArray:temp];
        
        UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(10, Hline_two.bottom, SCREEN_WIDTH, 47)];
        notice.textColor = LYZTheme_BrownishGreyFontColor;
        notice.font = [UIFont fontWithName:LYZTheme_Font_Light size:14.0f];
        notice.textAlignment = NSTextAlignmentCenter;
        notice.text = @"如超过5间，请联系客服进行预订";
        [self addSubview:notice];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(60, notice.y + (47 - 15)/2.0, 15, 15)];
        img.image = [UIImage imageNamed:@"howmuchroom_icon_phone"];
        [self addSubview:img];
        
        UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        phoneBtn.frame = CGRectMake(0, Hline_two.bottom, SCREEN_WIDTH, 47);
        [phoneBtn addTarget:self action:@selector(iphoneCall) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:phoneBtn];

    }
    return self;
}

-(void)setRoomCount:(NSInteger)roomCount{
    _roomCount = roomCount;
    for (int i = 0; i < self.btnsArr.count; i ++) {
        UIButton *btn = self.btnsArr[i];
        if (i > roomCount - 1) {
            btn.userInteractionEnabled = NO;
            btn.alpha = 0.4;
        }
    }
}


-(void)roomCountBtnClick:(UIButton *)btn{
    
    for (UIButton *ibtn in self.btnsArr) {
        [ibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }//先全变默认颜色
    
    //再变选中颜色
    [btn setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
    
    if (self.chooseRoomCountHandler) {
        self.chooseRoomCountHandler(btn.tag - kCountBtnTag);
    }
}

-(void)iphoneCall{
    if (self.phoneCall) {
        self.phoneCall();
    }
}

@end
