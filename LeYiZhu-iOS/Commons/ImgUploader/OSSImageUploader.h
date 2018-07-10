

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UploadImageState) {
    UploadImageFailed   = 0,
    UploadImageSuccess  = 1
};

@interface OSSImageUploader : NSObject

+ (void)asyncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete;

+ (void)syncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete;

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images
                   access:(NSString *)accessid
                  secreat:(NSString *)secreat
                     host:(NSString *)host
                     secutyToken:(NSString *)secutyToken
                 buckName:(NSString *)buckName
                 complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete;

+ (void)syncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete;

@end
