//
//  GradientImgaeGenerator.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/31.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GradientImgaeGenerator : NSObject

+(UIImage *)generatorImageWithImageSize:(CGSize)size startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

@end
