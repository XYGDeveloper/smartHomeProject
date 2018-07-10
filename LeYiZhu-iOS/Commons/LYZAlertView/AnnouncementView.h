//
//  AnnouncementView.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/4.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "BaseMessageView.h"

@interface AnnoucementViewObject : NSObject

@property (nonatomic, copy) NSString                         *annoucement;

@end

NS_INLINE AnnoucementViewObject * MakeAnnoucementViewObject(NSString *annoucement) {
    
    AnnoucementViewObject *object = [AnnoucementViewObject new];
    object.annoucement                 = annoucement;
    return object;
}


@interface AnnouncementView : BaseMessageView

@end
