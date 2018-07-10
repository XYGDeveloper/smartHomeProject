//
//  LYZWaitingCheckInTable.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserStaysModel;

@protocol StayWaitingTableDelegate <NSObject>

@optional

-(void)tableClickAtIndex:(NSInteger)index withDataSource:(UserStaysModel *)dataSource;

@end

@interface LYZStayWaitingCheckInTable : UIView

@property (nonatomic, strong) UserStaysModel *dataSource;
@property (nonatomic, assign) id <StayWaitingTableDelegate> delegate;
@property (nonatomic, assign) BOOL showUp;
@property (nonatomic, assign) BOOL showNext;



@end
