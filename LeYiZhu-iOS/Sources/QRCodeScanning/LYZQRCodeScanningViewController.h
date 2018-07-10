//
//  LYZQRCodeScanningViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "SGQRCodeScanningVC.h"
#import "SGQRCode.h"

@interface LYZQRCodeScanningViewController : SGQRCodeScanningVC

@property (nonatomic, copy) void (^popBlock)(NSString *cabinetNo, NSString *type);

@end
