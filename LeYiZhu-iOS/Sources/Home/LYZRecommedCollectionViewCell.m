//
//  LYZRecommedCollectionViewCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/20.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRecommedCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface LYZRecommedCollectionViewCell ()

@property (nonatomic, strong) UIImageView *hotelImgView;

@end

@implementation LYZRecommedCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.hotelImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        self.hotelImgView.layer.shadowColor = [UIColor redColor].CGColor;
        [self addSubview:self.hotelImgView];
    }
    
    return self;
    
}

-(void)setImgURL:(NSString *)imgURL{
    _imgURL = imgURL;
    [self.hotelImgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:nil];
    
}

@end
