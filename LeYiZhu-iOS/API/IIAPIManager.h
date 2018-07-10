//
//  IIAPIManager.h
//  NexPack
//
//  Created by levo on 15/9/15.
//  Copyright (c) 2015年 noa-labs. All rights reserved.
//

#import "AFNetworking.h"
#import "NPSDK.h"

@interface IIAPIManager : AFHTTPRequestOperationManager

-(id)init;

-(void)userLogin:(UserLoginRequest *)request  success:(void (^)(AFHTTPRequestOperation * operation,UserLoginResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

- (void)userLoginByCache:(UserLoginByMobileRequest *)request success:(void (^)(AFHTTPRequestOperation *, UseLoginBycache *response))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

-(void)userGetCaptcha:(RegisterCaptchaRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,RegisterCaptchaResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)userRegister:(UserRegisterRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,UserRigisterResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)userLogout:(UserLogoutRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,UserLogoutResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)userResetPsw:(UserResetPswRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UserResetPswResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getUserCityData:(GetCityDataRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetCityDataResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)searchForHotel:(SearchForHotelsRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,SearchForHotelsResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getHotelDetail:(GetHotelDetailRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,GetHotelDetailResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getHotelComment:(GetHotelCommentRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetHotelCommentResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;
-(void)getHotelCommentTag:(GetCommentTagRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetCommentTagResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getHotelCommentUpvode:(CommentUpvodeRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CommentUpvodeResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getHotelCommentSkan:(SkanCommentRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,SkanCommentResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getHotelRoomDetail:(GetHotelRoomDetailsRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,GetHotelRoomDetailsResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)createAlipayOrderInfo:(AlipayOrderInfoRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,AlipayOrderInfoResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)ThirdLogin:(ThirdLoginRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,ThirdLoginResponse * response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)countMoneyRequest:(CountMoneyRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CountMoneyResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)createOrderRequest:(CreateOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CreateOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)createWeChatOrderInfo:(CreateWeChatOrderInfoRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CreateWeChatOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)GetOrderDetails:(GetOrderDetailRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetOrderDetailResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)SearchForOrders:(SearchForOrdersRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,SearchForOrdersResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)CancelOrder:(CancelOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CancelOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)checkOut:(CheckOutRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,CheckOutResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getProblemList:(GetProblemListRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,GetProblemListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getContactsList:(GetContactsListRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,GetContactsListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)createContacts:(CreateContactsRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,CreateContactsResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)updateContacts:(UpdateContactsRequest*)request success:(void (^)(AFHTTPRequestOperation * operation,UpdateContactsResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getFavoriteList:(getUserFavoriteListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,getUserFavoriteListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)updateUserFavorite:(UpdateUserFavoriteRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UpdateUserFavoriteResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)updatePhone:(UpdatePhoneRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UpdatePhoneResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getUserCouponList:(GetUserCouponListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetUserCouponListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)updatePassword:(UpdatePswRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UpdatePswResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getBannerList:(GetBannerListsRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetBannerListsResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)searchForHotelOrCity:(SearchHotelOrCityRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,SearchHotelOrCityResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)openKey:(OpenKeyRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,OpenKeyResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getUserRoomPwdList:(GetUserRoomPswListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetUserRoomPswListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)mergeVisitorOrders:(MergeVisitorOrdersRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,MergeVisitorOrdersResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)bindPhone:(bindByPhoneRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,bindByPhoneResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)recallOrder:(OrderRecallOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,OrderRecallOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)deleteOrder:(DeleteOrederRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,DeleteOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getUserOrders:(GetUserOrdersRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetUserOrdersResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)recallPay:(RecallPayRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,RecallPayResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)addComment:(AddCommentRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,AddCommentResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getOrderTime:(GetOrderTimeRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetOrderTimeResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)deleteContact:(DeleteContactsRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,DeleteContactsResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getUserStay:(StayListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,StayListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)retreatRoom:(RetreatRoomRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,RetreatRoomResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getValidRoomAmount:(GetValidRoomAmountRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetValidRoomAmountResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)preFillOrder:(PreFilledOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,PreFilledOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getRefillLiveUser:(GetRefillLiveUserRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetRefillLiveUserResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)countRefillLiveMoney:(CountRefillLiveMoneyRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CountRefillLiveMoneyResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)commitRefillLiveOrder:(CommitRefillLiveOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,CommitRefillLiveOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getHomeBannerList:(GetHomeBannerListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetHomeBannerListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getSearchLoad:(GetSearchLoadRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetSearchLoadResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)searchForKeywords:(SearchForKeywordsRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,SearchForKeywordsResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getUnpaidOrder:(GetUnpaidOrderRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetUnpaidOrderResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)changePsw:(ChangePwdRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,ChangePwdResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)versionGripe:(VersionGripeRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,VersionGripeResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)GetHotelRoomTypeList:(GetHotelRoomTypeListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetHotelRoomTypeListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)feedback:(FeedbackRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,FeedbackResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)openCabinet:(OpenCabinetRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,OpenCabinetResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getHotelIntro:(GetHotelIntroRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetHotelIntroResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getInvoiceLookupList:(GetInvoiceLookupListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetInvoiceLookupListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)editInvoiceLookup:(EditInvoiceLookupRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,EditInvoiceLookupResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)deleteInvoiceLookup:(DelInvoiceLookupRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,DelInvoiceLookupResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getInvoiceAddressList:(GetInvoiceAddressListRequset *)request success:(void (^)(AFHTTPRequestOperation * operation,GetInvoiceAddressListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)editInvoiceAddress:(EditInvoiceAddressRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,EditInvoiceAddressResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)delInvoiceAddress:(DelInvoiceAddressRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,DelInvoiceAddressResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getCouponList:(GetCouponListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetCouponListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getMineInfo:(MineInfoRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,MineInfoResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getVipLevelList:(GetVIPLevelListRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetVIPLevelListResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)applyVip:(ApplyVipRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,ApplyVipResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)detectUserStay:(DetectUserStayRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,DetectUserStayResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)confirmJPush:(ConfirmJPushRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,ConfirmJPushResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)updateUserInfo:(UpdateUserInfoRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UpdateUserInfoResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getCabinetInfo:(GetCabinetInfoRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetCabinetInfoResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)userSign:(UserSignRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,UserSignResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)exchangeCoupon:(ExchangeCouponRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,ExchangeCouponResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getRoomPrice:(GetRoomPriceRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetRoomPriceResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getCopyWriting:(GetCopywritingRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetCopywritingResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;

-(void)getPointsRecord:(GetPointsRecordRequest *)request success:(void (^)(AFHTTPRequestOperation * operation,GetPointsRecordResponse *response))success failure:(void (^)(AFHTTPRequestOperation * operation,NSError *error))failure;



@end
