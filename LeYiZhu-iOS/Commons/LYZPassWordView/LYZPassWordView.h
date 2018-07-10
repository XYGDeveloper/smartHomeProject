//
//  LYZPassWordView.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/1.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//


#import <UIKit/UIKit.h>

@class LYZPassWordView;

@protocol  LYZPassWordViewDelegate<NSObject>

@optional
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(LYZPassWordView *)passWord;

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(LYZPassWordView *)passWord;

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(LYZPassWordView *)passWord;


@end

IB_DESIGNABLE

@interface LYZPassWordView : UIView<UIKeyInput>

@property (assign, nonatomic) IBInspectable NSUInteger passWordNum;//密码的位数
@property (assign, nonatomic) IBInspectable CGFloat squareWidth;//正方形的大小
@property (assign, nonatomic) IBInspectable CGFloat pointRadius;//黑点的半径
@property (assign, nonatomic) IBInspectable CGFloat gap;//框之间间隔
@property (strong, nonatomic) IBInspectable UIColor *pointColor;//黑点的颜色
@property (strong, nonatomic) IBInspectable UIColor *rectColor;//边框的颜色
@property (weak, nonatomic) IBOutlet id<LYZPassWordViewDelegate> delegate;
@property (strong, nonatomic, readonly) NSMutableString *textStore;//保存密码的字符串

-(void)redrawError;

@end
