//
//  LYZSearchTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZSearchTableViewCell.h"
#import "Masonry.h"
#import "SearchLoadHotelModel.h"
//#import "SearchHotelModel.h"
#define GeneralLabel(f, c) [UIHelper labelWithFont:f textColor:c]
#define GeneralLabelA(f, c, a) [UIHelper labelWithFont:f textColor:c textAlignment:a]

@interface LYZSearchTableViewCell ()

@end


@implementation LYZSearchTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.HotelNameLabel = [[UILabel alloc]init];
        self.HotelNameLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f];
        self.HotelNameLabel.textColor = [UIColor blackColor];
        self.HotelNameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        [self.contentView addSubview:self.HotelNameLabel];
        
        self.distanceLabel = [[UILabel alloc]init];
        self.distanceLabel.textColor = [UIColor blackColor];
        self.distanceLabel.font = [UIFont systemFontOfSize:14.0f];
        self.distanceLabel.textAlignment = NSTextAlignmentRight;
        self.distanceLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        self.distanceLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f  blue:153/255.0f  alpha:1.0f];
        self.distanceLabel.textColor = [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1.0f];
        [self.contentView addSubview:self.distanceLabel];
        
        self.separatorInset = UIEdgeInsetsZero;
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            self.layoutMargins = UIEdgeInsetsZero;
        }
        if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            self.preservesSuperviewLayoutMargins = NO;
        }
        
        [self configLaout];
    }
    return self;
}

- (void)refreshWithSearchHotelModel:(SearchLoadHotelModel *)hotelModel showDistance:(BOOL)isShow {
    
    self.HotelNameLabel.text = hotelModel.name;
    if (isShow) {
        self.distanceLabel.text = [NSString stringWithFormat:@"%.2fkm",[hotelModel.distance doubleValue]];
    }
    
}

#pragma mark - Layout
- (void)configLaout {
    
    [self.HotelNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(- 10);
        make.top.equalTo(@5);
        make.height.mas_equalTo(35);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@5);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(200);
        
    }];
}

#pragma mark - Properties

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
