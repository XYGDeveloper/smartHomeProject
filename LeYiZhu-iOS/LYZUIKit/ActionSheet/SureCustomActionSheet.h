//
//  SureCustomActionSheet.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface SureCustomActionSheet : UIView
- (instancetype)initWithTitleView:(UIView*)titleView
                       optionsArr:(NSArray*)optionsArr
                      cancelTitle:(NSString*)cancelTitle
                    selectedBlock:(void(^)(NSInteger))selectedBlock
                      cancelBlock:(void(^)())cancelBlock;

@end
