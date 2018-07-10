//
//  LYZHotelViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyManager.h"
#import "MJRefresh.h"
#import <Reachability.h>
@class HotelRoomsModel;
@interface LYZHotelViewController : UIViewController

@property (nonatomic, copy) NSString *i_hotelId;

@property (nonatomic, copy) NSString *i_longitude;

@property (nonatomic, copy) NSString *i_latidute;

-(void)navToBaiDuMap;

-(void)datePick;

-(void)orderRoom:(HotelRoomsModel *)model;

-(void)pushToRoom:(HotelRoomsModel *)model;

-(void)showHotelFeature:(NSInteger)index;//Deprecated

-(void)selectRoomType:(HotelRoomsModel *)model index:(NSInteger)index;

@end
