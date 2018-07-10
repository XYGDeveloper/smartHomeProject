//
//  LYZStayCheckInTable.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserStaysModel;

@protocol StayCheckInTableDelegate <NSObject>

@optional

-(void)shareBtnClicked;

-(void)renewBtnClicked:(UserStaysModel *)model;

-(void)checkoutBtnClicked:(UserStaysModel *)model;

-(void)openDoorSlider:(UserStaysModel *)model;

-(void)changePswBtnClick:(UserStaysModel *)model;

@end


@interface LYZStayCheckInTable : UIView

@property (nonatomic, strong) UserStaysModel *dataSource;
@property (nonatomic, assign) id <StayCheckInTableDelegate> delegate;
@property (nonatomic, assign) BOOL showNext;

//@property (nonatomic, strong) UIView *headArrowView;
//@property (nonatomic, strong) UIView *footArrowView;

@property (nonatomic, strong) UIView *baseView;

@end
