//
//  AddCustomerController.h
//  LeYiZhu-iOS
//
//  Created by mac on 16/11/23.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseController.h"
#import "LYZContactsModel.h"


typedef void (^CompleteBlock)(LYZContactsModel *model);

@interface LYZChooseGuestViewController : BaseController

@property (nonatomic , strong) CompleteBlock completeBlock;

@property (nonatomic, strong) NSArray <LYZContactsModel *>*filledContacts;//已经填写了的入住人数组(不能再选中)，用于判断是否是已经选了的



@end
