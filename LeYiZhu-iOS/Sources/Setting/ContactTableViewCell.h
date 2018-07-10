//
//  ContactTableViewCell.h
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^isDefaultBlock)(id sender);  //有选择默认按钮时操作这个,暂时隐藏
typedef void (^isEditBlock)();
@interface ContactTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *telephoneLabel;
@property (nonatomic,strong)UIButton *editButton;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)isDefaultBlock isdefault;
@property (nonatomic,strong)isEditBlock isEdit;



@end
