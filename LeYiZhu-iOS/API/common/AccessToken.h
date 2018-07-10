//
//  AccessToken.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "AbstractResponse.h"

@interface AccessToken : AbstractResponse
@property (nonatomic, readonly, copy) NSString *accessToken;
@property (nonatomic, readonly, copy) NSString *tokenType;
@property (nonatomic, readonly, copy) NSNumber *expiresIn;
@property (nonatomic, readonly, copy) NSString *refreshToken;
@property (nonatomic, readonly, copy) NSString *scope;



@end
