//
//  LYZStayFunctionCell.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CustomCell.h"

@interface LYZStayFunctionCell : CustomCell

//@property (class, nonatomic, readonly) CGFloat cellHeight;

@property (nonatomic, copy) void (^shareBtn)();
@property (nonatomic, copy) void (^renewBtn)();
@property (nonatomic, copy) void (^checkOutBtn)();

@end
