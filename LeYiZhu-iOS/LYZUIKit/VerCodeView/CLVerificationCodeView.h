//
//  CLVerificationCodeView.h
//  PictureVerCode
//
//  Created by zhuyuelong on 2017/4/20.
//  Copyright © 2017年 zhuyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CLVerificationCodeView : UIView

// 组成验证码数组
@property (nonatomic, retain) NSArray *changeArray;

// 生成验证码
@property (nonatomic, retain) NSMutableString *changeString;

// 更换验证码
- (void)CLChangeCode;

@end
