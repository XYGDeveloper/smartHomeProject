//
//  LYZWKDelegateViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/2.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol WKDelegate

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end


@interface LYZWKDelegateViewController : UIViewController<WKScriptMessageHandler>

@property (weak , nonatomic) id   delegate;

@end
