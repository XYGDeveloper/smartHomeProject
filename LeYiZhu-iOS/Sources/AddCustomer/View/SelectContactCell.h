//
//  SelectContactCell.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/18.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "CustomCell.h"

@interface SelectContactCell : CustomCell

@property (class, nonatomic, readonly) CGFloat cellHeight;

@property (nonatomic, copy) void(^selectBtnHandler)(id data);

@property (nonatomic, copy)void(^editBtnHandler)(id data);

@end
