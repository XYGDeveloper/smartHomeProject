//
//  LoginController.h
//  LeYiZhu-iOS
//
//  Created by a a  on 2016/11/18.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
typedef NS_ENUM(NSInteger, loginType) {
    weiBoType = 1,
    QQType,
    weChatType
};

typedef void (^PresentCompletionBlock)(void);

@interface LoginController : UIViewController

- (void)weichatLogin:(SendAuthResp*)authResp;

@property (nonatomic , strong) PresentCompletionBlock presentBlock;

@end
