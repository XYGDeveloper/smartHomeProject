//
//  LYZStayPswCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayPswCell.h"
#import "UserStaysModel.h"
#import "HBLockSliderView.h"
#import "GCD.h"
#import "UIView+SetRect.h"

#define kPSWLabelWidth (SCREEN_WIDTH * kPswLabelXScale)
#define kPSWLabelHeight (SCREEN_HEIGHT * kPswLabelYScale)

#define kLeftSpaceXScale 0.107

#define kPswLabelYScale 0.102
#define kPswLabelXScale 0.1333

#define kPSWLeftSpace  (SCREEN_WIDTH * kLeftSpaceXScale)

#define kPSWSpace ((self.width - 4*kPSWLabelWidth - 2*kPSWLeftSpace)/3.0)

#define kSliderYScale 0.084

#define kChangeBtnWidth  30.0f



@interface LYZStayPswCell  ()<HBLockSliderDelegate>

@property (nonatomic, strong) UILabel *roomNumLabel;

@property (nonatomic, strong)  UICountingLabel *pswLabel1;
@property (nonatomic, strong)  UICountingLabel *pswLabel2;
@property (nonatomic, strong)  UICountingLabel *pswLabel3;
@property (nonatomic, strong)  UICountingLabel *pswLabel4;
@property (nonatomic, strong) UIButton *eyeBtn;
@property (nonatomic,strong) HBLockSliderView *slider3;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView * tapView;

@end


//static CGFloat _stayPlanPSWCellHeight = 250.0f;

@implementation LYZStayPswCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 25, LYZStayPswCell.cellHeight);
    self.width = SCREEN_WIDTH - 25;
}

- (void)buildSubview {
    self.roomNumLabel =[[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(0, 12, self.width,22)
    self.roomNumLabel.textColor = [UIColor blackColor];
    CGFloat roomNumFont = iPhone5_5s ? 18 : 20;
    self.roomNumLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:roomNumFont];
    self.roomNumLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.roomNumLabel];
    
   self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(0, self.roomNumLabel.bottom + 6, self.width, 20)
//    self.titleLabel.x = -18;
    self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    CGFloat titleFont = iPhone5_5s ? 12 : 14 ;
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:titleFont];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleLabel.text = @"开锁密码";
    [self addSubview: self.titleLabel];
    
    self.eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.eyeBtn.frame = CGRectZero;// CGRectMake(self.center.x + 20, title.y, 20, 20)
    [self.eyeBtn setImage:[UIImage imageNamed:@"live_icon_eye_c"] forState:UIControlStateNormal];
    [self.eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.eyeBtn];
    
//    //更换密码
//    UIButton *changePswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    changePswBtn.frame = CGRectMake(self.width - 40 - kChangeBtnWidth, title.y, kChangeBtnWidth, kChangeBtnWidth);
//    [changePswBtn setImage:[UIImage imageNamed:@"live_icon_eye_c"] forState:UIControlStateNormal];
//    [changePswBtn addTarget:self action:@selector(changePsw:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:changePswBtn];
    
    CGFloat pswFont = iPhone5_5s ? 45 : 50;
    
    self.pswLabel1 = [[UICountingLabel alloc] initWithFrame:CGRectZero];// CGRectMake(40, title.bottom + 15, kPSWLabelWidth, kPSWLabelHeight)
    self.pswLabel1.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:pswFont];
    self.pswLabel1.layer.borderWidth = 0.5f;
    self.pswLabel1.layer.borderColor = LYZTheme_PinkishGeryColor.CGColor;
    self.pswLabel1.textAlignment = NSTextAlignmentCenter;
    self.pswLabel1.method = UILabelCountingMethodLinear;
    self.pswLabel1.format = @"%d";
    [self addSubview:self.pswLabel1];
    
    self.pswLabel2 = [[UICountingLabel alloc] initWithFrame:CGRectZero];//CGRectMake(self.pswLabel1.right + kPSWSpace, self.pswLabel1.y, kPSWLabelWidth, kPSWLabelHeight)
    self.pswLabel2.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:pswFont];
    self.pswLabel2.layer.borderWidth = 0.5f;
    self.pswLabel2.layer.borderColor = LYZTheme_PinkishGeryColor.CGColor;
    self.pswLabel2.textAlignment = NSTextAlignmentCenter;
    self.pswLabel2.method = UILabelCountingMethodLinear;
    self.pswLabel2.format = @"%d";
    [self addSubview:self.pswLabel2];
    
    self.pswLabel3 = [[UICountingLabel alloc] initWithFrame:CGRectZero];//CGRectMake(self.pswLabel2.right + kPSWSpace, self.pswLabel1.y, kPSWLabelWidth, kPSWLabelHeight)
    self.pswLabel3.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:pswFont];
    self.pswLabel3.layer.borderWidth = 0.5f;
    self.pswLabel3.layer.borderColor = LYZTheme_PinkishGeryColor.CGColor;
    self.pswLabel3.textAlignment = NSTextAlignmentCenter;
    self.pswLabel3.method = UILabelCountingMethodLinear;
    self.pswLabel3.format = @"%d";
    [self addSubview:self.pswLabel3];
    
    self.pswLabel4 = [[UICountingLabel alloc] initWithFrame:CGRectZero];//CGRectMake(self.pswLabel3.right + kPSWSpace, self.pswLabel1.y, kPSWLabelWidth, kPSWLabelHeight)
    self.pswLabel4.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:pswFont];
    self.pswLabel4.layer.borderWidth = 0.5f;
    self.pswLabel4.layer.borderColor = LYZTheme_PinkishGeryColor.CGColor;
    self.pswLabel4.textAlignment = NSTextAlignmentCenter;
    self.pswLabel4.method = UILabelCountingMethodLinear;
    self.pswLabel4.format = @"%d";
    [self addSubview:self.pswLabel4];
    
    self.tapView = [[UIView alloc]  initWithFrame:CGRectZero];//CGRectMake(0, self.pswLabel1.y, self.width, kPSWLabelHeight)
    self.tapView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tapView];
    
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(changePsw:)];
    [self.tapView addGestureRecognizer:press];
    
    self.slider3 = [[HBLockSliderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH- 25 - 2 * kPSWLeftSpace, kSliderYScale * SCREEN_HEIGHT)];//CGRectMake(38, self.pswLabel1.bottom + 20, self.width - 38 * 2, 56)
    [ self.slider3 setThumbImage:[UIImage imageNamed:@"live_icon_key_2"]];
     self.slider3.text = @"右滑网络开锁 >";
    CGFloat sliderFont = iPhone5_5s ? 12 : 15;
     self.slider3.font = [UIFont fontWithName:LYZTheme_Font_Regular size:sliderFont];
     self.slider3.delegate = self;
    [self addSubview: self.slider3];
}

- (void)loadContent {
    UserStaysModel *model = (UserStaysModel *)self.data;
    self.roomNumLabel.text = [NSString stringWithFormat:@"%@号房间",model.roomNum];
    [self.roomNumLabel sizeToFit];
    
    self.titleLabel.text = @"开锁密码";
    [self.titleLabel sizeToFit];
   
    
    if (_isEyeOpen) {
          [self separatePsw:model.password];
         CGFloat pswFont = iPhone5_5s ? 45 : 50;
        self.pswLabel1.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:pswFont];
        self.pswLabel2.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:pswFont];
        self.pswLabel3.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:pswFont];
        self.pswLabel4.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:pswFont];
          [_eyeBtn setImage:[UIImage imageNamed:@"live_icon_eye_o"] forState:UIControlStateNormal];
    }else{
         [self.eyeBtn setImage:[UIImage imageNamed:@"live_icon_eye_c"] forState:UIControlStateNormal];
        CGFloat closePswFont = iPhone5_5s ? 26 : 30;
        self.pswLabel1.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:closePswFont];
        self.pswLabel2.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:closePswFont];
        self.pswLabel3.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:closePswFont];
        self.pswLabel4.font = [UIFont fontWithName:LYZTheme_Font_UCAS size:closePswFont];
        _pswLabel1.text = @"＊";
        _pswLabel2.text = @"＊";
        _pswLabel3.text = @"＊";
        _pswLabel4.text = @"＊";
    }
    
    [self layoutSubviews];
}

-(void)layoutSubviews{
    self.roomNumLabel.centerX = self.width /2.0;
    self.roomNumLabel.y = 12;
    
    self.titleLabel.centerX = self.width /2.0 - 18;
    self.titleLabel.y = self.roomNumLabel.bottom + 6;
    
    self.eyeBtn.frame =  CGRectMake(self.width /2.0 + 20, 0, 20, 20);
    self.eyeBtn.centerY = self.titleLabel.centerY;
    
    self.pswLabel1.frame = CGRectMake(kPSWLeftSpace, self.titleLabel.bottom + 12, kPSWLabelWidth, kPSWLabelHeight);
    self.pswLabel2.frame = CGRectMake(self.pswLabel1.right + kPSWSpace, self.pswLabel1.y, kPSWLabelWidth, kPSWLabelHeight);
    self.pswLabel3.frame = CGRectMake(self.pswLabel2.right + kPSWSpace, self.pswLabel1.y, kPSWLabelWidth, kPSWLabelHeight);
    self.pswLabel4.frame = CGRectMake(self.pswLabel3.right + kPSWSpace, self.pswLabel1.y, kPSWLabelWidth, kPSWLabelHeight);
    
    self.tapView.frame  = CGRectMake(0, self.pswLabel1.y, self.width, kPSWLabelHeight);
    
    self.slider3.frame = CGRectMake(kPSWLeftSpace, self.pswLabel1.bottom + 20, self.width - 2 * kPSWLeftSpace, kSliderYScale * SCREEN_HEIGHT);
    
    
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

//+ (void)setCellHeight:(CGFloat)cellHeight {
//
//    _stayPlanPSWCellHeight = cellHeight;
//}
//
//+ (CGFloat)cellHeight {
//
//    return _stayPlanPSWCellHeight;
//}

#pragma mark -- Private method

-(void)separatePsw:(NSString *)passwordStr{
    if(passwordStr.length >= 1){
        NSString *ps1 = [passwordStr substringWithRange:NSMakeRange(0, 1)];
        if (![self.pswLabel1.text isEqualToString:@"＊"]) {
            [GCDQueue executeInMainQueue:^{
                  [self.pswLabel1 countFrom:self.pswLabel1.text.integerValue to:ps1.integerValue];
            }];
        }else{
             self.pswLabel1.text = ps1;
        }
    }
    if(passwordStr.length >= 2){
        NSString *ps2 = [passwordStr substringWithRange:NSMakeRange(1, 1)];
        if (![self.pswLabel2.text isEqualToString:@"＊"]) {
            [GCDQueue executeInMainQueue:^{
                [self.pswLabel2 countFrom:self.pswLabel2.text.integerValue to:ps2.integerValue];
            }];
        }else{
            self.pswLabel2.text = ps2;
        }
    }
    if(passwordStr.length >= 3){
        NSString *ps3 = [passwordStr substringWithRange:NSMakeRange(2, 1)];
        if (![self.pswLabel3.text isEqualToString:@"＊"]) {
            [GCDQueue executeInMainQueue:^{
                 [self.pswLabel3 countFrom:self.pswLabel3.text.integerValue to:ps3.integerValue];
            }];
        }else{
            self.pswLabel3.text = ps3;
        }
    }
    if(passwordStr.length >= 4){
        NSString *ps4 = [passwordStr substringWithRange:NSMakeRange(3, 1)];
        if (![self.pswLabel4.text isEqualToString:@"＊"]) {
            [GCDQueue executeInMainQueue:^{
                  [self.pswLabel4 countFrom:self.pswLabel4.text.integerValue to:ps4.integerValue];
            }];
        }else{
            self.pswLabel4.text = ps4;
        }
    }
}

#pragma mark -- Btn  Action

-(void)eyeBtnClick:(UIButton *)sender{
    _isEyeOpen = !_isEyeOpen;
    if (self.showPswHandler) {
        self.showPswHandler(_isEyeOpen);
    }
}

-(void)changePsw:(UILongPressGestureRecognizer *)sender{
   
     UserStaysModel *model = (UserStaysModel *)self.data;
    if ([sender state] == UIGestureRecognizerStateBegan) {
        
        //长按事件开始"
        //do something
        if (self.changePswHandler) {
            self.changePswHandler(model);
        }
    }
    else if ([sender state] == UIGestureRecognizerStateEnded) {
        //长按事件结束
        //do something
       
    }
}


- (void)sliderEndValueChanged:(HBLockSliderView *)slider{
    if (slider.value == 1) {
        //        slider.thumbBack = NO;
        //        [slider setSliderValue:1.0];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"解锁成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
        if (self.OpenDoorHandler) {
            self.OpenDoorHandler();
        }
    }
  

}

- (void)sliderValueChanging:(HBLockSliderView *)slider{
        NSLog(@"%f",slider.value);
}
@end
