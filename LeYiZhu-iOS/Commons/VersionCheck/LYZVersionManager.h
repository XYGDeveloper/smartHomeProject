//
//  LYZVersionManager.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYZVersionManager : NSObject

+ (instancetype)instance;

- (void)checkUpdateWithAppID:(NSString *)appID success:(void (^)(NSDictionary *resultDic , BOOL isNewVersion , NSString * newVersion))success failure:(void (^)(NSError *error))failure;

-(void)checkUpdateByLocateServer:(void (^) (BOOL allowUpdate , NSString *isforce))result;

@end
