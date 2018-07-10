//
//  LYZStayNoticeCell.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CustomCell.h"

@interface LYZStayGuideCell : CustomCell

@property (class, nonatomic, readonly) CGFloat cellHeight;

@property (nonatomic, copy)void (^userGuid)();

@end
