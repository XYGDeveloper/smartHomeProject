//
//  CommentUpvodeRequest.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "CommentUpvodeRequest.h"
#import "CommentUpvodeResponse.h"
@implementation CommentUpvodeRequest


- (NSMutableDictionary *) getHeaders{
    
    return self.headers;
}

- (NSMutableDictionary *)getQueryParameters{
    [self.queryParameters setValue:self.fromtype forKey:@"fromtype"];
    [self.queryParameters setValue:self.versioncode forKey:@"versioncode"];
    [self.queryParameters setValue:self.devicenum forKey:@"devicenum"];
    [self.queryParameters setValue:self.commentId forKey:@"commentId"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters{
    
    return self.pathParameters;
}

- (Class) getResponseClazz{
    
    return [CommentUpvodeResponse class];
}

@end
