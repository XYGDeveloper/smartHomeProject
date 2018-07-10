//
//  GetHotelIntroResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
#import "HotelIntroModel.h"

@interface GetHotelIntroResponse : AbstractResponse

@property (nonatomic, readonly, strong) HotelIntroModel *hotelIntro;

@end
