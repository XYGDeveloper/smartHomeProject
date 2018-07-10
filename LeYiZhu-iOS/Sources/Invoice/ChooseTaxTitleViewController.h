//
//  ChooseTaxTitleViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@class InvoiceTitleModel;
@interface ChooseTaxTitleViewController : UIViewController

@property (nonatomic,copy) void (^popCallBack)(InvoiceTitleModel *model);

-(void)editBtnClick:(InvoiceTitleModel *)model;

@end
