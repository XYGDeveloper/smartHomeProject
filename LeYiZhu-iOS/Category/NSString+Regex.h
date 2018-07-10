//
//  NSString+Regex.h
//  LeYiZhu-iOS
//
//  Created by mac on 2016/12/19.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

- (BOOL) isMobile;

- (BOOL) isEmail;

- (BOOL) isPassword;

- (BOOL) isId_Card;

@end
