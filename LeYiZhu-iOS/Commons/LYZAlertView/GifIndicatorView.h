//
//  GifIndicatorView.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseMessageView.h"

@interface GifIndicatorViewObject : NSObject

@property (nonatomic, strong) NSData                         *gifData;

@end

NS_INLINE GifIndicatorViewObject * MakeGifIndicatorViewObject(NSData *gifData) {
    
    GifIndicatorViewObject *object = [GifIndicatorViewObject new];
    object.gifData                 = gifData;
    return object;
}


@interface GifIndicatorView : BaseMessageView

@end
