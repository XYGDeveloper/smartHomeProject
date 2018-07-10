//
//  LYZFeatureView.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMessageView.h"

@interface FeatureViewMessageObject : NSObject

@property (nonatomic, strong) NSArray                         *imgs;
@property (nonatomic, assign)  NSInteger   index;
@end

NS_INLINE FeatureViewMessageObject * MakeUpdateViewObject(NSArray *imgs, NSInteger index) {
    
    FeatureViewMessageObject *object = [FeatureViewMessageObject new];
    object.imgs                 = imgs;
    object.index  = index;
    return object;
}


@interface LYZFeatureView : BaseMessageView

@end
