//
//  ChangePhoneStep2ViewController.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/10.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThirdLoginInfoModel;

typedef NS_ENUM(NSUInteger, phoneType) {
    changeType = 0,
    bindType,
};


@interface ChangePhoneStep2ViewController : UIViewController

@property (nonatomic, assign) phoneType type;

@property (nonatomic, strong) ThirdLoginInfoModel * infoModel;

@end
