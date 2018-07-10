//
//  RetreatRoomRequest.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/2/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface RetreatRoomRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *appUserID;

@property (nonatomic, copy) NSString *roomID;








@end
