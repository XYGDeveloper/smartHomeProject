//
//  LYZNetWorkEngine.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/28.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IIAPIManager.h"
@interface LYZNetWorkEngine : NSObject
{
    AFHTTPSessionManager *server;//预留
}

//快速生成request对象的宏，实际是调用的方法： + (id)requestFromRequestClass:(Class)ReqClass
#define LYZNetworkEngine_newRequestByRequestClass(RequestClass)   [LYZNetWorkEngine requestFromRequestClass:RequestClass]

+ (id)requestFromRequestClass:(Class)ReqClass;

+(LYZNetWorkEngine*)sharedInstance;

#pragma mark -- 登录注册
#pragma mark --- 用户登录
-(void)userLogin:(NSString*)phone password:(NSString *)psw versioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString *)fromtype block:(EventCallBack)block;//废弃

#pragma mark ---手机号登录
-(void)userLogin:(NSString*)phone varCode:(NSString *)varcode versioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString *)fromtype block:(EventCallBack)block;


#pragma mark -- 获取验证码
-(void)userGetCaptcha:(NSString *)phone versioncode:(NSString*)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype block:(EventCallBack)block;

#pragma mark -- 用户注册
-(void)userRegisterPhone:(NSString*)phone captcha:(NSString*)captcha password:(NSString*)psw versioncode:(NSString*)versioncode devicenum:(NSString*)devicenum fromtype:(NSString*)fromtype block:(EventCallBack)block; //废弃

#pragma mark -- 用户登出
-(void)userLogoutAppUserID:(NSString*)appUserId versioncode:(NSString*)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype block:(EventCallBack)block;

#pragma mark -- 用户重置密码
-(void)userResetPswWithPhone:(NSString*)phone password:(NSString*)password captcha:(NSString*)captcha devicenum:(NSString*)devicenum fromtype:(NSString*)fromtype block:(EventCallBack)block;//废弃

#pragma mark -- 地址选择
-(void)getCityDataWithVersioncode:(NSString *)versioncode devicenum:(NSString*)devicenum fromtype:(NSString *)fromtype block:(EventCallBack)block;//废弃

-(void)searchForHotelsWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype cityId:(NSString *)cityId city_name:(NSString*)city_name minprice:(NSString *)minprice maxprice:(NSString*)maxprice type:(NSString *)type longitude:(NSString*)longitude latitude:(NSString *)latitude limit:(NSString *)limit pages:(NSString*)pages block:(EventCallBack)block;// 废弃

-(void)getHotelDetailWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString*)hotelID longitude:(NSString *)longitude latitude:(NSString *)latitude appUserId:(NSString *)appUserId checkInTime:(NSString *)checkInTime checkOutTime:(NSString *)checkOutTime block:(EventCallBack)block;

-(void)getHotelCommentWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString *)hotelId limit:(NSString *)limit pages:(NSString *)pages tagid:(NSString *)tagid block:(EventCallBack)block;
-(void)getHotelCommentWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString *)hotelId limit:(NSString *)limit pages:(NSString *)pages  block:(EventCallBack)block;
-(void)getHotelCommentTagWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString *)hotelId block:(EventCallBack)block;

-(void)getHotelCommentUpvodeWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype commentID:(NSString *)commentID block:(EventCallBack)block;
-(void)getHotelCommentSkanWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype commentID:(NSString *)commentID block:(EventCallBack)block;

-(void)getHotelRoomDetailWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype roomID:(NSString *)roomId block:(EventCallBack)block;

#pragma mark -- 订单详情 支付
//创建支付宝订单
-(void)createAlipayOrderInfoWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype  orderNo:(NSString *)orderNo orderType:(NSString *)orderType block:(EventCallBack)block;

-(void)thirdPartLoginWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype thirdID:(NSString *)thirdId type:(NSString *)type nickName:(NSString *)nickName facePath:(NSString *)facePath block:(EventCallBack)block;

//计算金额
-(void)countMoneyWithRoomTypeID:(NSString *)roomTypeID  payNum:(NSString *)payNum checkInDate:(NSString *)checkInDate checkOutDate:(NSString *)checkOutDate coupondetatilid:(NSString *)coupondetatilid block:(EventCallBack)block;

//创建订单
-(void)createOrderWithHotelRoomID:(NSString *)hotelRoomId checkInTime:(NSString *)checkInTime checkOutTime:(NSString *)checkOutTime payNum:(NSString *)payNum phone:(NSString *)phone checkIns:(NSArray *)checkIns  invoiceType:(NSString *)invoiceType  invoiceInfo:(NSDictionary *)invoiceInfo isOpenPrivacy:(NSString *)isOpenPrivacy coupondetatilid:(NSString *)coupondetatilid block:(EventCallBack)block;

//微信订单
-(void)createWeChatOrderWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNo:(NSString *)orderNo orderType:(NSString *)orderType block:(EventCallBack)block;

//获取订单详情
-(void)getOrderDetailWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNo:(NSString *)orderNo orderType:(NSString *)orderType block:(EventCallBack)block;

-(void)searchForOrderWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block; // 废弃

//取消订单
-(void)cancelOrderWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNo:(NSString *)orderNo block:(EventCallBack)block;

//全部退房
-(void)checkOutWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNo:(NSString *)orderNo block:(EventCallBack)block;//废弃

//常见问题列表
-(void)getProblemListWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

-(void)getContactsListWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

-(void)createContactsWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserId name:(NSString *)name paperworkType:(NSNumber *)paperworkType paperworkNum:(NSString *)paperworkNum sex:(NSString *)sex phone:(NSString *)phone block:(EventCallBack)block;

-(void)updateContactsWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype contactID:(NSString *)contactId name:(NSString *)name paperworkType:(NSNumber *)paperworkType paperworkNum:(NSString *)paperworkNum sex:(NSString *)sex phone:(NSString *)phone block:(EventCallBack)block;

//收藏
-(void)getFavoriteListWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

//取消收藏
-(void)updateFavoriteWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID hotelID:(NSString *)hotelId block:(EventCallBack)block;

//修改手机号
-(void)updatePhoneWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID phone:(NSString *)phone captcha:(NSString *)captcha block:(EventCallBack)block;

//优惠券列表
-(void)getUserCouponListWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

//29 修改密码
-(void)updatePasswordWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID oldPsw:(NSString *)oldpsw npsw:(NSString *)npsw  block:(EventCallBack)block;

// 31 获取Banner列表
-(void)getBannerListWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype sizes:(NSString *)sizes block:(EventCallBack)block;

//30 检索房间或城市列表
-(void)searchForHotelOrCityWithVersioncode:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype keywords:(NSString *)keywords longitude:(NSString *)longitude latitude:(NSString *)latitude limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

//32 房间开锁
-(void)openKey:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype roomID:(NSString *)roomID appUserID:(NSString *)appUserID pactVersion:(NSString *)pactVersion block:(EventCallBack)block;

//33 获取房间密码列表
-(void)getUserRoomPsdList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;


//34 合并游离订单
-(void)mergeVisitorOrders:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID phone:(NSString *)phone block:(EventCallBack)block;

//35 绑定手机
-(void)bindPhone:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype phone:(NSString *)phone captcha:(NSString *)captcha thirdID:(NSString *)thirdID type:(NSString *)type nickName:(NSString *)nickName facePath:(NSString *)facePath block:(EventCallBack)block;

//36 取消订单
-(void)recallOrder:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNO:(NSString *)orderNo orderType:(NSString *)orderType block:(EventCallBack)block;

//37 删除订单

-(void)deleteOrder:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNO:(NSString *)orderNo orderType:(NSString *)orderType block:(EventCallBack)block;

//38 获取订单（新）

-(void)getUserOrder:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID orderStatus:(NSString *)orderStatus limit:(NSString *)limit  pages:(NSString *)pages block:(EventCallBack)block;

//39 取消支付

-(void)recallPay:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNO:(NSString *)orderNo block:(EventCallBack)block; //废弃

//40 添加评论

-(void)addComment:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString*)appUserID hotelID:(NSString *)hotelID childOrderId:(NSString *)childOrderId orderNO:(NSString *)orderNo comments:(NSString *)comments satisFaction:(NSNumber *)satisFaction images:(NSArray *)images block:(EventCallBack)block;

//41 订单时间
-(void)getOrderTime:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype orderNO:(NSString *)orderNo block:(EventCallBack)block; //废弃

//42 删除常用联系人
-(void)deleteContact:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype contactID:(NSString *)contactID block:(EventCallBack)block;

//43 获取用户住宿计划列表

-(void)getStayList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

//单独退房
-(void)retreatRoom:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID roomID:(NSString *)roomID  block:(EventCallBack)block;

//获取可预订房间数

-(void)getValidRoomAmount:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype checkInTime:(NSString *)checkInTime checkOutTime:(NSString *)checkOutTime hotelRoomID:(NSString *)hotelRoohotelRoomID block:(EventCallBack)block;

//预填写订单
-(void)preFillOrderBlock:(EventCallBack)block;

//获取可续住人员
-(void)getRefillLiveUser:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID  orderNO:(NSString *)orderNO orderType:(NSString *)orderType block:(EventCallBack)block;

//计算续住订单金额
-(void)countRefillLiveMoneyWithChildOrderIds:(NSArray *)childOrderIds couponID:(NSString *)couponID block:(EventCallBack)block;

//提交续住订单
-(void)commitRefillLiveOrderWithPhone:(NSString *)phone invoiceType:(NSString *)invoiceType invoiceInfo:(NSDictionary *)invoiceInfo childOrderIds:(NSArray *)childOrderIds isOpenPrivacy:(NSString *)isOpenPrivacy couponID:(NSString *)couponID block:(EventCallBack)block;

//首页banner列表
-(void)getHomeBannerList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype block:(EventCallBack)block;

//检索初始加载数据
-(void)getSearchLoad:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype longitude:(NSString *)longitude latitude:(NSString *)latitude block:(EventCallBack)block;

//根据关键字检索酒店列表
-(void)searchForKeyword:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype longitude:(NSString *)longitude latitude:(NSString *)latitude keywords:(NSString *)keywords limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

//获取用户待支付订单
-(void)getUnpaidOrder:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID block:(EventCallBack)block;

//更换密码
-(void)changePwd:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID  roomID:(NSString *)roomID block:(EventCallBack)block;

//检测是否需要升级
-(void)versionisOpenGripe:(NSString *)isOpenGripe isforce:(NSString*)isforce version:(NSString *)version  block:(EventCallBack)block;

//获取酒店房型列表
-(void)getHotelRoomTypeList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString *)hotelID checkInDate:(NSString *)checkInDate checkOutDate:(NSString *)checkOutDate block:(EventCallBack)block;

//意见反馈

-(void)feedback:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID content:(NSString *)content block:(EventCallBack)block;

//用户开柜
-(void)openCabinet:(NSString *)cabinetID cabtype:(NSString *)cabtype opentype:(NSString*)opentype latticeid:(NSString *)latticeid norm:(NSString *)norm block:(EventCallBack)block;

//获取酒店介绍
-(void)getHotelIntro:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype hotelID:(NSString *)hotelID appUserID:(NSString *)appUserID block:(EventCallBack)block;

//获取发票常用抬头
-(void)getInvoiceLookupList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID isNeedData:(NSString *)isNeedData limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

//新增、修改发票常用抬头
-(void)editInvoiceLookup:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID lookUpID:(NSString *)lookUpID type:(NSNumber *)type lookUP:(NSString *)lookUp taxNumber:(NSString *)taxNumber block:(EventCallBack)block;

//删除常用发票抬头
-(void)delInvoiceLookup:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID lookUpID:(NSString *)lookUpID block:(EventCallBack)block;

//获取发票常用地址列表
-(void)getInvoiceAddressList:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID isNeedData:(NSString *)isNeedData limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

//新增/修改发票常用地址
-(void)editInvoiceAddress:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID invoiceAddressId:(NSString *)invoiceAddressId recipient:(NSString *)recipient phone:(NSString *)phone province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address block:(EventCallBack)block;

//删除发票常用地址
-(void)delelteInvoiceAddress:(NSString *)versioncode devicenum:(NSString *)devicenum fromtype:(NSString*)fromtype appUserID:(NSString *)appUserID invoiceAddressID:(NSString *)invoiceAddressID block:(EventCallBack)block;

//获取用户优惠券列表
-(void)getCouponListWithCouponStatus:(NSString *)couponStatus staymoneysum:(NSString *)staymoneysum limit:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

//我的信息
-(void)getMineInfoBlock:(EventCallBack)block;

//获取会员卡列表
-(void)getVipLevelList:(EventCallBack)block;

//申请会员
-(void)applyVip:(NSString *)name idCard:(NSString *)idNum email:(NSString *)email inviteCode:(NSString *)inviteCode block:(EventCallBack)block;

//启动时候检测用户是否有入住信息
-(void)detectUserStayblock:(EventCallBack)block;

//确认收到波形码推送
-(void)confirmJPushWithPushID:(NSString *)pushID block:(EventCallBack)block;

//修改用户信息
-(void)updateUserInfo:(NSString *)nickname facepath:(NSString *)facepath block:(EventCallBack)block;

//获取柜格信息
-(void)getCabinetInfo:(NSString *)cabinetNo cabinetType:(NSString *)cabinetType block:(EventCallBack)block;

//用户签到
-(void)userSignblock:(EventCallBack)block;

//优惠券兑换
-(void)exchangeCouponWithCode:(NSString *)code block:(EventCallBack)block;

//获取房型价格
-(void)getRoomPriceWithCheckInDate:(NSString *)checkInDate checkOutDate:(NSString *)checkOutDate roomTypeID:(NSString *)roomTypeID block:(EventCallBack)block;

//获取文案
-(void)getCopyWritingWithType:(NSNumber *)type block:(EventCallBack)block;

//获取用户积分流水列表

-(void)getPointsRecord:(NSString *)limit pages:(NSString *)pages block:(EventCallBack)block;

@end
