//
//  MineFunctionsCollectionViewCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "MineFunctionsCollectionViewCell.h"
#import "UIView+SetRect.h"

@interface MineFunctionsCollectionViewCell ()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation MineFunctionsCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/3.0 - 44)/2.0, 17.5, 44, 44)];
        [self addSubview:self.iconImgView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.iconImgView.bottom + 12, self.width, 16)];
        self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
        self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom + 5, self.width, 12)];
        self.subTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:12];
        self.subTitleLabel.textColor = LYZTheme_warmGreyFontColor;
        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.subTitleLabel];
    }
    return self;
}

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.iconImgView.image = [UIImage imageNamed:imageName];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    if ([title isEqualToString:@"积分"]) {
        self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    }else{
         self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    }
    self.titleLabel.text = title;
}

-(void)setSubTitle:(NSString *)subTitle{
    if (!subTitle || [subTitle isEqualToString:@""]) {
        self.subTitleLabel.hidden = YES;
    }else{
        _subTitle = subTitle;
        self.subTitleLabel.hidden = NO;
        self.subTitleLabel.text = subTitle;
    }
   
    
}


@end
