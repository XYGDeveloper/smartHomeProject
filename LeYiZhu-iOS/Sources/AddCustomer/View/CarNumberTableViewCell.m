//
//  CarNumberTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by L on 2018/1/5.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "CarNumberTableViewCell.h"
#import "LYZContactsModel.h"
#import "Public.h"
#import "Public+JGHUD.h"
@interface CarNumberTableViewCell()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneTF;

@property (nonatomic, strong)  UILabel *errorLabel;



@end

@implementation CarNumberTableViewCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    UILabel *titltLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 100, 60)];
    titltLabel.textColor = LYZTheme_warmGreyFontColor;
    titltLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    titltLabel.text = @"  证件号码";
    [self addSubview:titltLabel];
    
//    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 10, (60  - 10) /2.0, 10, 10)];
//    img.image = [UIImage imageNamed:@"indent_icon_show"];
//    [self addSubview:img];
    
//    UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    contactBtn.frame = CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 50, 0, 50 +DefaultLeftSpace, 60);
//    [contactBtn addTarget:self action:@selector(addContact:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:contactBtn];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(titltLabel.right , 0, kScreenWidth- DefaultLeftSpace - 100-10, 60)];
    _phoneTF.delegate = self;
    _phoneTF.textColor = [UIColor blackColor];
    _phoneTF.placeholder = @"证件号码（选填）";
    _phoneTF.clearButtonMode =     UITextFieldViewModeWhileEditing;
    _phoneTF.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [self addSubview:_phoneTF];
    
    _errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(_phoneTF.x, _phoneTF.bottom - 15, 150, 20)];
    _errorLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    _errorLabel.textColor = [UIColor redColor];
    _errorLabel.text = @"证件号码格式不正确";
    _errorLabel.hidden = YES;
    [self addSubview:_errorLabel];
    
}

- (void)loadContent {
    LYZContactsModel *model = (LYZContactsModel *)self.data;
    self.phoneTF.text = model.paperworkNum;
    NSLog(@"获得model.paperworkNum:%@",model.paperworkNum);

//    if ([IICommons validateIDCardNumber:model.paperworkNum] || [model.paperworkNum isEqualToString:@""]) {
//        self.errorLabel.hidden = YES;
//    }else{
//        self.errorLabel.hidden = NO;
//    }
    
}

- (void)selectedEvent {
    
}

#pragma mark - class property.
+(CGFloat)cellHeightWithData:(id)data{
    LYZContactsModel *model = (LYZContactsModel *)data;
    if ([IICommons validateIDCardNumber:model.paperworkNum] || [model.paperworkNum isEqualToString:@""]) {
        return 60;
    }else{
        return 80;
    }
}

#pragma  mark -- TextField Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
            self.errorLabel.hidden = YES;
            LYZContactsModel *model = (LYZContactsModel *)self.data;
            model.paperworkNum = textField.text;
            NSLog(@"输入：model.paperworkNum:%@",model.paperworkNum);
 
}

@end
