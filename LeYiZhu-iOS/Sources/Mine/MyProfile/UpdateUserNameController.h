//
//  UpdateUserNameController.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 2017/11/27.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateUserNameController : UIViewController

@property (nonatomic,copy) void(^updateNamePop)(NSString *nickName);

@end
