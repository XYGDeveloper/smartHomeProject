//
//  CabinetNormsCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CabinetNormsCell.h"
#import "UIView+SetRect.h"

@interface CabinetNormsCell ()

@property (nonatomic, strong) UILabel *normsLabel;

@end

static CGFloat _CabinetNormsCellHeight = 45.0f;

@implementation CabinetNormsCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    
    self.normsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.normsLabel.textColor = LYZTheme_paleBrown;
    self.normsLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15.0];
    [self addSubview:self.normsLabel];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 10, (CabinetNormsCell.cellHeight  - 10) /2.0, 10, 10)];
    img.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:img];
    
}

- (void)loadContent {
    NSString *norms = (NSString *)self.data;
    self.normsLabel.text = norms;
    [self.normsLabel sizeToFit];
    self.normsLabel.x = DefaultLeftSpace;
    self.normsLabel.centerY = _CabinetNormsCellHeight/2.0;
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _CabinetNormsCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _CabinetNormsCellHeight;
}





@end
