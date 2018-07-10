//
//  HeaderIconCell.h
//  Animations
//
//  Created by YouXianMing on 2016/11/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomCell.h"
#import "UserInfo.h"

@interface HeaderIconCell : CustomCell

@property (class, nonatomic, readonly) CGFloat cellHeight;

@property(nonatomic, copy)void(^buttonTappedHandler)();

- (void)offsetY:(CGFloat)offsetY;



@end
