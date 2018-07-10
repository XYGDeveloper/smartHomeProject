//
//  GetRoomPriceRequest.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "GetRoomPriceRequest.h"
#import "GetRoomPriceResponse.h"

@implementation GetRoomPriceRequest

- (NSMutableDictionary *) getHeaders{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters{
    
    [self.queryParameters setValue:self.checkInDate forKey:@"checkInDate"];
     [self.queryParameters setValue:self.checkOutDate forKey:@"checkOutDate"];
     [self.queryParameters setValue:self.roomTypeID forKey:@"roomTypeID"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters{
    
    return self.pathParameters;
}

- (Class) getResponseClazz{
    
    return [GetRoomPriceResponse class];
}



@end
