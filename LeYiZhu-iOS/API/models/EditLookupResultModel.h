//
//  EditLookupResultModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface EditLookupResultModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *lookUpID;

@end
