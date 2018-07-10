//
//  LYZImaageUploaderManager.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZImaageUploaderManager.h"
#import "OSSImageUploader.h"
#import <AFNetworking.h>
#define workOrder_picOss      @"http://120.77.63.37:8080/smartlyz-api/api/apiOssCommon/getOssServiceSign"  //图片鉴权

@implementation LYZImaageUploaderManager

+(void)uploadImgs:(NSArray <UIImage *>* )img withResult:(void (^)(id imgs))result{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/JavaScript" ,nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"platform"];
    [manager.requestSerializer setValue:@"apiOssCommonControl" forHTTPHeaderField:@"target"];
    [manager.requestSerializer setValue:@"getOssSign" forHTTPHeaderField:@"method"];
    [ manager.requestSerializer setValue:VersionCode forHTTPHeaderField:@"versioncode"];
    [ manager.requestSerializer setValue:DeviceNum forHTTPHeaderField:@"devicenum"];
    [ manager.requestSerializer setValue:FromType forHTTPHeaderField:@"fromtype"];
    [manager POST:LYZ_PREFIX_Search parameters:@{} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
     NSDictionary *dic = [responseObject objectForKey:@"data"];
        [OSSImageUploader asyncUploadImages:img access:[dic objectForKey:@"accessKeyId"] secreat:[dic objectForKey:@"accessKeySecret"] host:[dic objectForKey:@"endpoint"] secutyToken:[dic objectForKey:@"securityToken"] buckName:[dic objectForKey:@"bucket"] complete:^(NSArray<NSString *> *names, UploadImageState state) {
            if (state == UploadImageSuccess) {
                NSMutableArray *temp = [NSMutableArray array];
                for (NSString *str in names) {
                    NSString *imgURLStr = [NSString stringWithFormat:@"http://%@.%@%@",[dic objectForKey:@"bucket" ],@"oss-cn-shenzhen.aliyuncs.com/",str];
                    [temp addObject:imgURLStr];
                }
                NSArray *imgURLStrs = [NSArray arrayWithArray:temp];
                result(imgURLStrs);
            }else{
                result(0);
            }
        }];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        result(0);
    }];
   
   

//
}

@end
