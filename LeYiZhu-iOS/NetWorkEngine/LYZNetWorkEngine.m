//
//  LYZNetWorkEngine.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/28.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "LYZNetWorkEngine.h"
#import "LYZNetWorkEngine+ErrorCode.h"
#import "LoginManager.h"

@interface LYZNetWorkEngine ()
{
    IIAPIManager *_manager;
}
@end

@implementation LYZNetWorkEngine


+(LYZNetWorkEngine*)sharedInstance
{
    static LYZNetWorkEngine* m_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_instance = [[[self class] alloc] init];
    });
    return m_instance;
}

-(id)init{
    self = [super init];
    if (self) {
        server = [AFHTTPSessionManager manager];
        NSSet* set = server.responseSerializer.acceptableContentTypes;
        set = [set setByAddingObject:@"text/plain"];
        set = [set setByAddingObject:@"text/json"];
        server.responseSerializer.acceptableContentTypes = set;
        _manager = [[IIAPIManager alloc] init];
    }
    return self;
}


#pragma mark - 根据基本信息创建并返回一个可以外部设值的SDK支持的传入型参数对象

+ (id)requestFromRequestClass:(Class)ReqClass
{
    id req = [[ReqClass alloc] init:[LoginManager instance].token];
    return req;
}

#pragma mark ---- Request

-(void)userLogin:(NSString*)phone password:(NSString *)psw versioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString *)fromtype block:(EventCallBack)block
{
    UserLoginRequest * req = LYZNetworkEngine_newRequestByRequestClass([UserLoginRequest class]);
    req.phone = phone;
    req.password = psw;
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager userLogin:req success:^(AFHTTPRequestOperation *operation, UserLoginResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

- (void)userLogin:(NSString *)phone varCode:(NSString *)varcode versioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString *)fromtype block:(EventCallBack)block
{

     UserLoginByMobileRequest* req = LYZNetworkEngine_newRequestByRequestClass([UserLoginByMobileRequest class]);
    req.phone = phone;
    req.captcha =varcode;
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInfoControl";
    req.headMethod = @"loginByCaptcha";
    
    [_manager userLoginByCache:req success:^(AFHTTPRequestOperation *operation, UseLoginBycache *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         block(0,error);
    }];

}

-(void)userGetCaptcha:(NSString *)phone versioncode:(NSString*)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype block:(EventCallBack)block
{
        RegisterCaptchaRequest * req = LYZNetworkEngine_newRequestByRequestClass([RegisterCaptchaRequest class]);
        req.phone = phone;
        req.versioncode = versioncode;
        req.devicenum = devicenum;
        req.fromtype = fromtype;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    
    [_manager userGetCaptcha:req success:^(AFHTTPRequestOperation *operation, RegisterCaptchaResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}


-(void)userRegisterPhone:(NSString*)phone captcha:(NSString*)captcha password:(NSString*)psw versioncode:(NSString*)versioncode devicenum:(NSString*)devicenum fromtype:(NSString*)fromtype block:(EventCallBack)block
{
    UserRegisterRequest * req = LYZNetworkEngine_newRequestByRequestClass([UserRegisterRequest class]);
    req.phone = phone;
    req.captcha = captcha;
    req.password = psw;
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager userRegister:req success:^(AFHTTPRequestOperation *operation, UserRigisterResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)userLogoutAppUserID:(NSString*)appUserId versioncode:(NSString*)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype block:(EventCallBack)block{
    UserLogoutRequest * req = LYZNetworkEngine_newRequestByRequestClass([UserLogoutRequest class]);
    req.appUserID = appUserId;
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInfoTokenControl";
    req.headMethod = @"logout";
    
    [_manager userLogout:req success:^(AFHTTPRequestOperation *operation, UserLogoutResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)userResetPswWithPhone:(NSString*)phone password:(NSString*)password captcha:(NSString*)captcha devicenum:(NSString*)devicenum fromtype:(NSString*)fromtype block:(EventCallBack)block{
    UserResetPswRequest * req = LYZNetworkEngine_newRequestByRequestClass([UserResetPswRequest class]);
    req.phone = phone;
    req.password = password;
    req.captcha = captcha;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager userResetPsw:req success:^(AFHTTPRequestOperation *operation, UserResetPswResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];

}


-(void)getCityDataWithVersioncode:(NSString *)versioncode devicenum:(NSString*)devicenum fromtype:(NSString *)fromtype block:(EventCallBack)block{
    GetCityDataRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetCityDataRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager getUserCityData:req success:^(AFHTTPRequestOperation *operation, GetCityDataResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}


-(void)searchForHotelsWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype cityId:(NSString *)cityId city_name:(NSString*)city_name minprice:(NSString *)minprice maxprice:(NSString*)maxprice type:(NSString *)type longitude:(NSString*)longitude latitude:(NSString *)latitude limit:(NSString *)limit pages:(NSString*)pages block:(EventCallBack)block{
    
    SearchForHotelsRequest * req = LYZNetworkEngine_newRequestByRequestClass([SearchForHotelsRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.city_id = cityId;
    req.city_name = city_name;
    req.minprice = minprice;
    req.maxprice = maxprice;
    req.type = type;
    req.longitude = longitude;
    req.latitude = latitude;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager searchForHotel:req success:^(AFHTTPRequestOperation *operation, SearchForHotelsResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getHotelDetailWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString*)hotelID longitude:(NSString *)longitude latitude:(NSString *)latitude appUserId:(NSString *)appUserId checkInTime:(NSString *)checkInTime checkOutTime:(NSString *)checkOutTime block:(EventCallBack)block{
    GetHotelDetailRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetHotelDetailRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.hotelID = hotelID;
    req.longitude = longitude;
    req.latitude = latitude;
    req.appUserID = appUserId;
    req.checkInTime = checkInTime;
    req.checkOutTime = checkOutTime;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiHotelControl";
    req.headMethod = @"getHotelDetails";
    
    [_manager getHotelDetail:req success:^(AFHTTPRequestOperation *operation, GetHotelDetailResponse *response) {
    [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getHotelCommentWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString *)hotelId limit:(NSString *)limit pages:(NSString *)pages tagid:(NSString *)tagid block:(EventCallBack)block{
    
    GetHotelCommentRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetHotelCommentRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.hotelID = hotelId;
    req.limit = limit;
    req.pages = pages;
    req.tagId = tagid;
    req.headPlatform = @"1";
    req.headTarget = @"apiCommentControl";
    req.headMethod = @"getCommentList";
    
    [_manager getHotelComment:req success:^(AFHTTPRequestOperation *operation, GetHotelCommentResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}
-(void)getHotelCommentWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString *)hotelId limit:(NSString *)limit pages:(NSString *)pages  block:(EventCallBack)block{
    
    GetHotelCommentRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetHotelCommentRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.hotelID = hotelId;
    req.limit = limit;
    req.pages = pages;
    req.headPlatform = @"1";
    req.headTarget = @"apiCommentControl";
    req.headMethod = @"getCommentList";
    
    [_manager getHotelComment:req success:^(AFHTTPRequestOperation *operation, GetHotelCommentResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}


- (void)getHotelCommentTagWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString *)fromtype hotelID:(NSString *)hotelId block:(EventCallBack)block{
    GetCommentTagRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetCommentTagRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.hotelID = hotelId;

    req.headPlatform = @"1";
    req.headTarget = @"apiCommentControl";
    req.headMethod = @"getTags";
    
    [_manager getHotelCommentTag:req success:^(AFHTTPRequestOperation *operation, GetCommentTagResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
    
}

- (void)getHotelCommentUpvodeWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString *)fromtype commentID:(NSString *)commentID block:(EventCallBack)block{
    
    CommentUpvodeRequest * req = LYZNetworkEngine_newRequestByRequestClass([CommentUpvodeRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.commentId = commentID;
    req.headPlatform = @"1";
    req.headTarget = @"apiCommentControl";
    req.headMethod = @"likeComment";
    [_manager getHotelCommentUpvode:req success:^(AFHTTPRequestOperation *operation, CommentUpvodeResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
    
}

- (void)getHotelCommentSkanWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString *)fromtype commentID:(NSString *)commentID block:(EventCallBack)block{
    SkanCommentRequest * req = LYZNetworkEngine_newRequestByRequestClass([SkanCommentRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.commentId = commentID;
    req.headPlatform = @"1";
    req.headTarget = @"apiCommentControl";
    req.headMethod = @"readComment";
    [_manager getHotelCommentSkan:req success:^(AFHTTPRequestOperation *operation, SkanCommentResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
    
}


-(void)getHotelRoomDetailWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype roomID:(NSString *)roomId block:(EventCallBack)block{
    GetHotelRoomDetailsRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetHotelRoomDetailsRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.roomTypeID = roomId;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiHotelControl";
    req.headMethod = @"getHotelRoomDetails";
    
    [_manager getHotelRoomDetail:req success:^(AFHTTPRequestOperation *operation, GetHotelRoomDetailsResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)createAlipayOrderInfoWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype  orderNo:(NSString *)orderNo orderType:(NSString *)orderType block:(EventCallBack)block{
    
    AlipayOrderInfoRequest * req = LYZNetworkEngine_newRequestByRequestClass([AlipayOrderInfoRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.orderNo = orderNo;
    req.orderType = orderType;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiAlipayControl";
    req.headMethod = @"createAlipayOrder";
    
    [_manager createAlipayOrderInfo:req success:^(AFHTTPRequestOperation *operation, AlipayOrderInfoResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)thirdPartLoginWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype thirdID:(NSString *)thirdId type:(NSString *)type nickName:(NSString *)nickName facePath:(NSString *)facePath block:(EventCallBack)block{
    
    ThirdLoginRequest * req = LYZNetworkEngine_newRequestByRequestClass([ThirdLoginRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.thirdID = thirdId;
    req.type = type;
    req.nickName = nickName;
    req.facePath = facePath;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInfoControl";
    req.headMethod = @"loginByThird";
    
    [_manager ThirdLogin:req success:^(AFHTTPRequestOperation *operation, ThirdLoginResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)countMoneyWithRoomTypeID:(NSString *)roomTypeID  payNum:(NSString *)payNum checkInDate:(NSString *)checkInDate checkOutDate:(NSString *)checkOutDate coupondetatilid:(NSString *)coupondetatilid block:(EventCallBack)block{
    CountMoneyRequest * req = LYZNetworkEngine_newRequestByRequestClass([CountMoneyRequest class]);
    req.roomTypeID = roomTypeID;
    req.payNum = payNum;
    req.checkInDate = checkInDate;
    req.checkOutDate = checkOutDate;
    req.coupondetatilid = coupondetatilid;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"computeMoney";
    
    [_manager countMoneyRequest:req success:^(AFHTTPRequestOperation *operation, CountMoneyResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}


-(void)createOrderWithHotelRoomID:(NSString *)hotelRoomId checkInTime:(NSString *)checkInTime checkOutTime:(NSString *)checkOutTime payNum:(NSString *)payNum phone:(NSString *)phone checkIns:(NSArray *)checkIns  invoiceType:(NSString *)invoiceType  invoiceInfo:(NSDictionary *)invoiceInfo isOpenPrivacy:(NSString *)isOpenPrivacy coupondetatilid:(NSString *)coupondetatilid block:(EventCallBack)block{
    CreateOrderRequest * req = LYZNetworkEngine_newRequestByRequestClass([CreateOrderRequest class]);
  
    req.roomTypeID = hotelRoomId;
    req.checkInDate = checkInTime;
    req.checkOutDate = checkOutTime;
    req.checkIns = checkIns;
    req.payNum = payNum;
    req.phone = phone;
    req.invoiceType = invoiceType;
    req.invoiceInfo = invoiceInfo;
    req.isOpenPrivacy = isOpenPrivacy;
    req.coupondetatilid = coupondetatilid;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"createOrder";
    
    [_manager createOrderRequest:req success:^(AFHTTPRequestOperation *operation, CreateOrderResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)createWeChatOrderWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNo:(NSString *)orderNo orderType:(NSString *)orderType block:(EventCallBack)block{
    
    CreateWeChatOrderInfoRequest * req = LYZNetworkEngine_newRequestByRequestClass([CreateWeChatOrderInfoRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.orderNo = orderNo;
    req.orderType = orderType;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiWeiXinControl";
    req.headMethod = @"createWeChatOrder";
    

    [_manager createWeChatOrderInfo:req success:^(AFHTTPRequestOperation *operation, CreateWeChatOrderResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getOrderDetailWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNo:(NSString *)orderNo orderType:(NSString *)orderType block:(EventCallBack)block{
    
    GetOrderDetailRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetOrderDetailRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.orderNO = orderNo;
    req.orderType = orderType;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"getOrderDetail";
    
    [_manager GetOrderDetails:req success:^(AFHTTPRequestOperation *operation, GetOrderDetailResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)searchForOrderWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    
    SearchForOrdersRequest * req = LYZNetworkEngine_newRequestByRequestClass([SearchForOrdersRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager SearchForOrders:req success:^(AFHTTPRequestOperation *operation, SearchForOrdersResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];

}

-(void)cancelOrderWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNo:(NSString *)orderNo block:(EventCallBack)block{

    CancelOrderRequest * req = LYZNetworkEngine_newRequestByRequestClass([CancelOrderRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.orderNo = orderNo;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"recallOrder";
    
    [_manager CancelOrder:req success:^(AFHTTPRequestOperation *operation, CancelOrderResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)checkOutWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNo:(NSString *)orderNo block:(EventCallBack)block{
    
    CheckOutRequest * req = LYZNetworkEngine_newRequestByRequestClass([CheckOutRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.orderNo = orderNo;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager checkOut:req success:^(AFHTTPRequestOperation *operation, CheckOutResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getProblemListWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    
    GetProblemListRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetProblemListRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getProblemList";
    
    [_manager  getProblemList:req success:^(AFHTTPRequestOperation *operation, GetProblemListResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
    
}


-(void)getContactsListWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    
    GetContactsListRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetContactsListRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserContactControl";
    req.headMethod = @"getContactsList";
    
    [_manager getContactsList:req success:^(AFHTTPRequestOperation *operation, GetContactsListResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
    
}

-(void)createContactsWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserId name:(NSString *)name paperworkType:(NSNumber *)paperworkType paperworkNum:(NSString *)paperworkNum sex:(NSString *)sex phone:(NSString *)phone block:(EventCallBack)block{
    
    CreateContactsRequest * req = LYZNetworkEngine_newRequestByRequestClass([CreateContactsRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserId;
    req.name = name;
    req.phone = phone;
    req.paperworkType = paperworkType;
    req.paperworkNum = paperworkNum;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserContactControl";
    req.headMethod = @"createContact";
    
    [_manager createContacts:req success:^(AFHTTPRequestOperation *operation, CreateContactsResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
    
}


-(void)updateContactsWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype contactID:(NSString *)contactId name:(NSString *)name paperworkType:(NSNumber *)paperworkType paperworkNum:(NSString *)paperworkNum sex:(NSString *)sex phone:(NSString *)phone block:(EventCallBack)block{

    UpdateContactsRequest * req = LYZNetworkEngine_newRequestByRequestClass([UpdateContactsRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.contactID = contactId;
    req.name = name;
    req.phone = phone;
    req.paperworkType = paperworkType;
    req.paperworkNum = paperworkNum;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserContactControl";
    req.headMethod = @"updateContact";
    
    [_manager updateContacts:req success:^(AFHTTPRequestOperation *operation, UpdateContactsResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
}

-(void)getFavoriteListWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{

    getUserFavoriteListRequest * req = LYZNetworkEngine_newRequestByRequestClass([getUserFavoriteListRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserFavoriteControl";
    req.headMethod = @"getUserFavoriteList";
    
    [_manager getFavoriteList:req success:^(AFHTTPRequestOperation *operation, getUserFavoriteListResponse *response) {
          [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
    
}

-(void)updateFavoriteWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID hotelID:(NSString *)hotelId block:(EventCallBack)block{

    UpdateUserFavoriteRequest * req = LYZNetworkEngine_newRequestByRequestClass([UpdateUserFavoriteRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.hotelID = hotelId;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserFavoriteControl";
    req.headMethod = @"updateUserFavorite";
    
    [_manager updateUserFavorite:req success:^(AFHTTPRequestOperation *operation, UpdateUserFavoriteResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
    
}

-(void)updatePhoneWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID phone:(NSString *)phone captcha:(NSString *)captcha block:(EventCallBack)block{

    UpdatePhoneRequest * req = LYZNetworkEngine_newRequestByRequestClass([UpdatePhoneRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.phone = phone;
    req.captcha = captcha;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInfoTokenControl";
    req.headMethod = @"updatePhone";
    
    
    [_manager updatePhone:req success:^(AFHTTPRequestOperation *operation, UpdatePhoneResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
    
}


-(void)getUserCouponListWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    
    GetUserCouponListRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetUserCouponListRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager getUserCouponList:req success:^(AFHTTPRequestOperation *operation, GetUserCouponListResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];

}

-(void)updatePasswordWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID oldPsw:(NSString *)oldpsw npsw:(NSString *)npsw  block:(EventCallBack)block{
    
    UpdatePswRequest * req = LYZNetworkEngine_newRequestByRequestClass([UpdatePswRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.oldPsw = oldpsw;
    req.nPsw = npsw;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager  updatePassword:req success:^(AFHTTPRequestOperation *operation, UpdatePswResponse *response) {
          [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
    
}

-(void)getBannerListWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype sizes:(NSString *)sizes block:(EventCallBack)block{
    GetBannerListsRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetBannerListsRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.sizes  = sizes;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager getBannerList:req success:^(AFHTTPRequestOperation *operation, GetBannerListsResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];

}

-(void)searchForHotelOrCityWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype keywords:(NSString *)keywords longitude:(NSString *)longitude latitude:(NSString *)latitude limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    
    SearchHotelOrCityRequest * req = LYZNetworkEngine_newRequestByRequestClass([SearchHotelOrCityRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.keywords  = keywords;
    req.longitude = longitude;
    req.latitude = latitude;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager searchForHotelOrCity:req success:^(AFHTTPRequestOperation *operation, SearchHotelOrCityResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];

}

-(void)openKey:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype roomID:(NSString *)roomID appUserID:(NSString *)appUserID pactVersion:(NSString *)pactVersion block:(EventCallBack)block{

    OpenKeyRequest * req = LYZNetworkEngine_newRequestByRequestClass([OpenKeyRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.roomID = roomID;
    req.appUserID = appUserID;
    req.pactVersion = pactVersion;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiLockControl";
    req.headMethod = @"openKey";
    
    [_manager openKey:req success:^(AFHTTPRequestOperation *operation, OpenKeyResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
}

-(void)getUserRoomPsdList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{

    GetUserRoomPswListRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetUserRoomPswListRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager getUserRoomPwdList:req success:^(AFHTTPRequestOperation *operation, GetUserRoomPswListResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
    
}

-(void)mergeVisitorOrders:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID phone:(NSString *)phone block:(EventCallBack)block{
    MergeVisitorOrdersRequest * req = LYZNetworkEngine_newRequestByRequestClass([MergeVisitorOrdersRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.phone = phone;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager mergeVisitorOrders:req success:^(AFHTTPRequestOperation *operation, MergeVisitorOrdersResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];

}


-(void)bindPhone:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype phone:(NSString *)phone captcha:(NSString *)captcha thirdID:(NSString *)thirdID type:(NSString *)type nickName:(NSString *)nickName facePath:(NSString *)facePath block:(EventCallBack)block{
    bindByPhoneRequest * req = LYZNetworkEngine_newRequestByRequestClass([bindByPhoneRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.phone = phone;
    req.captcha = captcha;
    req.thirdID = thirdID;
    req.type = type;
    req.nickName = nickName;
    req.facePath = facePath;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInfoControl";
    req.headMethod = @"bindByPhone";
    
    [_manager bindPhone:req success:^(AFHTTPRequestOperation *operation, bindByPhoneResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];

}

-(void)recallOrder:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNO:(NSString *)orderNo orderType:(NSString *)orderType  block:(EventCallBack)block{
    OrderRecallOrderRequest * req = LYZNetworkEngine_newRequestByRequestClass([OrderRecallOrderRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.orderNO = orderNo;
    req.orderType = orderType;
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"recallOrder";
    
    [_manager recallOrder:req success:^(AFHTTPRequestOperation *operation, OrderRecallOrderResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];

}

-(void)deleteOrder:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNO:(NSString *)orderNo orderType:(NSString *)orderType block:(EventCallBack)block{
    DeleteOrederRequest * req = LYZNetworkEngine_newRequestByRequestClass([DeleteOrederRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.orderNO = orderNo;
    req.orderType = orderType;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"deleteOrder";
    
    [_manager deleteOrder:req success:^(AFHTTPRequestOperation *operation, DeleteOrderResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getUserOrder:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID orderStatus:(NSString *)orderStatus limit:(NSString *)limit  pages:(NSString *)pages block:(EventCallBack)block{
    GetUserOrdersRequest * req = LYZNetworkEngine_newRequestByRequestClass([GetUserOrdersRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.orderStatus = orderStatus;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"getUserOrderList";
    
    [_manager getUserOrders:req success:^(AFHTTPRequestOperation *operation, GetUserOrdersResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];

}


-(void)recallPay:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNO:(NSString *)orderNo block:(EventCallBack)block{
    RecallPayRequest * req = LYZNetworkEngine_newRequestByRequestClass([RecallPayRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.orderNO = orderNo;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager recallPay:req success:^(AFHTTPRequestOperation *operation, RecallPayResponse *response) {
          [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
}

- (void)addComment:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString *)fromtype appUserID:(NSString *)appUserID hotelID:(NSString *)hotelID childOrderId:(NSString *)childOrderId orderNO:(NSString *)orderNo comments:(NSString *)comments satisFaction:(NSNumber *)satisFaction images:(NSArray *)images block:(EventCallBack)block{
    AddCommentRequest * req = LYZNetworkEngine_newRequestByRequestClass([AddCommentRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.hotelID = hotelID;
    req.orderNO = orderNo;
    req.comments = comments;
    req.satisFaction = satisFaction;
    req.childOrderId = childOrderId;
    req.images = images;
    req.headPlatform = @"1";
    req.headTarget = @"apiCommentControl";
    req.headMethod = @"addComment";
    
    [_manager addComment:req success:^(AFHTTPRequestOperation *operation, AddCommentResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
    
}

-(void)getOrderTime:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNO:(NSString *)orderNo block:(EventCallBack)block{
    
    GetOrderTimeRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetOrderTimeRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.orderNO = orderNo;
    
    req.headPlatform = @"0";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCaptcha";
    
    [_manager getOrderTime:req success:^(AFHTTPRequestOperation *operation, GetOrderTimeResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];

}

-(void)deleteContact:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype contactID:(NSString *)contactID block:(EventCallBack)block{
    DeleteContactsRequest *req = LYZNetworkEngine_newRequestByRequestClass([DeleteContactsRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.contactsID = contactID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserContactControl";
    req.headMethod = @"deleteContact";
    
    [_manager deleteContact:req success:^(AFHTTPRequestOperation *operation, DeleteContactsResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getStayList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    StayListRequest *req = LYZNetworkEngine_newRequestByRequestClass([StayListRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserStayControl";
    req.headMethod = @"getStayList";
    
    [_manager getUserStay:req success:^(AFHTTPRequestOperation *operation, StayListResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
}

-(void)retreatRoom:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID roomID:(NSString *)roomID  block:(EventCallBack)block{
    RetreatRoomRequest *req = LYZNetworkEngine_newRequestByRequestClass([RetreatRoomRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.roomID = roomID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserStayControl";
    req.headMethod = @"retreatRoom";
    
    [_manager retreatRoom:req success:^(AFHTTPRequestOperation *operation, RetreatRoomResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
}

-(void)getValidRoomAmount:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype checkInTime:(NSString *)checkInTime checkOutTime:(NSString *)checkOutTime hotelRoomID:(NSString *)hotelRoomID block:(EventCallBack)block{
    GetValidRoomAmountRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetValidRoomAmountRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.checkInDate = checkInTime;
    req.checkOutDate = checkOutTime;
    req.roomTypeID = hotelRoomID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiHotelControl";
    req.headMethod = @"getValidRoomAmount";
    
    [_manager getValidRoomAmount:req success:^(AFHTTPRequestOperation *operation, GetValidRoomAmountResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}


-(void)preFillOrderBlock:(EventCallBack)block{
    PreFilledOrderRequest *req = LYZNetworkEngine_newRequestByRequestClass([PreFilledOrderRequest class]);

    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"preFilledOrder";
    
    [_manager preFillOrder:req success:^(AFHTTPRequestOperation *operation, PreFilledOrderResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getRefillLiveUser:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID  orderNO:(NSString *)orderNO orderType:(NSString *)orderType block:(EventCallBack)block{
    GetRefillLiveUserRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetRefillLiveUserRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.orderNO = orderNO;
    req.orderType = orderType;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"getRefillLiveUser";
    
    [_manager getRefillLiveUser:req success:^(AFHTTPRequestOperation *operation, GetRefillLiveUserResponse *response) {
          [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}


-(void)countRefillLiveMoneyWithChildOrderIds:(NSArray *)childOrderIds couponID:(NSString *)couponID block:(EventCallBack)block{
    CountRefillLiveMoneyRequest *req = LYZNetworkEngine_newRequestByRequestClass([CountRefillLiveMoneyRequest class]);
    req.childOrderIds = childOrderIds;
    req.coupondetatilid = couponID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"computeRefillLiveMoney";
    
    [_manager countRefillLiveMoney:req success:^(AFHTTPRequestOperation *operation, CountRefillLiveMoneyResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)commitRefillLiveOrderWithPhone:(NSString *)phone invoiceType:(NSString *)invoiceType invoiceInfo:(NSDictionary *)invoiceInfo childOrderIds:(NSArray *)childOrderIds isOpenPrivacy:(NSString *)isOpenPrivacy couponID:(NSString *)couponID block:(EventCallBack)block{
    
    CommitRefillLiveOrderRequest *req = LYZNetworkEngine_newRequestByRequestClass([CommitRefillLiveOrderRequest class]);
    req.phone = phone;
    req.invoiceType = invoiceType;
    req.invoiceInfo = invoiceInfo;
    req.childOrderIds = childOrderIds;
    req.isOpenPrivacy = isOpenPrivacy;
    req.coupondetatilid = couponID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"refillLive";
    
    [_manager commitRefillLiveOrder:req success:^(AFHTTPRequestOperation *operation, CommitRefillLiveOrderResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}


-(void)getHomeBannerList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype block:(EventCallBack)block{
    GetHomeBannerListRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetHomeBannerListRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiContentControl";
    req.headMethod = @"getBannerList";
    req.relevel = @"xxh";
    [_manager getHomeBannerList:req success:^(AFHTTPRequestOperation *operation, GetHomeBannerListResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getSearchLoad:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype longitude:(NSString *)longitude latitude:(NSString *)latitude block:(EventCallBack)block{
    GetSearchLoadRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetSearchLoadRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.latitude = latitude;
    req.longitude = longitude;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiHotelControl";
    req.headMethod = @"getSearchLoad";
    
    [_manager getSearchLoad:req success:^(AFHTTPRequestOperation *operation, GetSearchLoadResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         block(0,error);
    }];
}

-(void)searchForKeyword:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype longitude:(NSString *)longitude latitude:(NSString *)latitude keywords:(NSString *)keywords limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    SearchForKeywordsRequest *req = LYZNetworkEngine_newRequestByRequestClass([SearchForKeywordsRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.latitude = latitude;
    req.longitude = longitude;
    req.keywords = keywords;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiHotelControl";
    req.headMethod = @"searchForKeywords";
    
    [_manager searchForKeywords:req success:^(AFHTTPRequestOperation *operation, SearchForKeywordsResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getUnpaidOrder:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID block:(EventCallBack)block{
    GetUnpaidOrderRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetUnpaidOrderRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiOrderControl";
    req.headMethod = @"getUnpaidOrder";
    
    [_manager getUnpaidOrder:req success:^(AFHTTPRequestOperation *operation, GetUnpaidOrderResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)changePwd:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID  roomID:(NSString *)roomID block:(EventCallBack)block{
     ChangePwdRequest*req = LYZNetworkEngine_newRequestByRequestClass([ChangePwdRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.roomID = roomID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserStayControl";
    req.headMethod = @"changePwd";
    
    [_manager changePsw:req success:^(AFHTTPRequestOperation *operation, ChangePwdResponse *response) { 
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)versionisOpenGripe:(NSString *)isOpenGripe isforce:(NSString*)isforce version:(NSString *)version  block:(EventCallBack)block{
    VersionGripeRequest*req = LYZNetworkEngine_newRequestByRequestClass([VersionGripeRequest class]);
    req.isOpenGripe = isOpenGripe;
    req.isforce = isforce;
    req.appversioncode = version;
    req.headPlatform = @"0";
    req.headTarget = @"versionControl";
    req.headMethod = @"iosVersionGripe";
    NSLog(@"[-----------]%@",req);
    [_manager versionGripe:req success:^(AFHTTPRequestOperation *operation, VersionGripeResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getHotelRoomTypeList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString *)hotelID checkInDate:(NSString *)checkInDate checkOutDate:(NSString *)checkOutDate block:(EventCallBack)block{
    GetHotelRoomTypeListRequest*req = LYZNetworkEngine_newRequestByRequestClass([GetHotelRoomTypeListRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.hotelID = hotelID;
    req.checkInDate = checkInDate;
    req.checkOutDate = checkOutDate;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiHotelControl";
    req.headMethod = @"getHotelRoomTypeList";
    
    [_manager GetHotelRoomTypeList:req success:^(AFHTTPRequestOperation *operation, GetHotelRoomTypeListResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)feedback:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID content:(NSString *)content block:(EventCallBack)block{
    FeedbackRequest*req = LYZNetworkEngine_newRequestByRequestClass([FeedbackRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.content = content;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"feedback";
    
    [_manager feedback:req success:^(AFHTTPRequestOperation *operation, FeedbackResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)openCabinet:(NSString *)cabinetID cabtype:(NSString *)cabtype opentype:(NSString*)opentype latticeid:(NSString *)latticeid norm:(NSString *)norm block:(EventCallBack)block{
    OpenCabinetRequest*req = LYZNetworkEngine_newRequestByRequestClass([OpenCabinetRequest class]);
   
    req.cabinetID = cabinetID;
    req.cabinetType = cabtype;
    req.opentype = opentype;
    req.latticeid = latticeid;
    req.norm = norm;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiCabTokenControl";
    req.headMethod = @"openCab";
    
    [_manager openCabinet:req success:^(AFHTTPRequestOperation *operation, OpenCabinetResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0, error);
    }];
}

-(void)getHotelIntro:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString *)hotelID appUserID:(NSString *)appUserID block:(EventCallBack)block{
    GetHotelIntroRequest*req = LYZNetworkEngine_newRequestByRequestClass([GetHotelIntroRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.hotelID = hotelID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiHotelControl";
    req.headMethod = @"getHotelIntro";
    
    [_manager getHotelIntro:req success:^(AFHTTPRequestOperation *operation, GetHotelIntroResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getInvoiceLookupList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID isNeedData:(NSString *)isNeedData limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    GetInvoiceLookupListRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetInvoiceLookupListRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.isNeedData = isNeedData;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInvoiceControl";
    req.headMethod = @"getInvoiceLookupList";
    
    [_manager getInvoiceLookupList:req success:^(AFHTTPRequestOperation *operation, GetInvoiceLookupListResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)editInvoiceLookup:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID lookUpID:(NSString *)lookUpID type:(NSNumber *)type lookUP:(NSString *)lookUp taxNumber:(NSString *)taxNumber block:(EventCallBack)block{
    EditInvoiceLookupRequest *req = LYZNetworkEngine_newRequestByRequestClass([EditInvoiceLookupRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.lookupID = lookUpID;
    req.type = type;
    req.lookUp = lookUp;
    req.taxNumber = taxNumber;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInvoiceControl";
    req.headMethod = @"editInvoiceLookup";
    
    [_manager editInvoiceLookup:req success:^(AFHTTPRequestOperation *operation, EditInvoiceLookupResponse *response) {
          [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         block(0,error);
    }];
}

-(void)delInvoiceLookup:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID lookUpID:(NSString *)lookUpID block:(EventCallBack)block{
    DelInvoiceLookupRequest *req = LYZNetworkEngine_newRequestByRequestClass([DelInvoiceLookupRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.lookupID = lookUpID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInvoiceControl";
    req.headMethod = @"delInvoiceLookup";

    [_manager deleteInvoiceLookup:req success:^(AFHTTPRequestOperation *operation, DelInvoiceLookupResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}


-(void)getInvoiceAddressList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID isNeedData:(NSString *)isNeedData limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    GetInvoiceAddressListRequset *req = LYZNetworkEngine_newRequestByRequestClass([GetInvoiceAddressListRequset class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.isNeedData = isNeedData;
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInvoiceControl";
    req.headMethod = @"getInvoiceAddressList";
    
    [_manager getInvoiceAddressList:req success:^(AFHTTPRequestOperation *operation, GetInvoiceAddressListResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)editInvoiceAddress:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID invoiceAddressId:(NSString *)invoiceAddressId recipient:(NSString *)recipient phone:(NSString *)phone province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address block:(EventCallBack)block{
    EditInvoiceAddressRequest *req = LYZNetworkEngine_newRequestByRequestClass([EditInvoiceAddressRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.invoiceAddressID = invoiceAddressId;
    req.recipient = recipient;
    req.phone = phone;
    req.province = province;
    req.city = city;
    req.area = area;
    req.address = address;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInvoiceControl";
    req.headMethod = @"editInvoiceAddress";
    
    [_manager editInvoiceAddress:req success:^(AFHTTPRequestOperation *operation, EditInvoiceAddressResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)delelteInvoiceAddress:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID invoiceAddressID:(NSString *)invoiceAddressID block:(EventCallBack)block{
    DelInvoiceAddressRequest *req = LYZNetworkEngine_newRequestByRequestClass([DelInvoiceAddressRequest class]);
    req.versioncode = versioncode;
    req.devicenum = devicenum;
    req.fromtype = fromtype;
    req.appUserID = appUserID;
    req.invoiceAddressID = invoiceAddressID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInvoiceControl";
    req.headMethod = @"delInvoiceAddress";
    
    [_manager delInvoiceAddress:req success:^(AFHTTPRequestOperation *operation, DelInvoiceAddressResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}
-(void)getCouponListWithCouponStatus:(NSString *)couponStatus staymoneysum:(NSString *)staymoneysum limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    
    GetCouponListRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetCouponListRequest class]);
    req.limit = limit;
    req.pages = pages;
    req.couponstatus = couponStatus;
    req.roomprice = staymoneysum;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserCouponControl";
    req.headMethod = @"getCouponList";
    
    [_manager getCouponList:req success:^(AFHTTPRequestOperation *operation, GetCouponListResponse *response) {
          [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         block(0,error);
    }];

}

-(void)getMineInfoBlock:(EventCallBack)block{
    MineInfoRequest *req = LYZNetworkEngine_newRequestByRequestClass([MineInfoRequest class]);
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInfoTokenControl";
    req.headMethod = @"mineinfo";
    
    [_manager getMineInfo:req success:^(AFHTTPRequestOperation *operation, MineInfoResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getVipLevelList:(EventCallBack)block{
    GetVIPLevelListRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetVIPLevelListRequest class]);
    req.headPlatform = @"1";
    req.headTarget = @"apiVIPControl";
    req.headMethod = @"getVIPLevel";
    
    [_manager getVipLevelList:req success:^(AFHTTPRequestOperation *operation, GetVIPLevelListResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         block(0,error);
    }];
}

-(void)applyVip:(NSString *)name idCard:(NSString *)idNum email:(NSString *)email inviteCode:(NSString *)inviteCode block:(EventCallBack)block{
    ApplyVipRequest *req = LYZNetworkEngine_newRequestByRequestClass([ApplyVipRequest class]);
    req.username = name;
    req.idcard = idNum;
    req.email = email;
    req.invitecode = inviteCode;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiVIPControl";
    req.headMethod = @"apply";
    
    [_manager applyVip:req success:^(AFHTTPRequestOperation *operation, ApplyVipResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}


-(void)detectUserStayblock:(EventCallBack)block{
    DetectUserStayRequest *req = LYZNetworkEngine_newRequestByRequestClass([DetectUserStayRequest class]);
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserStayControl";
    req.headMethod = @"detectUserStay";
    
    [_manager detectUserStay:req success:^(AFHTTPRequestOperation *operation, DetectUserStayResponse *response) {
        [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)confirmJPushWithPushID:(NSString *)pushID block:(EventCallBack)block{
    
    ConfirmJPushRequest *req = LYZNetworkEngine_newRequestByRequestClass([ConfirmJPushRequest class]);
    req.jpushlogid = pushID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiJpushControl";
    req.headMethod = @"defineJpush";
    
    [_manager confirmJPush:req success:^(AFHTTPRequestOperation *operation, ConfirmJPushResponse *response) {
          [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         block(0,error);
    }];
}

-(void)updateUserInfo:(NSString *)nickname facepath:(NSString *)facepath block:(EventCallBack)block{
    UpdateUserInfoRequest *req = LYZNetworkEngine_newRequestByRequestClass([UpdateUserInfoRequest class]);
    req.nickname = nickname;
    req.facepath = facepath;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInfoTokenControl";
    req.headMethod = @"updateUserInfo";
    
    [_manager updateUserInfo:req success:^(AFHTTPRequestOperation *operation, UpdateUserInfoResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         block(0,error);
    }];
}

-(void)getCabinetInfo:(NSString *)cabinetNo cabinetType:(NSString *)cabinetType block:(EventCallBack)block{
    
    GetCabinetInfoRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetCabinetInfoRequest class]);
    req.cabinetNO = cabinetNo;
    req.cabinetType = cabinetType;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiCabTokenControl";
    req.headMethod = @"getCabinetInfo";
    
    [_manager getCabinetInfo:req success:^(AFHTTPRequestOperation *operation, GetCabinetInfoResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
    
}

-(void)userSignblock:(EventCallBack)block{
    UserSignRequest *req = LYZNetworkEngine_newRequestByRequestClass([UserSignRequest class]);
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInfoTokenControl";
    req.headMethod = @"sign";
    
    [_manager userSign:req success:^(AFHTTPRequestOperation *operation, UserSignResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)exchangeCouponWithCode:(NSString *)code block:(EventCallBack)block{
    
    ExchangeCouponRequest *req = LYZNetworkEngine_newRequestByRequestClass([ExchangeCouponRequest class]);
    req.code = code;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserCouponControl";
    req.headMethod = @"exchangeCoupon";
    
    [_manager exchangeCoupon:req success:^(AFHTTPRequestOperation *operation, ExchangeCouponResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}
-(void)getRoomPriceWithCheckInDate:(NSString *)checkInDate checkOutDate:(NSString *)checkOutDate roomTypeID:(NSString *)roomTypeID block:(EventCallBack)block{
    GetRoomPriceRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetRoomPriceRequest class]);
    req.checkInDate = checkInDate;
    req.checkOutDate = checkOutDate;
    req.roomTypeID = roomTypeID;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiHotelControl";
    req.headMethod = @"getRoomPrice";
    NSLog(@"%@",req);
    [_manager getRoomPrice:req success:^(AFHTTPRequestOperation *operation, GetRoomPriceResponse *response) {
          [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

-(void)getCopyWritingWithType:(NSNumber *)type block:(EventCallBack)block{
    GetCopywritingRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetCopywritingRequest class]);
    req.type = type;
   
    req.headPlatform = @"1";
    req.headTarget = @"apiCommonControl";
    req.headMethod = @"getCopywriting";
    
    [_manager getCopyWriting:req success:^(AFHTTPRequestOperation *operation, GetCopywritingResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         block(0,error);
    }];
}

-(void)getPointsRecord:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block{
    GetPointsRecordRequest *req = LYZNetworkEngine_newRequestByRequestClass([GetPointsRecordRequest class]);
    req.limit = limit;
    req.pages = pages;
    
    req.headPlatform = @"1";
    req.headTarget = @"apiUserInfoTokenControl";
    req.headMethod = @"getPointsRecord";
    
    [_manager getPointsRecord:req success:^(AFHTTPRequestOperation *operation, GetPointsRecordResponse *response) {
         [LYZNetWorkEngine networkWithResponse:response block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];
}

@end
