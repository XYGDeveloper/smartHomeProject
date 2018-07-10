//
//  LYZPassWordView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/1.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZPassWordView.h"

@interface LYZPassWordView ()

@property (strong, nonatomic) NSMutableString *textStore;//保存密码的字符串

@property (assign,nonatomic) BOOL isError;

@end

@implementation LYZPassWordView

static NSString  * const MONEYNUMBERS = @"0123456789";

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.textStore = [NSMutableString string];
        self.squareWidth = 45;
        self.passWordNum = 6;
        self.pointRadius = 6;
        self.isError = NO;
        self.rectColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.pointColor = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0];
        [self becomeFirstResponder];
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textStore = [NSMutableString string];
        self.squareWidth = 45;
        self.passWordNum = 6;
        self.pointRadius = 6;
        self.gap = 28.0f;
        self.rectColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.pointColor = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0];
        [self becomeFirstResponder];
    }
    return self;
}


/**
 *  设置正方形的边长
 */
- (void)setSquareWidth:(CGFloat)squareWidth {
    _squareWidth = squareWidth;
    [self setNeedsDisplay];
}

/**
 *  设置键盘的类型
 */
- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeASCIICapable;
}

/**
 *  设置密码的位数
 */
- (void)setPassWordNum:(NSUInteger)passWordNum {
    _passWordNum = passWordNum;
    [self setNeedsDisplay];
}

- (BOOL)becomeFirstResponder {
    if ([self.delegate respondsToSelector:@selector(passWordBeginInput:)]) {
        [self.delegate passWordBeginInput:self];
    }
    return [super becomeFirstResponder];
}

/**
 *  是否能成为第一响应者
 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}

#pragma mark - UIKeyInput
/**
 *  用于显示的文本对象是否有任何文本
 */
- (BOOL)hasText {
    return self.textStore.length > 0;
}

/**
 *  插入文本
 */
- (void)insertText:(NSString *)text {
    if (self.textStore.length < self.passWordNum) {
        //判断是否是数字
//        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:MONEYNUMBERS] invertedSet];
//        NSString*filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        BOOL basicTest = [text isEqualToString:filtered];
//        if(basicTest) {
            [self.textStore appendString:text];
            if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
                [self.delegate passWordDidChange:self];
            }
            if (self.textStore.length == self.passWordNum) {
                if ([self.delegate respondsToSelector:@selector(passWordCompleteInput:)]) {
                    [self.delegate passWordCompleteInput:self];
                }
            }
            [self setNeedsDisplay];
        
    }
}

/**
 *  删除文本
 */
- (void)deleteBackward {
    if (self.textStore.length > 0) {
        [self.textStore deleteCharactersInRange:NSMakeRange(self.textStore.length - 1, 1)];
        if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
            [self.delegate passWordDidChange:self];
        }
    }
    [self setNeedsDisplay];
}


-(void)redrawError{
   self.isError = YES;
    self.textStore = [NSMutableString stringWithString:@""];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect {
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
//    CGFloat x = (width - self.squareWidth*self.passWordNum)/2.0;
    CGFloat x = (width - self.squareWidth*self.passWordNum - self.gap*(self.passWordNum - 1))/2.0;
    CGFloat y = (height - self.squareWidth)/2.0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画框
    for (int i = 0; i< self.passWordNum; i++) {
        CGContextAddRect(context, CGRectMake( x + i *(self.squareWidth + self.gap) , y, self.squareWidth, self.squareWidth));
        CGContextSetLineWidth(context, 1);
        if (_isError) {
             CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        }else{
            CGContextSetStrokeColorWithColor(context, self.rectColor.CGColor);
        }
        
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        CGContextSetFillColorWithColor(context, self.pointColor.CGColor);
    }
//    //画外框
//    CGContextAddRect(context, CGRectMake( x, y, self.squareWidth*self.passWordNum, self.squareWidth));
//    CGContextSetLineWidth(context, 1);
//    CGContextSetStrokeColorWithColor(context, self.rectColor.CGColor);
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    //画竖条
//    for (int i = 1; i <= self.passWordNum; i++) {
//        CGContextMoveToPoint(context, x+i*self.squareWidth, y);
//        CGContextAddLineToPoint(context, x+i*self.squareWidth, y+self.squareWidth);
//        CGContextClosePath(context);
//    }
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextSetFillColorWithColor(context, self.pointColor.CGColor);
    //画黑点
    for (int i = 0 ; i < self.textStore.length; i++) {
//                CGContextAddArc(context,  x+i*(self.squareWidth + self.gap)+self.squareWidth/2.0, y+self.squareWidth/2, self.pointRadius, 0, M_PI*2, YES);
//                CGContextDrawPath(context, kCGPathFill);
        
        //段落格式
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle.alignment = NSTextAlignmentCenter;//水平居中
        //字体
        UIFont  *font = [UIFont fontWithName:LYZTheme_Font_Regular size:18.0];
        //构建属性集合
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle};
        //获得size
        NSString *str = [self.textStore substringWithRange:NSMakeRange(i, 1)];
        //垂直居中要自己计算
        CGRect r = CGRectMake(x+i*(self.squareWidth + self.gap),y +self.squareWidth/5.0   ,self.squareWidth, self.squareWidth);
        [str drawInRect:r withAttributes:attributes];
        
    }
    self.isError = NO;
}

@end
