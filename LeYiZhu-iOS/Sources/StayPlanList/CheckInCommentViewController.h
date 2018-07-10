//
//  CheckInCommentViewController.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/2/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "UserStaysModel.h"


@class HXPhotoManager;

@interface CheckInCommentViewController : UIViewController

@property (nonatomic, strong) UserStaysModel *stayModel;

@property (nonatomic, strong)CWStarRateView *starRateView;

@property (nonatomic, weak) IBOutlet UIView *baseView;

@property (nonatomic, weak) IBOutlet UILabel *hotelNameLabel;

@property (nonatomic, weak) IBOutlet UILabel *hotelRoomTypeLabel;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) HXPhotoManager *manager;


-(IBAction)comment:(id)sender;

@end
