//
//  NewContactView.m
//  LeYiZhu-iOS
//
//  Created by mac on 16/11/25.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "NewContactView.h"

@interface NewContactView ()

@property (weak, nonatomic) IBOutlet UIView *baseView;




@end

@implementation NewContactView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
//    self.backgroundColor = kDefaultBackgroundColor;
}


#pragma mark -- Nib
+(instancetype)NewContactViewFromNib
{
    NewContactView *v = [[[NSBundle mainBundle] loadNibNamed:@"NewContactView" owner:nil options:nil] lastObject];
    CGFloat width = kScreenWidth;
//    v.frame = CGRectMake(0, 0, width, v.bounds.size.height);
    v.frame = CGRectMake(0, 0, width, SCREEN_HEIGHT);
    return v;
}

-(IBAction)selectPaperworkType:(id)sender{
    if (self.paperworkBtnHandler) {
        self.paperworkBtnHandler();
    }
}

@end
