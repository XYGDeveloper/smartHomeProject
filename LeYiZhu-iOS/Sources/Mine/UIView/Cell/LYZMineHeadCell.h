//
//  LYZMineHeadCell.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/17.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "CustomCell.h"

@interface LYZMineHeadCell : CustomCell

@property (class, nonatomic, readonly) CGFloat cellHeight;

- (void)offsetY:(CGFloat)offsetY;

@end
