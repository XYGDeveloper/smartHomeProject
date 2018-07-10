//
//  PointView.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/16.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseMessageView.h"

@interface PointViewMessageObject : NSObject

@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end

NS_INLINE PointViewMessageObject * MakePointViewObject( NSString *imgName,NSString *title ,NSString *subtitle ) {
    
    PointViewMessageObject *object = [PointViewMessageObject new];
    
    object.imgName = imgName;
    object.title  = title;
    object.subtitle = subtitle;
    return object;
}

@interface PointView : BaseMessageView

@end
