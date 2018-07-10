//
//  RenewCalendar.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/28.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseMessageView.h"

@interface RenewCalendarMessageObject : NSObject

@property (nonatomic, strong) NSDate *startDate;

@end

NS_INLINE RenewCalendarMessageObject * MakeRenewCalendarViewObject(NSDate *startDate ) {
    
    RenewCalendarMessageObject *object = [RenewCalendarMessageObject new];
    object.startDate   = startDate;
  
    return object;
}


@interface RenewCalendar : BaseMessageView

@end
