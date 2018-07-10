//
//  LYZImaageUploaderManager.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYZImaageUploaderManager : NSObject

+(void)uploadImgs:(NSArray <UIImage *>* )img withResult:(void (^)(id imgs))result;

@end
