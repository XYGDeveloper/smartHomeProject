//
//  SureCustomActionSheet.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//
#import "SureCustomActionSheet.h"
#import "SureCustonActionSheetModel.h"


#define SPACE 20

@interface SureCustomActionSheet ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *optionsArr;
@property (nonatomic,   copy) NSString *cancelTitle;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic,   copy) void(^selectedBlock)(NSInteger);
@property (nonatomic,   copy) void(^cancelBlock)();
@end

@implementation SureCustomActionSheet

- (instancetype)initWithTitleView:(UIView*)titleView
                       optionsArr:(NSArray*)optionsArr
                      cancelTitle:(NSString*)cancelTitle
                    selectedBlock:(void(^)(NSInteger))selectedBlock
                      cancelBlock:(void(^)())cancelBlock {
    if (self = [super init]) {
        _headView = titleView;
        _optionsArr = optionsArr;
        _cancelTitle = cancelTitle;
        _selectedBlock = selectedBlock;
        _cancelBlock = cancelBlock;
        [self craetUI];
    }
    return self;
}

- (void)craetUI {
    self.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.maskView];
    [self addSubview:self.tableView];
}

- (UIView*)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = .5;
        _maskView.userInteractionEnabled = YES;
    }
    return _maskView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 10;
        _tableView.clipsToBounds = YES;
        _tableView.rowHeight = 44.0;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorInset = UIEdgeInsetsMake(0, -50, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Navi_Cell"];
    }
    return _tableView;
}
#pragma mark TableViewDel
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0)?_optionsArr.count:1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Navi_Cell"];
    if (indexPath.section == 0) {
        SureCustonActionSheetModel *model = _optionsArr[indexPath.row];
        
        if (model.selectable) {
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text =model.content;
        }else{
            cell.textLabel.textColor = LYZTheme_PinkishGeryColor;
            cell.textLabel.text = [NSString stringWithFormat:@"%@   %@",model.content,@"无空格"];
        }
        
        if (indexPath.row == _optionsArr.count - 1) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:
                                      CGRectMake(0, 0, SCREEN_WIDTH - (SPACE * 2), tableView.rowHeight) byRoundingCorners:
                                      UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:
                                      CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            maskLayer.frame = cell.contentView.bounds;
            maskLayer.path = maskPath.CGPath;
            cell.layer.mask = maskLayer;
        }
    } else {
        cell.textLabel.text = _cancelTitle;
        cell.layer.cornerRadius = 10;
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.selectedBlock) {
             SureCustonActionSheetModel *model = _optionsArr[indexPath.row];
            if (model.selectable) {
                 self.selectedBlock(indexPath.row);
                  [self dismiss];
            }
        }
    } else {
        if (self.cancelBlock) {
            self.cancelBlock();
             [self dismiss];
        }
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SPACE;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, SPACE)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self show];
}

- (void)show {
    _tableView.frame = CGRectMake(SPACE, SCREEN_HEIGHT - 64, SCREEN_WIDTH - (SPACE * 2), _tableView.rowHeight * (_optionsArr.count + 1) + _headView.bounds.size.height + (SPACE * 2));
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = _tableView.frame;
        rect.origin.y -= _tableView.bounds.size.height;
        _tableView.frame = rect;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = _tableView.frame;
        rect.origin.y += _tableView.bounds.size.height;
        _tableView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
