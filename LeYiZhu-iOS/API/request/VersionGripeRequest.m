//
//  LYZVersionGripeRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "VersionGripeRequest.h"
#import "VersionGripeResponse.h"

@implementation VersionGripeRequest

- (NSMutableDictionary *) getHeaders{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters{
    [self.queryParameters setValue:self.isforce forKey:@"isforce"];
    [self.queryParameters setValue:self.isOpenGripe forKey:@"isOpenGripe"];
    NSString * systemVersion = [UIDevice currentDevice].systemVersion;//10.0.2
    [self.queryParameters setValue:systemVersion forKey:@"appversioncode"];

    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters{
    return self.pathParameters;
}

- (Class) getResponseClazz{
    return [VersionGripeResponse class];
}

- (NSString *) getApiUrl{
    return UpdateURL;
}


@end
