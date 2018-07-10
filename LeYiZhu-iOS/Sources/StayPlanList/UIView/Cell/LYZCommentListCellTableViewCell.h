//
//  LYZCommentListCellTableViewCell.h
//  LeYiZhu-iOS
//
//  Created by L on 2018/1/20.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotelCommentsModel;
@interface LYZCommentListCellTableViewCell : UITableViewCell

- (void)refreshWithModel:(HotelCommentsModel *)model;

@end
