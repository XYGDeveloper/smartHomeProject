//
//  PointDetailCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "PointDetailCell.h"
#import "PointsModel.h"
#import "UIView+SetRect.h"

@interface PointDetailCell ()

@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *pointLabel;

@end

static CGFloat _PointDetailCellHeight = 78.5f;

@implementation PointDetailCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.textColor = LYZTheme_paleBrown;
    self.nameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16.0f];
    [self addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLabel.textColor = LYZTheme_warmGreyFontColor;
    self.timeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:12.0f];
    [self addSubview:self.timeLabel];
    
    self.pointLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.pointLabel.textColor = LYZTheme_paleBrown;
    self.pointLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:18.0f];
    [self addSubview:self.pointLabel];
}


- (void)loadContent {
    PointsModel *model = (PointsModel *)self.data;
    self.nameLabel.text = [self getPointName:model.type.integerValue];
    self.timeLabel.text = model.time;
    self.pointLabel.text = [NSString stringWithFormat:@"+%@积分",model.incomevalue];
    [self layoutSubviews];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel sizeToFit];
    self.nameLabel.x = DefaultLeftSpace;
    self.nameLabel.y = 18;
    
    [self.timeLabel sizeToFit];
    self.timeLabel.x = DefaultLeftSpace;
    self.timeLabel.y = self.nameLabel.bottom + 10;
    
    [self.pointLabel sizeToFit];
    self.pointLabel.right = SCREEN_WIDTH - DefaultLeftSpace;
    self.pointLabel.centerY = _PointDetailCellHeight /2.0;
    
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _PointDetailCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _PointDetailCellHeight;
}

#pragma mark - private

-(NSString *)getPointName:(NSInteger)type{
    NSString *name;
    switch (type) {
        case 1:
            name = @"预定酒店";
            break;
        case 2:
            name =  @"手动退房";
            break;
        case 3:
            name = @"评论";
            break;
        case 4:
            name = @"签到";
            break;

        default:
            break;
    }
    return name;
}

@end
