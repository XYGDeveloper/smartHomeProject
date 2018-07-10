//
//  QQWRefreshNoMoreView.m
//  Qqw
//
//  Created by zagger on 16/9/2.
//  Copyright © 2016年 quanqiuwa. All rights reserved.
//

#import "QQWRefreshNoMoreView.h"
#import "Masonry.h"
#define HexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
@interface QQWRefreshNoMoreView ()

@property (nonatomic, strong) UIView *leftLineView;

@property (nonatomic, strong) UIView *rightLineView;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation QQWRefreshNoMoreView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.leftLineView];
        [self addSubview:self.rightLineView];
        [self addSubview:self.contentLabel];
        
        [self configLayout];
    }
    
    return self;
}

- (void)configLayout {
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.contentLabel.mas_left).offset(-5);
        make.width.equalTo(@35);
        make.height.equalTo(@1);
    }];
    
    [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.contentLabel.mas_right).offset(5);
        make.width.equalTo(@35);
        make.height.equalTo(@1);
    }];
}

- (void)setContentLabelText:(NSString *)labelText {
    self.contentLabel.text = labelText;
}


#pragma mark - Properties
- (UIView *)leftLineView {
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc] init];
        _leftLineView.backgroundColor = HexColor(0x909090);
    }
    return _leftLineView;
}

- (UIView *)rightLineView {
    if (!_rightLineView) {
        _rightLineView = [[UIView alloc] init];
        _rightLineView.backgroundColor = HexColor(0x909090);
    }
    return _rightLineView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:12.0f];
        _contentLabel.textColor =HexColor(0x909090);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.text = @"更多内容 敬请期待";
    }
    return _contentLabel;
}

@end
