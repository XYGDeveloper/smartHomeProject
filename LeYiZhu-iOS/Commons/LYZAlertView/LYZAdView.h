//
//  LYZAdView.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/3.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseMessageView.h"

typedef enum : NSUInteger {
    vipType = 0,
    couponType
} actionType;



@interface AdViewMessageObject : NSObject

@property (nonatomic, assign) actionType type;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy)  NSString *h5Url;
@property (nonatomic, assign) BOOL canClick;
@end

NS_INLINE AdViewMessageObject * MakeAdViewObject(NSString *imgUrl, NSString *imgName,NSString *h5Url ,actionType type,BOOL canClick ) {
    
    AdViewMessageObject *object = [AdViewMessageObject new];
    object.imgUrl   = imgUrl;
    object.imgName = imgName;
    object.h5Url  = h5Url;
    object.type = type;
    object.canClick = canClick;
    return object;
}

@interface LYZAdView : BaseMessageView

@end
