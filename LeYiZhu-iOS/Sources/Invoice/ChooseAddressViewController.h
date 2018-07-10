//
//  ChooseAddressViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecieverInfoModel;
@interface ChooseAddressViewController : UIViewController

@property (nonatomic,copy) void (^popCallBack)(RecieverInfoModel *model);

-(void)editBtnClick:(RecieverInfoModel *)model;

@end
