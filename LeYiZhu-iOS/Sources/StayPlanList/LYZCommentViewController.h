//
//  LYZCommentViewController.h
//  LeYiZhu-iOS
//
//  Created by L on 2018/1/19.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "UserStaysModel.h"
@interface LYZCommentViewController : UIViewController

@property (nonatomic, strong) UserStaysModel *stayModel;

@property (nonatomic, strong)CWStarRateView *starRateView;

@property (nonatomic, strong)UILabel *roomName;

@property (nonatomic, strong)UILabel *roomType;

@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UILabel *baseLine;


@end
