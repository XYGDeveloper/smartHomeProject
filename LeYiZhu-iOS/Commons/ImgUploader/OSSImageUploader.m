

#import "OSSImageUploader.h"
#import <AliyunOSSiOS/OSSService.h>



@implementation OSSImageUploader
static NSString *const AccessKey = @"STS.CAkBEtS3Gu4TNUuEnp7r8zYmY";
static NSString *const SecretKey = @"EiRLFbsW2Fm632GwfTDGy7i9j9VnbjWWBfuwq8rP8WQ";
static NSString *const BucketName = @"lyz-service";
static NSString *const AliYunHost = @"http://oss-cn-shenzhen.aliyuncs.com";

static NSString *kTempFolder = @"smart_lyz/";





+ (void)asyncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete
{
    
    [self uploadImages:@[image] isAsync:YES complete:complete];
    
}

+ (void)syncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete
{
    [self uploadImages:@[image] isAsync:NO complete:complete];
    
}

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images
                   access:(NSString *)accessid
                   secreat:(NSString *)secreat
                     host:(NSString *)host
              secutyToken:(NSString *)secutyToken
                 buckName:(NSString *)buckName
                 complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    
    [self uploadImages:images access:accessid secreat:secreat host:host secutyToken:secutyToken buckName:buckName isAsync:YES complete:complete];
    
}

+ (void)syncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    [self uploadImages:images isAsync:NO complete:complete];
}

+ (void)uploadImages:(NSArray<UIImage *> *)images

             isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey                                                                                                            secretKey:SecretKey];
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:AliYunHost credentialProvider:credential];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = images.count;
    
    NSMutableArray *callBackNames = [NSMutableArray array];
    int i = 0;
    for (UIImage *image in images) {
        if (image) {
            
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                //任务执行
                OSSPutObjectRequest * put = [OSSPutObjectRequest new];
                put.bucketName = BucketName;
                NSString *imageName = [kTempFolder stringByAppendingPathComponent:[[NSUUID UUID].UUIDString stringByAppendingString:@".jpg"]];
                put.objectKey = imageName;
                [callBackNames addObject:imageName];
                NSData *data = UIImageJPEGRepresentation(image, 1.0);
                put.uploadingData = data;
                
                OSSTask * putTask = [client putObject:put];
                [putTask waitUntilFinished]; // 阻塞直到上传完成
                if (!putTask.error) {
                    NSLog(@"upload object success!");
                } else {
                    NSLog(@"upload object failed, error: %@" , putTask.error);
                }
                if (isAsync) {
                    if (image == images.lastObject) {
                        NSLog(@"upload object finished!");
                        if (complete) {
                            complete([NSArray arrayWithArray:callBackNames] ,UploadImageSuccess);
                        }
                    }
                }
            }];
            if (queue.operations.count != 0) {
                [operation addDependency:queue.operations.lastObject];
            }
            [queue addOperation:operation];
        }
        i++;
    }
    if (!isAsync) {
        [queue waitUntilAllOperationsAreFinished];
        NSLog(@"haha");
        if (complete) {
            if (complete) {
                complete([NSArray arrayWithArray:callBackNames], UploadImageSuccess);
            }
        }
    }
}

+ (void)uploadImages:(NSArray<UIImage *> *)images
              access:(NSString *)accessid
             secreat:(NSString *)secreat
                host:(NSString *)host
         secutyToken:(NSString *)secutyToken
            buckName:(NSString *)buckName
             isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:accessid  secretKeyId:secreat  securityToken:secutyToken];
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:[NSString stringWithFormat:@"http://%@",host] credentialProvider:credential];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    queue.maxConcurrentOperationCount = images.count;
    
    NSMutableArray *callBackNames = [NSMutableArray array];
    int i = 0;
    for (UIImage *image in images) {
        if (image) {
            
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                //任务执行
                OSSPutObjectRequest * put = [OSSPutObjectRequest new];
                put.bucketName = buckName;
                NSString *imageName = [kTempFolder stringByAppendingPathComponent:[[NSUUID UUID].UUIDString stringByAppendingString:@".jpg"]];
                put.objectKey = imageName;
                [callBackNames addObject:imageName];
                NSData *data = UIImageJPEGRepresentation(image, 1.0);
                put.uploadingData = data;
                put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
                    // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
                    NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
                };
                OSSTask * putTask = [client putObject:put];
                [putTask waitUntilFinished]; // 阻塞直到上传完成
                if (!putTask.error) {
                    NSLog(@"upload object success!");
                } else {
                    NSLog(@"upload object failed, error: %@" , putTask.error);
                }
                if (isAsync) {
                    if (image == images.lastObject) {
                        NSLog(@"upload object finished!");
                        if (complete) {
                            complete([NSArray arrayWithArray:callBackNames] ,UploadImageSuccess);
                        }
                    }
                }
            }];
            if (queue.operations.count != 0) {
                [operation addDependency:queue.operations.lastObject];
            }
            [queue addOperation:operation];
        }
        i++;
    }
    if (!isAsync) {
        [queue waitUntilAllOperationsAreFinished];
        NSLog(@"haha");
        if (complete) {
            if (complete) {
                complete([NSArray arrayWithArray:callBackNames], UploadImageSuccess);
            }
        }
    }
}



@end
