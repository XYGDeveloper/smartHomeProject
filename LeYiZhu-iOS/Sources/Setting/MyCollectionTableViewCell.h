//
//  MyCollectionTableViewCell.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/13.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFavoriteModel.h"

#define kDefaultCollectionCellHeight  264

@interface MyCollectionTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger cellIndex;

@property (nonatomic, strong) MyFavoriteModel *favoriteModel;

@property (nonatomic, assign) BOOL isDel;

@property (nonatomic,copy)void(^delBtnClick)(NSInteger cellIndex);


@end
