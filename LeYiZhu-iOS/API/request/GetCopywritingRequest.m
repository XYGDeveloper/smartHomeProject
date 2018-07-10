//
//  GetCopywritingRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetCopywritingRequest.h"
#import "GetCopywritingResponse.h"

@implementation GetCopywritingRequest

- (NSMutableDictionary *) getHeaders{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters{
    
    [self.queryParameters setValue:self.type forKey:@"type"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters{
    
    return self.pathParameters;
}

- (Class) getResponseClazz{
    
    return [GetCopywritingResponse class];
}



@end
