//
//  QQWRefreshFooter.m
//  Qqw
//
//  Created by zagger on 16/8/22.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import "QQWRefreshFooter.h"

@interface QQWRefreshFooter ()

@property (nonatomic, strong) UIView *noMoreView;

@end

@implementation QQWRefreshFooter

- (void)endRefreshingWithNoMoreData {
    [super endRefreshingWithNoMoreData];
    
    if (self.noMoreView) {
        self.noMoreView.frame = self.bounds;
        [self addSubview:self.noMoreView];
    }
}

- (void)resetNoMoreData {
    [super resetNoMoreData];
    
    if (self.noMoreView.superview) {
        [self.noMoreView removeFromSuperview];
    }
}


- (void)setFooterNoMoreView:(UIView *)noMoreView {
    if (self.noMoreView.superview) {
        [self.noMoreView removeFromSuperview];
    }
    
    self.noMoreView = noMoreView;
}

@end
