//
//  LYZMineViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/31.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYZMineViewController : UIViewController

-(void)didSelectedFunctionItemAtIndex:(NSInteger)index;

-(void)didSelectedOrderTypeItemAtIndex:(NSInteger)index; //点击订单事件

-(void)toLogin;

-(void)toVipLevel;

-(void)vipPrivilege;

-(void)joinVip;

-(void)headBtnClick;

-(void)userSign;

@end
