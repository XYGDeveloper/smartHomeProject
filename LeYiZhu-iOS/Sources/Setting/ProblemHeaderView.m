//
//  ProblemHeaderView.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/18.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ProblemHeaderView.h"
#import "RotateView.h"
#import "ClassModel.h"

@interface ProblemHeaderView()

@property (nonatomic, strong) UIButton   *button;
@property (nonatomic, strong) RotateView *rotateView;

@property (nonatomic, strong) UIView      *icontentView;

@property (nonatomic, strong) UILabel     *numLabel;
@property (nonatomic, strong) UILabel     *problemLable;

@property (nonatomic, strong) UIImageView * imgView;
@end

@implementation ProblemHeaderView

- (void)buildSubview {
    
    // 白色背景
    _icontentView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kDefaultHeaderHeight - 0.25)];
    _icontentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_icontentView];
    // 按钮
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kDefaultHeaderHeight)];
    [self.button addTarget:self
                    action:@selector(buttonEvent:)
          forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:self.button atIndex:10001];
    
//    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 20, 20, 20)];
//    _imgView.image = [UIImage imageNamed:@"icon_problem"];
//    [_icontentView addSubview:_imgView];
    
    
    
    
//    self.numLabel      = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 20, kDefaultHeaderHeight)];
//    self.numLabel.font = [UIFont systemFontOfSize:16];
//    [_icontentView addSubview:self.numLabel];
    
    self.problemLable           = [[UILabel alloc] initWithFrame:CGRectMake( 20, 0, SCREEN_WIDTH - 2*DefaultLeftSpace - _imgView.width - 20, kDefaultHeaderHeight)];
    self.problemLable.numberOfLines = 0;
//    self.problemLable.font      = [UIFont systemFontOfSize:16];
    self.problemLable.textColor = LYZTheme_BlackFontColorFontColor;
    [_icontentView addSubview:self.problemLable];
    
    UIView *line2         = [[UIView alloc] initWithFrame:CGRectMake(0, kDefaultHeaderHeight-0.5, SCREEN_WIDTH, 0.5)];
    line2.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self addSubview:line2];
}

- (void)buttonEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customHeaderFooterView:event:)]) {
        
        [self.delegate customHeaderFooterView:self event:nil];
    }
}

- (void)loadContent {
    
    ClassModel *model = self.data;
    
//    _numLabel.text = model.num;
    _problemLable.text   =[NSString stringWithFormat:@"Q%@   %@", model.num,model.problem] ;
    [_problemLable adjustsFontSizeToFitWidth];
}

- (void)normalStateAnimated:(BOOL)animated {
    
    if (animated == YES) {
        
        [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _icontentView.frame = CGRectMake(0, 0, self.width, self.height);
            _problemLable.textColor =LYZTheme_BlackFontColorFontColor;
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
        
       _icontentView.frame = CGRectMake(0, 0, self.width, self.height);
       
    }
}

- (void)extendStateAnimated:(BOOL)animated {
    
    [self.rotateView changeToRightAnimated:animated];
    
    if (animated == YES) {
        
        [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
           _icontentView.frame = CGRectMake(0 + 15, 0, self.width, self.height);
            _problemLable.textColor = LYZTheme_paleBrown;
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
        
       _icontentView.frame = CGRectMake(0 + 15, 0, self.width, self.height);
        
    }
}



@end
