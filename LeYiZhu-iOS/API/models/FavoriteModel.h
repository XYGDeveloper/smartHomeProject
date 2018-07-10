//
//  FavoriteModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FavoriteModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, copy) NSString * favoriteID;

@property (nonatomic ,readonly, copy) NSString * appUserID;

@property (nonatomic ,readonly, copy) NSString * hotelID;

@property (nonatomic ,readonly, copy) NSString * imgPath;

@property (nonatomic ,readonly, copy) NSString * hotelName;

@property (nonatomic ,readonly, copy) NSString * address;

@property (nonatomic ,readonly, copy) NSString * lowestPrice;

@property (nonatomic ,readonly, copy) NSString * comentSum;



@end
