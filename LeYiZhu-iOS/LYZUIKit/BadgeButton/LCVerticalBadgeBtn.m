//
//  LCBadgeBtn.m
//  ChaHuiTongH
//
//  Created by 锡哥 on 16/4/11.
//  Copyright © 2016年 ChaXinKeJi. All rights reserved.
//

#import "LCVerticalBadgeBtn.h"

@implementation LCVerticalBadgeBtn

- (void)setBadgeString:(NSString *)badgeString{
    _badgeString = badgeString;
    self.badgeLabel = [self viewWithTag:77];
    
    //NNSLog(@"label--%@",label);
    if (self.badgeString && ![self.badgeString isEqualToString:@"0"]) {
        
       // Drawing code
        if (self.badgeLabel) {
            [self.badgeLabel removeFromSuperview];
        }
            self.badgeLabel = [[UILabel alloc]init];
            self.badgeLabel.backgroundColor = RGB(208, 1, 27);
            self.badgeLabel.tag = 77;
            self.badgeLabel.layer.masksToBounds = YES;
            self.badgeLabel.layer.cornerRadius = 7;
            self.badgeLabel.textColor = [UIColor whiteColor];
            self.badgeLabel.textAlignment = NSTextAlignmentCenter;
            self.badgeLabel.font = [UIFont systemFontOfSize:10];
            self.badgeLabel.bounds = CGRectMake(0, 0, 14, 14);
            [self addSubview:self.badgeLabel];
        self.badgeLabel.text = badgeString;
        
        
    }else{
        self.badgeLabel.hidden = YES;
    }
}

-(void)setImg_title_space:(CGFloat)img_title_space{
    _img_title_space = img_title_space;
    [self layoutSubviews];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 更改image的坐标
    CGPoint imageCenter = self.imageView.center;
    imageCenter.x = self.frame.size.width/2;
    imageCenter.y = (self.frame.size.height-self.imageView.frame.size.height)/2;
    self.imageView.center = imageCenter;
    
    // 更改label的坐标
    CGRect labelFrame = self.titleLabel.frame;
    labelFrame.origin.x = 0;
    CGFloat space = _img_title_space ? : 5;
    labelFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + space;
    labelFrame.size.width = self.frame.size.width;

    self.titleLabel.frame = labelFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //image和label位置更换后，frame改变后再设置角标的值
    self.badgeLabel.center = CGPointMake(CGRectGetMaxX(self.imageView.frame)+2, CGRectGetMinY(self.imageView.frame) + 2);

}


@end
