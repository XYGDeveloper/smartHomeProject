//
//  LYZIndexController.h
//  LeYiZhu-iOS
//
//  Created by L on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "MYPresentedController.h"

@class RecommendsModel,ActivitysModel;

@interface LYZIndexController : UIViewController

-(void)moreDetail:(RecommendsModel *) model;

-(void)activityDetail:(ActivitysModel *)model;

@end
