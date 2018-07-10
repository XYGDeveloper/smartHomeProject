//
//  InvoiceAddressViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecieverInfoModel;
@interface InvoiceAddressViewController : UIViewController

@property (nonatomic, strong) RecieverInfoModel *fromAddressModel;

@property (nonatomic,copy) void (^popCallBack)(RecieverInfoModel *model);

@end
