//
//  OpenCabinetRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "OpenCabinetRequest.h"
#import "OpenCabinetResponse.h"

@implementation OpenCabinetRequest

- (NSMutableDictionary *) getHeaders
{
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
    [self.queryParameters setValue:self.cabinetID forKey:@"id"];
    [self.queryParameters setValue:self.cabinetType forKey:@"cabtype"];
    [self.queryParameters setValue:self.opentype forKey:@"opentype"];
    [self.queryParameters setValue:self.latticeid forKey:@"latticeid"];
    [self.queryParameters setValue:self.norm forKey:@"norm"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    return self.pathParameters;
}

- (Class) getResponseClazz
{
    return [OpenCabinetResponse class];
}

//- (NSString *) getApiUrl
//{
//    return [NSString stringWithFormat:@"%@%@",LYZ_PREFIX,LYZ_OPEN_CABINET];
//}


@end
