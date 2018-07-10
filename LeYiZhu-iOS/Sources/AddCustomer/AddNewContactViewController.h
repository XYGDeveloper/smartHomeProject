//
//  AddNewContactViewController.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/17.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBackBlock)();
typedef void (^CallBackToCommitBlock)(id);

@class LYZContactsModel;


@interface AddNewContactViewController : UIViewController

@property (nonatomic, strong)LYZContactsModel *fromContactsModel;

@property (nonatomic, assign) BOOL isFromChooseList; // 是否来自联系人列表，来自联系人列表是可以删除的，订单填写页面不能删除

@property (nonatomic, copy) CallBackBlock callbackBlock;

@property (nonatomic, copy) CallBackToCommitBlock callbackToCommitBlock;


-(void)endEditPhoneNum;

-(void)addLocalContact;

@end
