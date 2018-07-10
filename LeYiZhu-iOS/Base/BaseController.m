//
//  BaseController.m
//  ZhiNengJiaju
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseController.h"
#import "Masonry.h"
@interface BaseController ()

@end

@implementation BaseController


- (void)setNavigationItem:(UIBarButtonItem *)item
{

    if (!item || ![item isKindOfClass:[UIBarButtonItem class]]) {
        return;
        
    }

    NSMutableArray *itermArray = [NSMutableArray arrayWithObject:item];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [itermArray insertObject:spaceItem atIndex:0];
    self.navigationItem.leftBarButtonItems = itermArray;
    

}


- (UIButton *)setLeftNavigationItemWithImage:(UIImage *)leftImage
                        hightLightImageImage:(UIImage *)hightImage
                                      action:(SEL)action
{

    UIButton *button = [self NavigationButtonWithImage:leftImage hightimage:hightImage action:action];
    
    return button;
    
}

- (UIButton *)NavigationButtonWithImage:(UIImage *)image hightimage:(UIImage *)hightImage action:(SEL)action{


    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        
    }
    
    if (hightImage) {
        [button setImage:hightImage forState:UIControlStateNormal];
        
    }
    
    if (action) {
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        
    }

    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    button.frame = CGRectMake(0, 0, 44.0, 44.0);
    
    return button;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    LYLog(@"%@ : viewDidDisappear" , NSStringFromClass(self.class));
}

- (void)dealloc
{
//    [super dealloc];
    LYLog(@"%@ : dealloc" , NSStringFromClass(self.class));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
