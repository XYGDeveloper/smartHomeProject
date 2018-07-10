//
//  LYZStayPswCell.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CustomCell.h"
#import "UICountingLabel.h"
@class UserStaysModel;
@interface LYZStayPswCell : CustomCell

//@property (class, nonatomic, readonly) CGFloat cellHeight;
@property (nonatomic, assign)BOOL isEyeOpen;
@property (nonatomic, copy) void (^showPswHandler)(BOOL isOpen);
@property (nonatomic, copy)void (^OpenDoorHandler)();
@property (nonatomic, copy) void(^changePswHandler)(UserStaysModel *model);

@end
