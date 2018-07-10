//
//  IndicatorView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IndicatorView.h"



@implementation IndicatorView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        //通知
        self.TnotificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 120, 20)];
        self.TnotificationLabel.text = @"接到通知";
        [self addSubview:self.TnotificationLabel];
        
        self.CnoitificationLabel = [[UILabel alloc] initWithFrame:CGRectMake( 140, 50, 200, 20)];
        self.CnoitificationLabel.text = @"内容：";
        [self addSubview:self.CnoitificationLabel];
        
        //匹配
        self.TmatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 120, 20)];
        self.TmatchLabel.text = @"匹配成功";
        [self addSubview:self.TmatchLabel];
        
        self.CmatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 100, 200, 20)];
      self.CmatchLabel.text = @"内容：";
        [self addSubview:self.CmatchLabel];
        
        //开门
        self.TOpenDoorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 120, 20)];
        self.TOpenDoorLabel.text = @"开门成功";
        [self addSubview:self.TOpenDoorLabel];
        
        self.COpenDooLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 150, 200, 20)];
        self.COpenDooLabel.text = @"内容：";
        [self addSubview:self.COpenDooLabel];
        
        //超时
        self.TOutTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 120, 20)];
        self.TOutTimeLabel.text = @"请求超时";
        [self addSubview:self.TOutTimeLabel];
        
        self.COutTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 200, 200, 20)];
        self.COutTimeLabel.text = @"内容：";
        [self addSubview:self.COutTimeLabel];
        
        UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
        close.frame =CGRectMake(80, 300 , 60 ,60 );
        [close setTitle:@"关闭" forState:UIControlStateNormal];
        [close setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:close];
        
        UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
        clear.frame =CGRectMake(SCREEN_WIDTH - 140, 300 , 60 ,60 );
        [clear setTitle:@"清除" forState:UIControlStateNormal];
        [clear setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [clear addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clear];
    
    }
    return self;
}

-(void)close:(UIButton *)sender{
    if (self.superview) {
        [self removeFromSuperview];
          [self clear:nil];
    }
  
}

-(void)clear:(UIButton *)sender{
    
    self.TnotificationLabel.text = @"接到通知";
    self.CnoitificationLabel.text = @"内容：";
    

    self.TmatchLabel.text = @"匹配成功";
    self.CmatchLabel.text = @"内容：";
   
    //开门
    self.TOpenDoorLabel.text = @"开门成功";
    self.COpenDooLabel.text = @"内容：";
   
    //超时
    self.TOutTimeLabel.text = @"请求超时";
    self.COutTimeLabel.text = @"内容：";
  
}




@end
