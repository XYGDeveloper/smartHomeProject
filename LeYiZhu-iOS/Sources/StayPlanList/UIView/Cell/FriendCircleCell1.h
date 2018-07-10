//
//  FriendCircleCell1.h
//  MedicineClient
//
//  Created by L on 2017/8/21.
//  Copyright © 2017年 深圳乐易住智能科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^toThumb)();

@class HotelCommentsModel;

@interface FriendCircleCell1 : UITableViewCell

@property (nonatomic,strong)toThumb thumb;

- (void)cellDataWithModel:(HotelCommentsModel *)model;

@end
