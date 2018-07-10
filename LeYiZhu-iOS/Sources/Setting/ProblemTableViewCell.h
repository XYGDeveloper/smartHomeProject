//
//  ProblemTableViewCell.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/17.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProblemModel.h"

#define  kDefaultProblemCellHeight  70

@interface ProblemTableViewCell : UITableViewCell

@property (nonatomic ,strong) MyProblemModel *model;


+ (CGFloat)returnCellHeight:(MyProblemModel *)model;

@end
