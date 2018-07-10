//
//  GetPointsRecordRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetPointsRecordRequest.h"
#import "GetPointsRecordResponse.h"

@implementation GetPointsRecordRequest

- (NSMutableDictionary *) getHeaders{
    
    return self.headers;
}

- (NSMutableDictionary *)getQueryParameters{
    
    [self.queryParameters setValue:self.limit forKey:@"limit"];
     [self.queryParameters setValue:self.pages forKey:@"pages"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters{
    
    return self.pathParameters;
}

- (Class) getResponseClazz{
    
    return [GetPointsRecordResponse class];
}


@end
