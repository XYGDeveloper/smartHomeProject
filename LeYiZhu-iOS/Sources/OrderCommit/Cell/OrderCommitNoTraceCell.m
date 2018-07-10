//
//  OrderCommitNoTraceCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "OrderCommitNoTraceCell.h"
#import "LYZOrderCommitViewController.h"
#import "LYZRenewViewController.h"

#define IMGHeight 40.0f

@interface OrderCommitNoTraceCell ()

@property (nonatomic, strong) UISwitch *traceSwitch;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic,strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

@end

static CGFloat _OrderTraceCellHeight = 72.0f;

@implementation OrderCommitNoTraceCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    _topLine.backgroundColor = kLineColor;
    [self addSubview:_topLine];
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, OrderCommitNoTraceCell.cellHeight - 0.5, SCREEN_WIDTH, 0.5)];
    _bottomLine.backgroundColor = kLineColor;
    [self addSubview:_bottomLine];
   
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, (57 - IMGHeight)/2.0, IMGHeight, IMGHeight)];
    _imgView.image = [UIImage imageNamed:@"g_combined_shapecopy"];
    [self addSubview:_imgView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right + 20, 0, 100, 57)];
    titleLabel.text = @"无痕入住";
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    titleLabel.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:titleLabel];
    
    _traceSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 45, 8, 45, 23)];
    _traceSwitch.onTintColor = LYZTheme_paleBrown;
    _traceSwitch.tintColor = kLineColor;
    [_traceSwitch addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_traceSwitch];
    
    UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 47, SCREEN_WIDTH, 20)];
    notice.font = [UIFont fontWithName:LYZTheme_Font_Regular size:12];
    notice.textColor = LYZTheme_PinkishGeryColor;
    notice.text = @"开启无痕入住，您的订单将在退房后自动消失";
    [self addSubview:notice];
}

- (void)loadContent {
    
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderTraceCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderTraceCellHeight;
}


#pragma mark -- Btn Action

-(void)switchIsChanged:(UISwitch *)sender{
    BOOL isOn;
    if ([sender isOn]){
        NSLog(@"The switch is turned on.");
         _imgView.image = [UIImage imageNamed:@"g_combined_shape"];
        self.backgroundColor = [UIColor colorWithHexString:@"#EEE8E1"];
        _bottomLine.backgroundColor = LYZTheme_paleBrown;
        _topLine.backgroundColor = LYZTheme_paleBrown;
        isOn = YES;
    } else {
        NSLog(@"The switch is turned off.");
         _imgView.image = [UIImage imageNamed:@"g_combined_shapecopy"];
         self.backgroundColor = [UIColor whiteColor];
        _bottomLine.backgroundColor = kLineColor;
        _topLine.backgroundColor = kLineColor;
        isOn = NO;
    }
    
    if ([self.controller isKindOfClass:[LYZOrderCommitViewController class]]) {
        LYZOrderCommitViewController *vc = (LYZOrderCommitViewController *)self.controller;
        if ([vc respondsToSelector:@selector(trackSwitch:)]) {
            [vc trackSwitch:isOn];
        }
    }
    
    if ([self.controller isKindOfClass:[LYZRenewViewController class]]) {
        LYZRenewViewController *vc = (LYZRenewViewController *)self.controller;
        if ([vc respondsToSelector:@selector(trackSwitch:)]) {
            [vc trackSwitch:isOn];
        }
    }
    
    
}


@end
