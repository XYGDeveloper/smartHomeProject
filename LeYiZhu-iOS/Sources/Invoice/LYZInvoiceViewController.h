//
//  LYZInvoiceViewController.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/3/13.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderInvoiceModel;

typedef void(^popBlock)(); //返回按钮回调
typedef void(^popValueBlock)(OrderInvoiceModel *);

@interface LYZInvoiceViewController : UIViewController

@property (nonatomic, strong)OrderInvoiceModel *invoiceModel;

@property (nonatomic, copy) popValueBlock popBlock;


@property (nonatomic, copy) popBlock callback;

@end
