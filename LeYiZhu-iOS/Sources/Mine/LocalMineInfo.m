//
//  LocalMineInfo.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LocalMineInfo.h"
#import "BaseMineInfoModel.h"
#import "VipInfoModel.h"

@implementation LocalMineInfo

+(instancetype)initWithNetworkMineinfo:(BaseMineInfoModel *)networkModel{
    LocalMineInfo *model = [LocalMineInfo new];
    model.username = networkModel.username;
    model.isvip = networkModel.isvip;
    model.todopaycount = networkModel.todopaycount;
    model.todocheckincount = networkModel.todocheckincount;
    model.couponcount = networkModel.couponcount;
    model.favoriteCount = networkModel.favoritecount;
    model.vipname = networkModel.vipinfo.vipname;
    model.discountrule = networkModel.vipinfo.discountrule;
    model.pointsrule = networkModel.vipinfo.pointsrule;
    model.checkouttimerule = networkModel.vipinfo.checkouttimerule;
    model.points = networkModel.points;
    model.exp = networkModel.vipinfo.exp;
    model.vipcode = networkModel.vipinfo.vipcode;
    return model;
    
}

@end
