//
//  ChooseRoomCountView.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/3/13.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseRoomCountView : UIView

@property (nonatomic, copy) void(^chooseRoomCountHandler)(NSInteger roomCount);

@property (nonatomic, copy) void(^phoneCall)();

@property (nonatomic, assign) NSInteger roomCount;



@end
