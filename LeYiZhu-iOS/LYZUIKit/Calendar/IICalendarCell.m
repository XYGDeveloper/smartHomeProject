//
//  IICalendarCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/13.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IICalendarCell.h"
#import "FSCalendarExtensions.h"

@implementation IICalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CALayer *selectionLayer = [[CALayer alloc] init];
        selectionLayer.backgroundColor = LYZTheme_paleBrown.CGColor;
        selectionLayer.actions = @{@"hidden":[NSNull null]}; // Remove hiding animation
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;
        
        CALayer *middleLayer = [[CALayer alloc] init];
        middleLayer.backgroundColor = [LYZTheme_paleBrown colorWithAlphaComponent:0.3].CGColor;
        middleLayer.actions = @{@"hidden":[NSNull null]}; // Remove hiding animation
        [self.contentView.layer insertSublayer:middleLayer below:self.titleLabel.layer];
        self.middleLayer = middleLayer;
        
        // Hide the default selection layer
        self.shapeLayer.hidden = YES;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    self.selectionLayer.frame = CGRectMake(self.contentView.x, 15, self.contentView.width, self.contentView.height - 15);
//    self.selectionLayer.cornerRadius = 5.0f;
    self.middleLayer.frame = CGRectMake(self.contentView.x, 15, self.contentView.width, self.contentView.height - 15);
}

@end
