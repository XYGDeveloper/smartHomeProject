//
//  RecieverInfoModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecieverInfoModel : NSObject

@property (nonatomic, copy) NSString *invoiceAddressID;

@property (nonatomic, copy) NSString *recipient;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic,  copy) NSString *area;

@property (nonatomic,  copy) NSString *address;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) NSInteger index;


@end
