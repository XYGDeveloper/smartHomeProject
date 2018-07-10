//
//  LYZRoomViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotelRoomsModel;
@class LYZHotelDetailModel;
@interface LYZRoomViewController : UIViewController

@property (nonatomic, strong) NSString *roomID;
@property (nonatomic ,strong)  LYZHotelDetailModel * hotelDetailModel;
@property (nonatomic ,strong)  HotelRoomsModel * hotelRoomslModel;

@end
