//
//  LYZNetWorkEngine+ErrorCode.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "LYZNetWorkEngine+ErrorCode.h"
#import "LoginManager.h"

@implementation LYZNetWorkEngine (ErrorCode)

+ (NSString *)netErrCodeStringFromResponse:(AbstractResponse *)response
{
    NSString * msg = nil;
    if (![response returncode] || [[response returncode] isEqual:[NSNull null]]) {
        return msg;
    }
    //特殊错误处理
    
    if (![[response returncode] isEqualToString:@"01"]) {
        //1.系统错误 2.授权 3.参数
        switch ([[response returncode] integerValue]) {
            case 1:
            case 3:
                break;
            case 2:
                break;
            default:
                break;
        }
    }else {//4.5 submsg
        msg = [response msg];
    }
    return msg;
    
}

+ (void)networkWithResponse:(AbstractResponse *)response block:(EventCallBack)block
{
//    NSString *msg = [LYZNetWorkEngine netErrCodeStringFromResponse:response];
    if (response.returncode) {
        if(block) {
            
            if ([response.returncode isEqualToString:@"01"]) {
                block(1,response);
            }
            else if ([response.returncode isEqualToString:@"08"]){
                block(8,response);
            }
            else if ([response.returncode isEqualToString:@"09"]){
                block(9,response);
            }
            else if ([response.returncode isEqualToString:@"02"]){
                //空数据
                block(2,response);
            }
            else if ([response.returncode isEqualToString:@"15"]){
                //有用户待支付订单
                block(15, response);
            }else if ([response.returncode isEqualToString:@"100"]){
                //房间数量不足
                block(100, response);
            }else if ([response.returncode isEqualToString:@"10003"]){
                //token 失效
                [[LoginManager instance] logout];
                [[LoginManager instance] userLogin];

                block(10003, response);
            }else{
                block(0,[response msg]);
            }
        }
    }else{
        block(1,response);
    }
}


@end
