//
//  LYZAPI.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/11/28.
//  Copyright © 2016年 lyz. All rights reserved.
//

#ifndef LYZAPI_h
#define LYZAPI_h

//对外接口
#define Search_Rootrenative @"smartlyz-search-api/v1/api/search"
//内部接口
#define Normal_Rootrenative @"smartlyz-api/v2/api/entrance"

//#define LYZ_PREFIX     @"https://api.smarthome168.com"//测试
//#define UpdateURL @"https://api.smarthome168.com/smartlyz-search-api/api/app/version/iosVersionGripe" //升级测试
#define LYZ_PREFIX     @"https://api.smartlyz.com"//线上
#define UpdateURL @"https://api.smartlyz.com/smartlyz-search-api/api/app/version/iosVersionGripe" //升级线上

#define LYZ_PREFIX_Normal       [NSString stringWithFormat:@"%@/%@",LYZ_PREFIX,Normal_Rootrenative]
#define LYZ_PREFIX_Search       [NSString stringWithFormat:@"%@/%@",LYZ_PREFIX,Search_Rootrenative]
#define LYZ_REGISTER   @"appuser/register"


#define LYZ_LOGIN      @"appuser/loginByPhone"

#define LYZ_LoginByCache @"appuser/loginByCaptcha"

#define LYZ_CAPTCHA    @"common/getCaptcha"

#define LYZ_RESET_PSW  @"appuser/resetPassword"

#define LYZ_LOGOUT     @"appuser/logout"

#define LYZ_CITY       @"city/getCityData"

#define LYZ_SEARCH_HOTEL  @"hotel/searchForHotels"

#define LYZ_HOTEL_DETAIL @"hotel/getHotelDetails"

#define LYZ_HOTEL_COMMENT @"content/getCommentList"

#define LYZ_HOTEL_ROOM_DETAIL @"hotel/getHotelRoomDetails"

#define LYZ_ALIPAY_ORDER  @"alipay/createAlipayOrder"

#define LYZ_WECHAT_ORDER @"wechat/createWeChatOrder"

#define LYZ_CREATE_ORDER  @"order/createOrder"

#define LYZ_THIRD_LOGIN  @"appuser/loginByThird"

#define LYZ_COUNTMONEY  @"order/computeMoney"

#define LYZ_ORDER_DETAIL  @"order/getOrderDetail"

#define LYZ_SEARCH_ORDER  @"order/searchForOrders"

#define LYZ_CANCEL_ORDER   @"order/cancelOrder"

#define LYZ_CHECKOUT  @"order/checkOutRoom"

#define LYZ_GET_PROBLEM  @"common/getProblemList"

#define LYZ_GET_CONTACTSLIST @"contacts/getContactsList"

#define LYZ_CREATE_CONTACTS @"contacts/createContacts"

#define LYZ_UPDATE_CONTACTS @"contacts/updateContacts"

#define LYZ_USER_FAVORITE  @"appuserFavorite/getUserFavoriteList"

#define LYZ_UPDATE_FAVORITE @"appuserFavorite/updateUserFavorite"

#define LYZ_UPDATE_PHONE @"appuser/updatePhone"

#define LYZ_USER_COUPONLIST @"order/getUserCouponList"

#define LYZ_UPDATE_PSW @"appuser/updatePassword"

#define  LYZ_GET_BANNER @"content/getBannerList"

#define LYZ_SEARCH_HOTELORCITY @"hotel/searchForHotelOrCity"

#define LYZ_OPEN_KEY @"lock/openKey"

#define LYZ_GET_ROOMPSW @"appuser/getUserRoomPwdList"

#define LYZ_MERGE_ORDERS @"order/mergeVisitorOrders"

#define LYZ_BIND_PHONE @"appuser/bindByPhone"

#define LYZ_RECALL_ORDER @"order/recallOrder"

#define LYZ_DELETE_ORDER @"order/deleteOrder"

#define LYZ_RECALL_PAY @"order/recallPay"

#define LYZ_USER_ORDERS   @"order/getUserOrderList"

#define LYZ_ADD_COMMENT @"content/addComment"

#define LYZ_ORDER_TIME @"order/getOrderTime"

#define LYZ_DELETE_CONTACTS @"contacts/deleteContacts"

#define LYZ_STAY_LIST @"stay/getStayList"

#define LYZ_RETREAT_ROOM @"stay/retreatRoom"

#define LYZ_ROOM_AMOUNT  @"hotel/getValidRoomAmount"

#define LYZ_ORDER_PREFILL @"order/preFilledOrder"

#define LYZ_REFILL_USER @"order/getRefillLiveUser"

#define LYZ_COUNTREFILL_MONEY  @"order/computeRefillLiveMoney"

#define LYZ_REFILLORDER_COMMIT @"order/refillLive"

#define LYZ_BANNER_LIST @"content/getBannerList"

#define LYZ_SEARCH_LOAD @"hotel/getSearchLoad"

#define LYZ_SEARCHBY_KEY @"hotel/searchForKeywords"

#define LYZ_UNPAID_ORDER @"order/getUnpaidOrder"

#define LYZ_CHANGE_PSW @"stay/changePwd"

#define LYZ_VERSION_GRIPE @"app/version/iosVersionGripe"

#define LYZ_HOTELROOMTYPE_LIST @"hotel/getHotelRoomTypeList"

#define LYZ_FEED_BACK @"common/feedback"

#define LYZ_OPEN_CABINET @"client/cab/openCabinet"

#define LYZ_HOTEL_INTRO  @"hotel/getHotelIntro"

#define LYZ_TITLE_LIST  @"invoice/getInvoiceLookupList"

#define LYZ_EDIT_LOOKUP @"invoice/editInvoiceLookup"

#define LYZ_DELETE_LOOKUP @"invoice/delInvoiceLookup"

#define LYZ_INVOICEADDRESS_LIST @"invoice/getInvoiceAddressList"

#define LYZ_EDIT_INVOICEADDRESS @"invoice/editInvoiceAddress"

#define LYZ_DELETE_INVOICEADDRESS @"invoice/delInvoiceAddress"

#define LYZ_COUPON_LIST @"user/coupon/getCouponList"

#define LYZ_MINE_INFO @"appuser/mineinfo"

#define LYZ_VIPLEVEL_LIST @"vip/getVIPLevelList"

#define LYZ_APPLY_VIP @"vip/apply"

#define LYZ_DETECT_USERSTAY   @"stay/detectUserStay"

#define LYZ_JPUSH_CONFIRM  @"thirdparty/jpush/defineJpush"

#endif /* LYZAPI_h */
