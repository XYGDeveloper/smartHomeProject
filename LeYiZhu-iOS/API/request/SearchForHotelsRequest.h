//
//  SearchForHotelsRequest.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/1.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface SearchForHotelsRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property(nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *city_id;

@property (nonatomic, copy) NSString *city_name;

@property (nonatomic, copy) NSString *minprice;

@property (nonatomic, copy) NSString *maxprice;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *limit;

@property (nonatomic, copy) NSString *pages;

@end
