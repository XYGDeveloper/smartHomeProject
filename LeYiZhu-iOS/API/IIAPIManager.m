//
//  IIAPIManager.m
//  NexPack
//
//  Created by levo on 15/9/15.
//  Copyright (c) 2015年 noa-labs. All rights reserved.
//

#import "IIAPIManager.h"
#import <Sculptor/Sculptor.h>

@interface IIAPIManager()

@end

@implementation IIAPIManager

-(id)init
{
    self = [super init];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        
        AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        self.securityPolicy = securityPolicy;
    }
    return self;
}

-(void) setAccessTokenHeader:(NSString *) token{
    [self.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [self.requestSerializer setValue:VersionCode forHTTPHeaderField:@"versioncode"];
    [self.requestSerializer setValue:DeviceNum forHTTPHeaderField:@"devicenum"];
    [self.requestSerializer setValue:FromType forHTTPHeaderField:@"fromtype"];
//    [self.requestSerializer setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
}

-(void)setAppendHeader:(NSDictionary *)dic{
    [self.requestSerializer setValue:dic[PLATFORM] forHTTPHeaderField:PLATFORM];
    [self.requestSerializer setValue:dic[TARGET] forHTTPHeaderField:TARGET];
    [self.requestSerializer setValue:dic[METHOD] forHTTPHeaderField:METHOD];
}




-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        NSSet* set = self.responseSerializer.acceptableContentTypes;
        set = [set setByAddingObject:@"text/plain"];
        set = [set setByAddingObject:@"text/json"];
        set = [set setByAddingObject:@"text/html"];
        self.responseSerializer.acceptableContentTypes = set;
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        
        AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        self.securityPolicy = securityPolicy;
    }
    return self;
}

-(void)userGetCaptcha:(RegisterCaptchaRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,RegisterCaptchaResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)userLogin:(UserLoginRequest *)request  success:(void (^)(AFHTTPRequestOperation * operation,UserLoginResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

- (void)userLoginByCache:(UserLoginByMobileRequest *)request success:(void (^)(AFHTTPRequestOperation *, UseLoginBycache *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
    
}

-(void)userRegister:(UserRegisterRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,UserRigisterResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)userLogout:(UserLogoutRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,UserLogoutResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];

}

-(void)userResetPsw:(UserResetPswRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,UserResetPswResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)getUserCityData:(GetCityDataRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetCityDataResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)searchForHotel:(SearchForHotelsRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,SearchForHotelsResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];    
}
//获取酒店详情
-(void)getHotelDetail:(GetHotelDetailRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,GetHotelDetailResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
//获取酒店评论
-(void)getHotelComment:(GetHotelCommentRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetHotelCommentResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
//40.    获取标签对应评论数
- (void)getHotelCommentTag:(GetCommentTagRequest *)request success:(void (^)(AFHTTPRequestOperation *, GetCommentTagResponse *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
    
}

- (void)getHotelCommentUpvode:(CommentUpvodeRequest *)request success:(void (^)(AFHTTPRequestOperation *, CommentUpvodeResponse *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
    
}

- (void)getHotelCommentSkan:(SkanCommentRequest *)request success:(void (^)(AFHTTPRequestOperation *, SkanCommentResponse *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

//获取酒店性情
-(void)getHotelRoomDetail:(GetHotelRoomDetailsRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,GetHotelRoomDetailsResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)createAlipayOrderInfo:(AlipayOrderInfoRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,AlipayOrderInfoResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)ThirdLogin:(ThirdLoginRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,ThirdLoginResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//计算金额
-(void)countMoneyRequest:(CountMoneyRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CountMoneyResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)createOrderRequest:(CreateOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CreateOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)createWeChatOrderInfo:(CreateWeChatOrderInfoRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CreateWeChatOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
    
}
//获取订单详情
-(void)GetOrderDetails:(GetOrderDetailRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetOrderDetailResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];

}


-(void)SearchForOrders:(SearchForOrdersRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,SearchForOrdersResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
    
}

-(void)CancelOrder:(CancelOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CancelOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)checkOut:(CheckOutRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,CheckOutResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
    
}
//获取问题列表
-(void)getProblemList:(GetProblemListRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,GetProblemListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];

}

-(void)createContacts:(CreateContactsRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,CreateContactsResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
    
}

-(void)updateContacts:(UpdateContactsRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,UpdateContactsResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];

}
//6.我的收藏列表(新)
-(void)getFavoriteList:(getUserFavoriteListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,getUserFavoriteListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    NSLog(@"----------------[][][]--------%@",request.getApiUrl);
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
//7.联系人列表
-(void)getContactsList:(GetContactsListRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,GetContactsListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)updateUserFavorite:(UpdateUserFavoriteRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UpdateUserFavoriteResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
  [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
    
}

-(void)updatePhone:(UpdatePhoneRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UpdatePhoneResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
    
}

-(void)getUserCouponList:(GetUserCouponListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetUserCouponListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
  [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];

}

-(void)updatePassword:(UpdatePhoneRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UpdatePswResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];

}
//获取banner列表
-(void)getBannerList:(GetBannerListsRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetBannerListsResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];

}

-(void)searchForHotelOrCity:(SearchHotelOrCityRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,SearchHotelOrCityResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];

}

-(void)openKey:(OpenKeyRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,OpenKeyResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
  [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];

}

-(void)getUserRoomPwdList:(GetUserRoomPswListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetUserRoomPswListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{

    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];

}

-(void)mergeVisitorOrders:(MergeVisitorOrdersRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,MergeVisitorOrdersResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)bindPhone:(bindByPhoneRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,bindByPhoneResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
  [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];

}

-(void)recallOrder:(OrderRecallOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,OrderRecallOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)deleteOrder:(DeleteOrederRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,DeleteOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//获取用户订单列表
-(void)getUserOrders:(GetUserOrdersRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetUserOrdersResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];

}

-(void)recallPay:(RecallPayRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,RecallPayResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)addComment:(AddCommentRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,AddCommentResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)getOrderTime:(GetOrderTimeRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetOrderTimeResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)deleteContact:(DeleteContactsRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,DeleteContactsResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//获取用户住宿计划列表
-(void)getUserStay:(StayListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,StayListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
    
}

-(void)retreatRoom:(RetreatRoomRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,RetreatRoomResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//获取可预定房间数
-(void)getValidRoomAmount:(GetValidRoomAmountRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetValidRoomAmountResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

//预填写订单
-(void)preFillOrder:(PreFilledOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,PreFilledOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

//获取可续住人员
-(void)getRefillLiveUser:(GetRefillLiveUserRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetRefillLiveUserResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
//计算续住订单金额
-(void)countRefillLiveMoney:(CountRefillLiveMoneyRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CountRefillLiveMoneyResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)commitRefillLiveOrder:(CommitRefillLiveOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CommitRefillLiveOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)getHomeBannerList:(GetHomeBannerListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetHomeBannerListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
//检索初始加载
-(void)getSearchLoad:(GetSearchLoadRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetSearchLoadResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
//根据关键字搜索
-(void)searchForKeywords:(SearchForKeywordsRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,SearchForKeywordsResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
// 获取用户待支付订单
-(void)getUnpaidOrder:(GetUnpaidOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetUnpaidOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)changePsw:(ChangePwdRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,ChangePwdResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)versionGripe:(VersionGripeRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,VersionGripeResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
//     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//获取酒店房型列表
-(void)GetHotelRoomTypeList:(GetHotelRoomTypeListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetHotelRoomTypeListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)feedback:(FeedbackRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,FeedbackResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)openCabinet:(OpenCabinetRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,OpenCabinetResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//获取酒店介绍
-(void)getHotelIntro:(GetHotelIntroRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetHotelIntroResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
//28.    获取发票常用抬头列表
-(void)getInvoiceLookupList:(GetInvoiceLookupListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetInvoiceLookupListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)editInvoiceLookup:(EditInvoiceLookupRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,EditInvoiceLookupResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}


-(void)deleteInvoiceLookup:(DelInvoiceLookupRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,DelInvoiceLookupResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//29.    获取发票常用地址列表
-(void)getInvoiceAddressList:(GetInvoiceAddressListRequset *)request success:(void (^)(AFHTTPRequestOperation * operation,GetInvoiceAddressListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)editInvoiceAddress:(EditInvoiceAddressRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,EditInvoiceAddressResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)delInvoiceAddress:(DelInvoiceAddressRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,DelInvoiceAddressResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//30.    获取用户优惠券列表
-(void)getCouponList:(GetCouponListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetCouponListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
      [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

//31.    我的信息接口
-(void)getMineInfo:(MineInfoRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,MineInfoResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
//32.    获取会员卡列表接口
-(void)getVipLevelList:(GetVIPLevelListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetVIPLevelListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)applyVip:(ApplyVipRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,ApplyVipResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//33.    检测用户是否存在住宿计划
-(void)detectUserStay:(DetectUserStayRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,DetectUserStayResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)confirmJPush:(ConfirmJPushRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,ConfirmJPushResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    
    [self setAccessTokenHeader:request.accessToken];
     [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)updateUserInfo:(UpdateUserInfoRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UpdateUserInfoResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//36.    获取柜格信息
-(void)getCabinetInfo:(GetCabinetInfoRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetCabinetInfoResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

-(void)userSign:(UserSignRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UserSignResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void)exchangeCoupon:(ExchangeCouponRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,ExchangeCouponResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//38.    获取房型价格
-(void)getRoomPrice:(GetRoomPriceRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetRoomPriceResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
//39.    获取文案
-(void)getCopyWriting:(GetCopywritingRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetCopywritingResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}
//37.    获取用户积分流水列表
-(void)getPointsRecord:(GetPointsRecordRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetPointsRecordResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure{
    [self setAccessTokenHeader:request.accessToken];
    [self setAppendHeader:request.appendHeadDic];
    self.responseSerializer =  [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:LYZ_PREFIX_Search parameters:request.getQueryParameters success:success failure:failure];
}

@end
