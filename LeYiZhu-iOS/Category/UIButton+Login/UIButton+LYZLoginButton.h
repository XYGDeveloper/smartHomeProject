//
//  UIButton+LYZLoginButton.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/22.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LYZLoginButton)

@property (nonatomic , assign) BOOL needLogin;

@property (nonatomic, copy) NSString  *selector;

@property (nonatomic,strong) id objClass;

@end
