//
//  UIStoryboard+Extension.m
//  Enterprise
//
//  Created by SG on 2017/3/31.
//  Copyright © 2017年 com.sofn.lky.enterprise. All rights reserved.
//

#import "UIStoryboard+Extension.h"

@implementation UIStoryboard (Extension)

+ (instancetype)SBWithName:(NSString *)name{
    return [UIStoryboard storyboardWithName:name bundle:nil];
}


+ (UIViewController *)rootViewControllerWithSBName:(NSString *)name{
    return [[UIStoryboard SBWithName:name] instantiateInitialViewController];
}


+ (UIViewController *)viewControllerWithSBName:(NSString *)name identifier:(NSString *)identifier{

    return [[UIStoryboard SBWithName:name] instantiateViewControllerWithIdentifier:identifier];
}


+ (void)swithWindowsRootViewControllerWithSBName:(NSString *)name{
   dispatch_sync(dispatch_get_main_queue(), ^{
       UIViewController *rootViewController = [UIStoryboard rootViewControllerWithSBName:name];
       [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
   });
}
@end
