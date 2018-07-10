//
//  LYZHotelCommentViewController.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYZHotelCommentViewController : UIViewController

@property (nonatomic, copy) NSString *hotelId;

@property (nonatomic, copy) NSString *averageScore;

- (void)showInViewController:(UIViewController *)vc;

@end
