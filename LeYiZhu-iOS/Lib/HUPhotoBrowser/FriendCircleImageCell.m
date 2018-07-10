//
//  FriendCircleImageCell.m
//  ReactCocoaDemo
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "FriendCircleImageCell.h"
#import "Masonry.h"
#import "LTUITools.h"
#import "UIImageView+WebCache.h"
#import "UIView+AnimationProperty.h"
@interface FriendCircleImageCell ()

@end

@implementation FriendCircleImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [LTUITools lt_creatImageView];
        [self.contentView addSubview:self.imageView];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)cellDataWithImageName:(NSString *)imageName
{
//    self.imageView.image = [UIImage imageNamed:imageName];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"placehoder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.image = image;
        self.imageView.alpha = 0;
        self.imageView.scale = 1.1f;
        
        [UIView animateWithDuration:0.5f animations:^{
            
            self.imageView.alpha = 1.f;
            self.imageView.scale = 1.f;
        }];
    }];
    

    
}

@end
