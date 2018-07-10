//
//  LYZVersionManager.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZVersionManager.h"
#import <AFNetworking.h>

@implementation LYZVersionManager

+ (instancetype)instance
{
    static LYZVersionManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYZVersionManager alloc] init];
    });
    return manager;
}

+(NSString *)getCurrentVersion{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDic));
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}


- (void)checkUpdateWithAppID:(NSString *)appID success:(void (^)(NSDictionary *resultDic , BOOL isNewVersion , NSString * newVersion))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *encodingUrl=[[@"http://itunes.apple.com/cn/lookup?id=" stringByAppendingString:appID] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:encodingUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * serverVersion = [[[resultDic objectForKey:@"results"] objectAtIndex:0] valueForKey:@"version"];
        NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
        NSString *localVersion = [infoDic valueForKey:@"CFBundleShortVersionString"];
        //将版本号按照.切割后存入数组中
        NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
        NSArray *appArray = [serverVersion componentsSeparatedByString:@"."];
        NSLog(@"%@ \n%@",serverVersion,localVersion);
        NSInteger minArrayLength = MIN(localArray.count, appArray.count);
        BOOL needUpdate = NO;
        for(int i=0;i<minArrayLength;i++){//以最短的数组长度为遍历次数,防止数组越界
            //取出每个部分的字符串值,比较数值大小
            NSString *localElement = localArray[i];
            NSString *appElement = appArray[i];
            NSInteger  localValue =  localElement.integerValue;
            NSInteger  appValue = appElement.integerValue;
            if(localValue<appValue) {
                //从前往后比较数字大小,一旦分出大小,跳出循环
                needUpdate = YES;
                break;
            }else{
                needUpdate = NO;
            }
        }
        success(resultDic,needUpdate ,serverVersion);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

-(void)checkUpdateByLocateServer:(void (^) (BOOL allowUpdate , NSString *isforce))result{
    
    NSString * systemVersion = [UIDevice currentDevice].systemVersion;//10.0.2

    [[LYZNetWorkEngine sharedInstance] versionisOpenGripe:@"" isforce:@"" version:systemVersion block:^(int event, id object) {
        if (event == 1) {
            VersionGripeResponse *response = (VersionGripeResponse *)object;
            NSDictionary *dic = response.result;
            NSNumber *allow  = [dic objectForKey:@"isOpenGripe"];
            NSString *isforceUpdate = [dic objectForKey:@"isforce"];
            BOOL isupdateVersion;
            if (allow.integerValue == 0) {
                isupdateVersion = NO;
            }else{
                isupdateVersion = YES;
            }
            NSLog(@"----------------%@,%@",[dic objectForKey:@"isOpenGripe"],isforceUpdate);
            result(isupdateVersion, isforceUpdate);
        }else{
            LYLog(@" error ---> %@",object);
        }
    }];
    
   
}

@end
