//
//  EmptyManager.m
//  Qqw
//
//  Created by zagger on 16/8/17.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import "EmptyManager.h"

@implementation EmptyManager

+ (instancetype)sharedManager {
    static EmptyManager *__manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[EmptyManager alloc] init];
    });
    return __manager;
}

- (EmptyView *)showEmptyOnView:(UIView *)parentView
              withImage:(UIImage *)image
                explain:(NSString *)explain
          operationText:(NSString *)opText
         operationBlock:(void(^)(void))opBlock {
    
    [self removeEmptyFromView:parentView];
    EmptyView *view = [[EmptyView alloc] initWithFrame:CGRectMake(0, 0, parentView.width, parentView.height)];
    [view refreshWithImage:image explain:explain operationText:opText operationBlock:opBlock];
    [parentView addSubview:view];
    return view;
}

- (EmptyView *)showNetErrorOnView:(UIView *)parentView
                         response:(ApiResponse *)response
                   operationBlock:(void(^)(void))opBlock {
    
    [self removeEmptyFromView:parentView];
    
    EmptyView *view = [[EmptyView alloc] initWithFrame:CGRectMake(0, 0, parentView.width, parentView.height)];
    [view netErrorLayout];
    
    [view refreshWithImage:[UIImage imageNamed:@"network"] explain:@"抱歉,网络状态不稳定，请检查网络连接" operationText:@"" operationBlock:^{
        [self removeEmptyFromView:parentView];
        if (opBlock) {
            opBlock();
        }
    }];
    [parentView addSubview:view];
    
    return view;
}

- (void)removeEmptyFromView:(UIView *)parentView {
    for (UIView *subView in parentView.subviews) {
        if ([subView isKindOfClass:[EmptyView class]]) {
            [subView removeFromSuperview];
        }
    }
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface EmptyView ()

@property (nonatomic, strong) UIImageView *emptyImgView;

@property (nonatomic, strong) UILabel *emptyLabel;

@property (nonatomic, strong) UIButton *operationButton;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) void(^operationBlock)();

@end

@implementation EmptyView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.operationButton addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.emptyImgView];
        [self addSubview:self.emptyLabel];
        [self addSubview:self.operationButton];
        
        [self configLayout];
    }
    return self;
}

- (void)configLayout {
    [self.emptyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.centerX.equalTo(self);
    }];
    [self.emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emptyImgView.mas_bottom).offset(43);
        make.left.right.equalTo(@0);
    }];
    
    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emptyLabel.mas_bottom).offset(14);
        make.centerX.equalTo(self);
        make.width.equalTo(@250);
        make.height.equalTo(@44);
    }];
    
}

- (void)netErrorLayout {
    [self.emptyImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.equalTo(@100);
        make.top.equalTo(@50);
        make.centerX.equalTo(self);
    }];
}

#pragma mark - Public Methods
- (void)refreshWithImage:(UIImage *)image
                 explain:(NSString *)explain
           operationText:(NSString *)opText
          operationBlock:(void(^)(void))opBlock {
    self.emptyImgView.image = image;
    self.emptyImgView.size = image.size;
    
    self.emptyLabel.text = explain;

    self.operationButton.hidden = opText.length <= 0;
    [self.operationButton setTitle:opText forState:UIControlStateNormal];
    self.operationBlock = opBlock;
}

#pragma mark - Events
- (void)operationButtonClicked:(id)sender {
    if (self.operationBlock) {
        self.operationBlock();
    }
}

#pragma mark - Properties
- (UIImageView *)emptyImgView {
    if (!_emptyImgView) {
        _emptyImgView = [[UIImageView alloc] init];
        _emptyImgView.contentMode = UIViewContentModeScaleAspectFill;
        _emptyImgView.clipsToBounds = YES;
    }
    return _emptyImgView;
}

- (UILabel *)emptyLabel {
    if (!_emptyLabel) {
        _emptyLabel = [[UILabel alloc] init];
        _emptyLabel.backgroundColor = [UIColor clearColor];

        _emptyLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16.0];

        _emptyLabel.textColor = LYZTheme_BrownishGreyFontColor;
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _emptyLabel;
}

- (UIButton *)operationButton {
    if (!_operationButton) {
        
        _operationButton = [UIHelper generalRaundCornerButtonWithTitle:@" "];
        
    }
    return _operationButton;
}






@end
