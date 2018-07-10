//
//  LYZQRCodeScanningViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZQRCodeScanningViewController.h"
#import "GCD.h"
#import "UIAlertView+Block.h"
#import "Public+JGHUD.h"
#import "AlertView.h"
#import "GCD.h"

#define ScanResultKey  @"lyz"
#define CabinetNoKey @"cabinetNO"
#define CabinetTypeKey  @"cabinetType"

@interface LYZQRCodeScanningViewController ()<BaseMessageViewDelegate>

@end

@implementation LYZQRCodeScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 注册观察者
    [SGQRCodeNotificationCenter addObserver:self selector:@selector(SGQRCodeInformationFromeAibum:) name:SGQRCodeInformationFromeAibum object:nil];
    [SGQRCodeNotificationCenter addObserver:self selector:@selector(SGQRCodeInformationFromeScanning:) name:SGQRCodeInformationFromeScanning object:nil];
}

- (void)SGQRCodeInformationFromeAibum:(NSNotification *)noti {
    NSString *string = noti.object;
    
}

- (void)SGQRCodeInformationFromeScanning:(NSNotification *)noti {
    SGQRCodeLog(@"noti - - %@", noti);
//    http://static.smartlyz.com/app/invite/invite_friends.html?data={ "lyz": { "cabinetNO": "02444030002001", "cabinetType": "4" } }
    NSString *string = noti.object;
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""]; //去掉空字符
    if (string) {
        if ([string rangeOfString:@"data="].location != NSNotFound) {
            NSString *targetStr = [string substringFromIndex:[string rangeOfString:@"data"].location + 5];
            NSData *jsonData = [targetStr dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
            if(err) {
                LYLog(@"json解析失败：%@",err);
                NSString *content                     = @"请扫描乐易住智能酒店的二维码";
                NSArray  *buttonTitles                =  @[AlertViewRedStyle(@"知道了")];
                
                [GCDQueue executeInMainQueue:^{
                    AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(nil,content, buttonTitles);
                    [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:100];
                }];
            }else{
                LYLog(@"scan result is  -- > %@",[[dic objectForKey:ScanResultKey] objectForKey:@"cabinetNO"]);
                if ([dic.allKeys containsObject:ScanResultKey]) {
                    NSDictionary *content = dic[ScanResultKey];
                    NSString *cabinetNo = content[CabinetNoKey];
                    NSString *cabinetType = content[CabinetTypeKey];
                    self.popBlock(cabinetNo,cabinetType);
                    [self.navigationController popViewControllerAnimated:NO];
                    
                }else{
                    NSString *content                     = @"请扫描乐易住智能酒店的二维码";
                    NSArray  *buttonTitles                =  @[AlertViewRedStyle(@"知道了")];
                    [GCDQueue executeInMainQueue:^{
                        AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(nil,content, buttonTitles);
                        [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:100];
                    }];
                    
                }
            }
            
        }else{
            NSString *content                     = @"请扫描乐易住智能酒店的二维码";
            NSArray  *buttonTitles                =  @[AlertViewRedStyle(@"知道了")];
            [GCDQueue executeInMainQueue:^{
                AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(nil,content, buttonTitles);
                [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:100];
            }];
        }
       
    }
    
    
    if ([string hasPrefix:@"http"]) {
        
        
    } else { // 扫描结果为条形码
        
    }
}


#pragma mark - BaseMessageViewDelegate

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
    if (messageView.tag == 100) {
        if ([event isEqualToString:@"知道了"]) {
            [self setupSGQRCodeScanning];
        }
    }
    [messageView hide];
    
}

- (void)dealloc {
    SGQRCodeLog(@"QRCodeScanningVC - dealloc");
    [SGQRCodeNotificationCenter removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
