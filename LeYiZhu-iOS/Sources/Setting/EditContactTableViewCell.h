//
//  EditContactTableViewCell.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/12.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultCellHeight 60

@interface EditContactTableViewCell : UITableViewCell
@property (nonatomic, assign)BOOL canEdit;

@property (nonatomic, copy)NSString *ikey;

@property (nonatomic, copy)NSString *ivalue;



@property (nonatomic,copy)void(^cellEdited)(NSString *key, NSString *value);
@property (nonatomic,copy)void(^textFieldClick)();

@end
