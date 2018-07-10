//
//  LYZHotelDetailViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYZHotelDetailViewController : UIViewController

@property (nonatomic, strong) NSString *hotelID;

- (void)showInViewController:(UIViewController *)vc;

@end
