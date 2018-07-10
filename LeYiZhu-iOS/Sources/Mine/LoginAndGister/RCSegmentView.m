//
//  Created by xyg on 2017/3/20.
//  Copyright © 2017年 xyg. All rights reserved.
//

#import "RCSegmentView.h"

@implementation RCSegmentView
- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC
{
    if ( self=[super initWithFrame:frame])
    {
        self.controllers=controllers;
        self.nameArray=titleArray;
        self.segmentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 60)];
        self.segmentView.backgroundColor = [UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1.0f];
        self.segmentView.tag=50;
        [self addSubview:self.segmentView];
        self.segmentScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, frame.size.width, frame.size.height -40)];
        self.segmentScrollV.contentSize=CGSizeMake(frame.size.width*self.controllers.count, 0);
        self.segmentScrollV.delegate=self;
        self.segmentScrollV.showsHorizontalScrollIndicator=NO;
        self.segmentScrollV.pagingEnabled=YES;
        self.segmentScrollV.bounces=NO;
        [self addSubview:self.segmentScrollV];
        
        for (int i=0;i<self.controllers.count;i++)
        {
            UIViewController * contr=self.controllers[i];
            [self.segmentScrollV addSubview:contr.view];
            contr.view.frame=CGRectMake(i*frame.size.width, 0, frame.size.width,frame.size.height);
            [parentC addChildViewController:contr];
            [contr didMoveToParentViewController:parentC];
        }
        for (int i=0;i<self.controllers.count;i++)
        {
            UIButton * btn=[ UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i*(frame.size.width/self.controllers.count), 0, frame.size.width/self.controllers.count,60);
            btn.tag=i;
            [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font=[UIFont systemFontOfSize:17];
            if (i==0)
            {btn.selected=YES ;self.seleBtn=btn;
                btn.titleLabel.font=[UIFont systemFontOfSize:19];
            } else { btn.selected=NO; }
            
            [self.segmentView addSubview:btn];
        }
        self.line=[[UIImageView alloc]initWithFrame:CGRectMake(0,40, frame.size.width/self.controllers.count, 20)];
        self.line.image = [UIImage imageNamed:@"line"];
        self.line.tag=100;
        [self.segmentView addSubview:self.line];
        
}
    
    
    return self;
}
- (void)Click:(UIButton*)sender
{
    self.seleBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    self.seleBtn.titleLabel.font=[UIFont systemFontOfSize:19];
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:sender userInfo:nil];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center=frame;
    }];
    UIButton * btn=(UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
    self.seleBtn.selected=NO;
    self.seleBtn=btn;
    self.seleBtn.selected=YES;
}


@end
