//
//  AddressDetailCell.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CustomCell.h"

@interface AddressDetailCell : CustomCell

+(CGFloat)cellHeightWithData:(id)data;

@property (nonatomic, assign) CGFloat cellHeight;

@end
