//
//  QQWRefreshFooter.h
//  Qqw
//
//  Created by zagger on 16/8/22.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import "MJRefresh.h"
#import "QQWRefreshNoMoreView.h"

@interface QQWRefreshFooter : MJRefreshAutoFooter

/** 设置没有更多数据时，显示的视图 */
- (void)setFooterNoMoreView:(UIView *)noMoreView;

@end
