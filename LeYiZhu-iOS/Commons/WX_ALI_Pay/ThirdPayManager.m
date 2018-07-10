//
//  ThirdPayManager.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "ThirdPayManager.h"
#import "WeChatOrderModel.h"
#import "SecurityUtil.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "Public+JGHUD.h"
#import "AppDelegate.h"

@implementation ThirdPayManager

+ (instancetype)instance
{
    static ThirdPayManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ThirdPayManager alloc] init];
    });
    return manager;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
       
    }
    return self;
    
}



//create zhifubao order
- (void)createAliOrder:(NSString *)orderNO orderType:(NSString *)orderType
{
  
//    NSString *notifyurl_alipay = @"http://120.77.69.104:8080/leyizhu/api/order/receive_notify";
    NSString *orderNo = orderNO;
    //先生成订单
    
    [[LYZNetWorkEngine sharedInstance] createAlipayOrderInfoWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType orderNo:orderNo orderType:(NSString *)orderType block:^(int event, id object) {
        if(event == 1){
            AlipayOrderInfoResponse *orderInfoResponse = (AlipayOrderInfoResponse*)object;
            //            AlipayOrderModel *alipayModel = orderInfoResponse.alipayOrder;
            //            NSString *orderNo = alipayModel.orderNo;
            //            NSString *orderInfo = alipayModel.orderInfo;
            NSString * result = [SecurityUtil decryptAESStringFromBase64:orderInfoResponse.alipayOrder app_key:@"smart@LYZ0000000"];
            NSData *jsondata = [result dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:nil];
            NSString *orderInfo = [dic objectForKey:@"orderInfo"];
            NSString *orderNO =  [dic objectForKey:@"orderNO"];
            NSNumber *orderType = [dic objectForKey:@"orderType"];
            
            LYLog(@"orderInfoResponse:%@",orderInfo);
            
            //支付宝支付接口
            [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:Scheme callback:^(NSDictionary *resultDic) {
                
                LYLog(@"resultDic : %@" , resultDic);
            }];
            
            
        }else{
            LYLog(@"orderInfoResponse failure :%@" , object);
            AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            UIWindow *keyWindow  = delegate.window;
            [Public showJGHUDWhenError:keyWindow msg:object];
        }
    }];
    
    //    NSString *order = @"";
    //    NSString *scheme = Scheme;
    //    NSString *alipayAppID = @"2016112803463933";
    
    
}

- (void)weixinRequest:(NSString *)orderNo orderType:(NSString *)orderType
{
    //生成微信支付相关信息
    [[LYZNetWorkEngine sharedInstance] createWeChatOrderWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType orderNo:orderNo orderType:orderType block:^(int event, id object) {
        
        if(event == 1){
            
            LYLog(@"weixinRequest success!");
            
            CreateWeChatOrderResponse *weixinOrderResponse = (CreateWeChatOrderResponse*)object;
            NSString *weixinOrder = weixinOrderResponse.weChatOrder;
            LYLog(@"weixinOrder : %@" , weixinOrder);
            NSString * result = [SecurityUtil decryptAESStringFromBase64:weixinOrderResponse.weChatOrder app_key:@"smart@LYZ0000000"];
            NSData *jsondata = [result dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:nil];
            WeChatOrderModel * model = [MTLJSONAdapter modelOfClass:[WeChatOrderModel class]     fromJSONDictionary:dic error:nil];
            LYLog(@" the model is  -----> %@",model);
            [self weixin:model];
            
        }else{
            AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            UIWindow *keyWindow  = delegate.window;
            [Public showJGHUDWhenError:keyWindow msg:object];
        }
    }];
}

- (void)weixin:(WeChatOrderModel *)weixinOrder
{
    NSString *appid = weixinOrder.appid;
    NSString *partnerid = weixinOrder.partnerid;
    NSString *packageStr = weixinOrder.packageStr;
    NSString *orderNo = weixinOrder.orderNo;
    NSString *noncestr = weixinOrder.noncestr;
    NSString *sign = weixinOrder.sign;
    NSString *prepayid = weixinOrder.prepayid;
    NSString *timestamp = weixinOrder.timestamp;
    
    //微信支付
    PayReq *request = [[PayReq alloc] init];
    /** 商家向财付通申请的商家id */
    request.partnerId = partnerid;
    /** 预支付订单 */
    request.prepayId= prepayid;
    /** 商家根据财付通文档填写的数据和签名 */
    request.package = packageStr;
    /** 随机串，防重发 */
    request.nonceStr= noncestr;
    /** 时间戳，防重发 */
    request.timeStamp= timestamp.intValue;
    /** 商家根据微信开放平台文档对数据做的签名 */
    request.sign= sign;
    
    
    /*! @brief 发送请求到微信，等待微信返回onResp
     *
     * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
     * SendAuthReq、SendMessageToWXReq、PayReq等。
     * @param req 具体的发送请求，在调用函数后，请自己释放。
     * @return 成功返回YES，失败返回NO。
     */
    [WXApi sendReq: request];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"微信返回" forKey:@"支付返回"];
}

@end
