//
//  LYZNetWorkEngine+ErrorCode.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "LYZNetWorkEngine.h"

@interface LYZNetWorkEngine (ErrorCode)

/*! 对于返回的response，统一过滤可能的错误提示信息
 */
+ (void)networkWithResponse:(AbstractResponse *)response block:(EventCallBack)block;

@end
