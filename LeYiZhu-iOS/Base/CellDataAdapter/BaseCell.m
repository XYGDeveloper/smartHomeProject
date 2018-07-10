//
//  BaseCell.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/19.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [[UIColor colorWithHexString:@"E8E8E8"] colorWithAlphaComponent:0.9f];
        [self  addSubview:line];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
