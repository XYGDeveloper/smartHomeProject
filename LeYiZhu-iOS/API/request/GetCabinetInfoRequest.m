//
//  GetCabinetInfoRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetCabinetInfoRequest.h"
#import "GetCabinetInfoResponse.h"

@implementation GetCabinetInfoRequest

- (NSMutableDictionary *) getHeaders{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters{
    
    [self.queryParameters setValue:self.cabinetNO forKey:@"cabinetNO"];
    [self.queryParameters setValue:self.cabinetType forKey:@"cabinetType"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters{
    
    return self.pathParameters;
}

- (Class) getResponseClazz{
    
    return [GetCabinetInfoResponse class];
}



@end
