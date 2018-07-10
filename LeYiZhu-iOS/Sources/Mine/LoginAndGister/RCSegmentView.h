//
//  Created by xyg on 2017/3/20.
//  Copyright © 2017年 xyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCSegmentView : UIView <UIScrollViewDelegate>
@property (nonatomic,strong)NSArray * nameArray;
@property (nonatomic,strong)NSArray *controllers;
@property (nonatomic,strong)UIView * segmentView;
@property (nonatomic,strong)UIScrollView * segmentScrollV;
@property (nonatomic,strong)UIImageView * line;
@property (nonatomic ,strong)UIButton * seleBtn;
@property (nonatomic,strong)UILabel * down;
- (instancetype)initWithFrame:(CGRect)frame  controllers:(NSArray*)controllers titleArray:(NSArray*)titleArray ParentController:(UIViewController*)parentC;
@end
