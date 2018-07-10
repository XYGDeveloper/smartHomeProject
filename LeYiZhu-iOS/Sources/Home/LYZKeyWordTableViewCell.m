//
//  LYZKeyWordTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/4/20.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZKeyWordTableViewCell.h"
#import "Masonry.h"


@interface LYZKeyWordTableViewCell()




@end


@implementation LYZKeyWordTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.cityName = [[UILabel alloc]init];
        self.cityName.font = [UIFont systemFontOfSize:16.0f];
        self.cityName.textColor = LYZTheme_paleBrown;
        [self.contentView addSubview:self.cityName];
        [self configLaout];
        
    }
    return self;
}

#pragma mark - Layout
- (void)configLaout {
    
    [self.cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView).mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
        
    }];
    
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
