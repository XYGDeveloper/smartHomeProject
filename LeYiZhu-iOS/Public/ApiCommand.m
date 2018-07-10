//
//  ApiCommand.m
//  Qqw
//
//  Created by zagger on 16/8/18.
//  Copyright © 2016年 gao.jian. All rights reserved.
//

#import "ApiCommand.h"

@implementation ApiCommand

+ (instancetype)defaultApiCommand {
    ApiCommand *command = [[ApiCommand alloc] init];
    command.method = QQWRequestMethodPost;
    command.timeoutInterval = 30;
    
    return command;
}


+ (instancetype)getApiCommand {
    ApiCommand *command = [[ApiCommand alloc] init];
    command.method = QQWRequestMethodGet;
//    [command.task.currentRequest.allHTTPHeaderFields setValue:[User LocalUser].cookieString forKey:@"Set-Cookie"];
    command.timeoutInterval = 30;

    return command;
    
}

+ (NSString *)requestURLWithRelativePath:(NSString *)relativePath {
    if ([relativePath hasPrefix:@"/"]) {
        return [NSString stringWithFormat:@"%@", relativePath];
    } else {
        return [NSString stringWithFormat:@"%@", relativePath];
    }
}



@end
