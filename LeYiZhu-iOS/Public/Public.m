//
//  Public.m
//  ZTE_Health
//
//  Created by mac on 16/3/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Public.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "LoginManager.h"
#import "JGProgressHUD.h"

@interface Public ()


@end

@implementation Public

+ (void)changeRootViewControllerToMainVC
{
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIWindow *keyWindow  = delegate.window;
    
//    UIViewController *mainVC = [[MainVCViewController alloc]init];
//
//    LeftViewController *leftVC = (LeftViewController*)[Public initControllerFromStoryBoard:@"LeftController" identifier:@"LeftViewController"];
//    SlideViewController *slideVC = [[SlideViewController alloc]initWithLeftViewController:leftVC mainViewController:mainVC];
//    
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:slideVC];
//    delegate.nav = nav;
//    nav.navigationBarHidden = YES;
//    delegate.slideVC = slideVC;
//    keyWindow.rootViewController  = nav;
}

//从storyboard初始化一个控制器
+ (UIViewController*)initControllerFromStoryBoard:(NSString *)storyboardName identifier:(NSString *)identifier
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:identifier];
    return vc;
}


//使用MBProgressHUD显示一个弱提示
+ (void)showMessageWithHUD:(UIView *)baseView message:(NSString *)message
{
    
    [self textExample:baseView message:message];
    
    
}

+ (void)showMessageGlobalHud:(UIView*)baseView message:(NSString *)message
{
    [self textExample:baseView message:message];
}
+ (void)showMessageWithHUD:(UIView *)baseView message:(NSString *)message completeBlock:(MBProgressHUDCompletionBlock)block
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:baseView animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    // Move to bottm center.
    //    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.completionBlock = block;
    hud.contentColor = [UIColor blackColor];
    [hud hideAnimated:YES afterDelay:0.8];
    
}

+ (void)textExample:(UIView *)baseView message:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:baseView animated:YES];
//    hud.backgroundTintColor = [UIColor blackColor];
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    // Move to bottm center.
    //    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.completionBlock = ^(){
       
        NSLog(@"completionBlock");
    };
    hud.contentColor = [UIColor blackColor];
    [hud hideAnimated:YES afterDelay:0.8];
}

+ (MBProgressHUD*)showHudWithTitle:(UIView*)baseView message:(NSString*)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:baseView animated:YES];
    //    hud.backgroundTintColor = [UIColor blackColor];
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = message;
    // Move to bottm center.
    //    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.completionBlock = ^(){
        
        NSLog(@"completionBlock");
    };
    hud.contentColor = [UIColor blackColor];
    
    return hud;
}

// 使用系统的警告视图现实一个对话框 默认要手动点击才能消失
+ (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

+ (void)showAlertWithTitle:(NSString *)title  message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
/**
 *   @author 小段
 *
 *   显示一个转圈的HUD
 *
 *   @param view
 *
 *   @return
 */
+ (MBProgressHUD *)showHUD:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode =  MBProgressHUDModeIndeterminate;
    
    [hud showAnimated:YES];
    
    return hud;
}
/**
 *   @author 小段
 *
 *   生成特定结构的二进制数据包
 *
 *   @param head  头部标示符
 *   @param dataString 数据
 *   @param size 大小
 *
 *   @return
 */
+  (NSMutableData*)generateData:(NSString*)head data:(NSString*)dataString size:(NSUInteger)size
{
    //    NSString *tel = dataString;
    
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    char *initChar =  malloc(size);
    memset(initChar, 0, size);
    NSMutableData *initData = [[NSMutableData alloc]initWithBytes:initChar length:size];
    
    //判断下大小 防止越界
    NSUInteger length = 0;
    if (data.length > size){
        length = size;
    }else{
        length = data.length;
    }
    //判断下大小 防止越界
    [initData replaceBytesInRange:NSMakeRange(0, length) withBytes:data.bytes length:length];
    
    free(initChar);
    NSLog(@"data : %@",data);
    NSLog(@"initData count : %lu",(unsigned long)initData.length);
    NSLog(@"initData : %@",initData);
    
    
    //    NSMutableData *resultData = [NSMutableData dataWithData:[head dataUsingEncoding:NSUTF8StringEncoding]];
    //    [resultData appendData:initData];
    
    //    NSLog(@"data : %@",data);
    //    NSLog(@"resultData count : %lu",(unsigned long)resultData.length);
    //    NSLog(@"resultData : %@",resultData);
    return initData;
}

+  (NSMutableData*)generateData:(NSString*)head charData:(unsigned char)dataString size:(NSUInteger)size
{
    //    NSString *tel = dataString;
    
    NSData *data = [[NSData alloc]initWithBytes:&dataString length:1];
    
    char *initChar =  malloc(size);
    memset(initChar, 0, size);
    NSMutableData *initData = [[NSMutableData alloc]initWithBytes:initChar length:size];
    
    [initData replaceBytesInRange:NSMakeRange(0, data.length) withBytes:data.bytes length:data.length];
    
    free(initChar);
    NSLog(@"data : %@",data);
    NSLog(@"initData count : %lu",(unsigned long)initData.length);
    NSLog(@"initData : %@",initData);
    
    
    //    NSMutableData *resultData = [NSMutableData dataWithData:[head dataUsingEncoding:NSUTF8StringEncoding]];
    //    [resultData appendData:initData];
    
    //    NSLog(@"data : %@",data);
    //    NSLog(@"resultData count : %lu",(unsigned long)resultData.length);
    //    NSLog(@"resultData : %@",resultData);
    return initData;
}

+  (NSMutableData*)generateData:(NSString*)head shortData:(short)dataString size:(NSUInteger)size
{
    //    NSString *tel = dataString;
    
    NSData *data = [[NSData alloc]initWithBytes:&dataString length:2];
    
    char *initChar =  malloc(size);
    memset(initChar, 0, size);
    NSMutableData *initData = [[NSMutableData alloc]initWithBytes:initChar length:size];
    
    [initData replaceBytesInRange:NSMakeRange(0, data.length) withBytes:data.bytes length:data.length];
    
    free(initChar);
    NSLog(@"data : %@",data);
    NSLog(@"initData count : %lu",(unsigned long)initData.length);
    NSLog(@"initData : %@",initData);
    
    
    //    NSMutableData *resultData = [NSMutableData dataWithData:[head dataUsingEncoding:NSUTF8StringEncoding]];
    //    [resultData appendData:initData];
    
    //    NSLog(@"data : %@",data);
    //    NSLog(@"resultData count : %lu",(unsigned long)resultData.length);
    //    NSLog(@"resultData : %@",resultData);
    return initData;
}

+  (NSMutableData*)generateData:(NSString*)head intData:(unsigned int)dataString size:(NSUInteger)size
{
    //    NSString *tel = dataString;
    
    NSData *data = [[NSData alloc]initWithBytes:&dataString length:4];
    
    char *initChar =  malloc(size);
    memset(initChar, 0, size);
    NSMutableData *initData = [[NSMutableData alloc]initWithBytes:initChar length:size];
    
    [initData replaceBytesInRange:NSMakeRange(0, data.length) withBytes:data.bytes length:data.length];
    
    free(initChar);
    NSLog(@"data : %@",data);
    NSLog(@"initData count : %lu",(unsigned long)initData.length);
    NSLog(@"initData : %@",initData);
    
    
    //    NSMutableData *resultData = [NSMutableData dataWithData:[head dataUsingEncoding:NSUTF8StringEncoding]];
    //    [resultData appendData:initData];
    
    //    NSLog(@"data : %@",data);
    //    NSLog(@"resultData count : %lu",(unsigned long)resultData.length);
    //    NSLog(@"resultData : %@",resultData);
    return initData;
}

+ (NSMutableData*)generateThereData:(NSString *)head year:(unsigned char)year month:(unsigned char)month day:(unsigned char)day size:(NSUInteger)size
{
    NSMutableData *data = [[NSMutableData alloc]initWithBytes:&year length:1];
    [data appendBytes:&month length:1];
    [data appendBytes:&day length:1];
    
    return data;
}

#pragma mark -- 获取全局 delegate
+ (AppDelegate *)getAppDelegate
{
    AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return dele;
}

/*
#pragma mark -- 获取全局的BaseNav
+ (BaseNavController *)getGlobalBaseNav
{
    AppDelegate *dele = [self getAppDelegate];
    
    return dele.nav;
}
*/
+ (UIImage *)fetchGuanXiImageFromGuanXi:(NSInteger)guanxi
{
    UIImage *image = nil;
    //更新设备头像
    switch (guanxi) {
        case 1:
            //本人
            image = [UIImage imageNamed:@"user_me"];
            
            break;
        case 2:
            //伴侣
            image = [UIImage imageNamed:@"user_bannv"];
            
            break;
        case 3:
            //子女
            image = [UIImage imageNamed:@"user_zinv"];
            
            break;
        case 4:
            //朋友
            image = [UIImage imageNamed:@"user_pengyou"];
            
            break;
        case 5:
            //孙儿女
            image = [UIImage imageNamed:@"user_sunernv"];
            
            break;
        case 6:
            //亲戚
            image = [UIImage imageNamed:@"user_qingqi"];
            
            break;
        case 7:
            //其他
            image = [UIImage imageNamed:@"user_me"];
            
            
            break;
            
        default:
            image = [UIImage imageNamed:@"user_me"];
            
            break;
    }
    
    return image;
    
}

+ (UIImage *)fetchDeviceImageDefault
{
    UIImage * image = [UIImage imageNamed:@"user_me"];
    return image;
}

+ (UIImage *)fetchGuanXiImageFromSex:(NSInteger)sex
{
    if(sex == 1){
        return [UIImage imageNamed:@"user_me"];
    }
    if(sex == 2){
        return [UIImage imageNamed:@"user_bannv"];
    }
    return nil;
}

+ (UIImage *)fetchImageFromLocalDB:(NSString *)key
{
    return nil;
}

+ (NSString *)isNullAndSetSpacs:(NSString *)str
{
    if(str.length == 0){
        return @"";
    }else{
        return str;

    }
}

+ (UIImage *)buttonImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 4, 4);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
