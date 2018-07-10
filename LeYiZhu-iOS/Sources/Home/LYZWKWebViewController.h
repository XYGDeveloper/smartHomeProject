//
//  ViewController.h
//  WKWebViewDemo
//
//  Created by hujunhua on 2016/11/17.
//  Copyright © 2016年 hujunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    iBannerType = 0,
    iRecommendType,
    iActivityType,
    iMoreType,
    iNoneType
} ifromType;

@interface LYZWKWebViewController : UIViewController

@property (nonatomic, assign) ifromType type;
@property (nonatomic, copy) NSString *hotelID;
@property (nonatomic,copy) NSString *strURL;

@end

