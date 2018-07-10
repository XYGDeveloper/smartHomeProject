//
//  IICalendarCell.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/13.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <FSCalendar/FSCalendar.h>

@interface IICalendarCell : FSCalendarCell

// The start/end of the range
@property (weak, nonatomic) CALayer *selectionLayer;

// The middle of the range
@property (weak, nonatomic) CALayer *middleLayer;

@end
