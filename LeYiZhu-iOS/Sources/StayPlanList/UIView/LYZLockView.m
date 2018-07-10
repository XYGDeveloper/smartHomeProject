//
//  LYZLockView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/26.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZLockView.h"

@interface LYZLockView ()

@property (nonatomic, strong) UILabel *titlteLabel;

@property (nonatomic, strong) UISlider *slider;

@end

@implementation LYZLockView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContent];
    }
    return self;
}

-(void)loadContent{
    
  
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    self.layer.borderWidth = .5f;
    self.layer.borderColor = LYZTheme_PinkishGeryColor.CGColor;
    
    _titlteLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titlteLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    _titlteLabel.textColor = RGB(208, 208, 208);
    _titlteLabel.text= @"右滑网络开锁 >";
    [self addSubview:_titlteLabel];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 20 - 5, (self.height - 20)/2.0 , 20, 20)];
    imgView.image = [UIImage imageNamed:@"live_icon_keyhole"];
    [self addSubview:imgView];
    
    _slider =[[UISlider alloc] initWithFrame:self.bounds];
    
    
    

}

@end
