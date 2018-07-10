//
//  LYZFacilitiesIrregularCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZFacilitiesIrregularCell.h"
#import "UILabel+SizeToFit.h"
#import "UIView+SetRect.h"

@interface LYZFacilitiesIrregularCell ()

@property (nonatomic ,strong) UILabel *contentLabel;

@end

@implementation LYZFacilitiesIrregularCell

- (void)setupCell {
    self.contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.contentLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"#7387BC"];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.layer.cornerRadius = self.height /2.0;
    self.contentLabel.layer.borderWidth = 0.5f;
    self.contentLabel.layer.borderColor = [UIColor colorWithHexString:@"#7387BC"].CGColor;
    [self addSubview:self.contentLabel];
    
}

- (void)loadContent {
    self.contentLabel.width = self.dataAdapter.itemWidth;
    self.contentLabel.text = self.data;
}



@end
