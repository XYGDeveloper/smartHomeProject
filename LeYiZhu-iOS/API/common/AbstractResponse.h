//
//  AbstractResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-19.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "mantle.h"


@interface AbstractResponse :  MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, copy) NSString *returncode;
@property (nonatomic, readonly, copy) NSString * msg;

@end
