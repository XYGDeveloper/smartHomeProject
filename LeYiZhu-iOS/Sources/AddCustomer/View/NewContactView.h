//
//  NewContactView.h
//  LeYiZhu-iOS
//
//  Created by mac on 16/11/25.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewContactView : UIView

+ (instancetype)NewContactViewFromNib;


@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *idCardField;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *paperworkTypeField;

@property (nonatomic, copy)  void (^paperworkBtnHandler) ();

-(IBAction)selectPaperworkType:(id)sender;


@end
