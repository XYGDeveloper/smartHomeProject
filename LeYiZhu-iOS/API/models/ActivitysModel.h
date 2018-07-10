//
//  ActivitysModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ActivitysModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *activitysID;

@property (nonatomic, readonly, copy) NSString *imgpath;

@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, readonly, copy) NSString *scope;

@property (nonatomic, readonly, copy) NSString *subtitle;

@property (nonatomic, readonly, copy) NSString *pubtime;

@property (nonatomic, readonly, copy) NSString *url;


@end
