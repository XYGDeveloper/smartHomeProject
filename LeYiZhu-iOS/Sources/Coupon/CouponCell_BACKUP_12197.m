//
//  CouponCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CouponCell.h"
#import "CouponModel.h"
#import "UIView+SetRect.h"
#import "CouponViewController.h"

@interface CouponCell ()

@property (nonatomic, strong) UILabel *couponNameLabel;
@property (nonatomic, strong) UILabel *couponDescriptionLabel;
@property (nonatomic, strong) UILabel *deadlineLabel;
@property (nonatomic, strong) UILabel *scopeLabel;
@property (nonatomic, strong) UILabel *couponStatusLabel;
@property (nonatomic, strong) UIButton *instructionBtn;

@end

static CGFloat _CouponCellHeight = 132.0f;

@implementation CouponCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = LYZTheme_BackGroundColor;
}


- (void)buildSubview {
    UIImageView *backgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(22, (CouponCell.cellHeight - 128)/2.0, SCREEN_WIDTH - 44, 128)];
  
    UIImage *imgCoupon = [UIImage imageNamed:@"coupon_bg"];
    imgCoupon = [imgCoupon resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    backgroundImgView.image = imgCoupon;
    [self addSubview:backgroundImgView];
    
    self.couponNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.couponNameLabel];
    
    self.instructionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.instructionBtn.frame = CGRectZero;
//    [self.instructionBtn setTitle:@"不可用说明" forState:UIControlStateNormal];
    [self.instructionBtn setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
    self.instructionBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    [self.instructionBtn addTarget:self action:@selector(instruction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.instructionBtn];
    
    self.couponDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.couponDescriptionLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self addSubview:self.couponDescriptionLabel];
    
    
    self.deadlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.deadlineLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:12];
    [self addSubview:self.deadlineLabel];
    
    self.scopeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.scopeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    [self addSubview:self.scopeLabel];
}

-(UILabel *)couponStatusLabel{
    if (!_couponStatusLabel) {
        _couponStatusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _couponStatusLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:12];
        _couponStatusLabel.textColor = LYZTheme_BlackFontColorFontColor;
//        _couponStatusLabel.text = @"已过期";
        [self addSubview:_couponStatusLabel];
    }
    return _couponStatusLabel;
}


- (void)loadContent {
    
    CouponModel *model = (CouponModel *)self.data;
     BOOL isVaild = [model.isavailable isEqualToString:@"Y"]  ? YES:NO;
   
    if (model.coupontype.integerValue == 1) {
        //现金券
        NSString *coupon = [NSString stringWithFormat:@"￥ %@ 抵扣券",model.denominat];
        UIColor *couponNameColor = isVaild? RGB(208, 2, 27) : RGB(201, 201, 201);
        NSMutableAttributedString *couponNameAttri = [[NSMutableAttributedString alloc] initWithString:coupon];
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:couponNameColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Medium size:20]};
        [couponNameAttri addAttributes:attriBute1 range:NSMakeRange(0, 1)];
        NSDictionary * attriBute2 = @{NSForegroundColorAttributeName:couponNameColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Medium size:32]};
        [couponNameAttri addAttributes:attriBute2 range:NSMakeRange(2, coupon.length - 6)];
        [couponNameAttri addAttributes:attriBute1 range:NSMakeRange(coupon.length - 4, 4)];
        self.couponNameLabel.x = 46;
        self.couponNameLabel.y = 16;
        self.couponNameLabel.attributedText = couponNameAttri;
        [self.couponNameLabel sizeToFit];
        
        
        
    }else if (model.coupontype.integerValue == 2){
        //折扣券
//        float discout = model.denominat.floatValue * 10;
//         NSString *coupon = [NSString stringWithFormat:@"%1.f%@折 折扣券",discout,@"%@"];
    }
    
   
    
    if (!isVaild) {
<<<<<<< Updated upstream
        
=======
          self.instructionBtn.hidden = YES;
>>>>>>> Stashed changes
        if (model.status.integerValue == 3) {
            self.couponStatusLabel.text = @"已锁定";
        }else if (model.status.integerValue == 4) {
            self.couponStatusLabel.text = @"已使用";
        }else if (model.status.integerValue == 5){
            self.couponStatusLabel.text = @"已过期";
        }else if (model.status.integerValue == 2){
            //不可用，但是状态为已领取
            self.instructionBtn.hidden = NO;
            [self.instructionBtn setTitle:@"不可用说明" forState:UIControlStateNormal];
        }
         [self.couponStatusLabel sizeToFit];
        self.couponStatusLabel.centerY = self.couponNameLabel.centerY;
        self.couponStatusLabel.right = SCREEN_WIDTH - 48;
      
    }else{
<<<<<<< Updated upstream
        self.couponStatusLabel.text = nil;
=======
        self.instructionBtn.hidden = NO;
        [self.instructionBtn setTitle:@"使用说明" forState:UIControlStateNormal];
        if (_couponStatusLabel.superview) {
            [_couponStatusLabel removeFromSuperview];
        }
>>>>>>> Stashed changes
    }

    [self.instructionBtn sizeToFit];
    self.instructionBtn.right  = SCREEN_WIDTH - 48;
    self.instructionBtn.centerY = self.couponNameLabel.centerY;
    
    self.couponDescriptionLabel.textColor = isVaild ? LYZTheme_warmGreyFontColor : RGB(201, 201, 201);
    self.couponDescriptionLabel.text = model.couponDesc;
    [self.couponDescriptionLabel sizeToFit];
    self.couponDescriptionLabel.x = self.couponNameLabel.x;
    self.couponDescriptionLabel.y = self.couponNameLabel.bottom;
    self.deadlineLabel.textColor = isVaild ? LYZTheme_warmGreyFontColor : RGB(201, 201, 201);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *formatter_1 = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"yyyy.MM.dd"];
    NSDate *startDate = [formatter dateFromString:model.starttime];
    NSDate *endDate = [formatter dateFromString:model.endtime];
    NSString *startTime = [formatter_1 stringFromDate:startDate];
    NSString *endTime = [formatter_1 stringFromDate:endDate];
    self.deadlineLabel.text =[NSString stringWithFormat:@"有效期：%@至%@",startTime,endTime] ;
    [self.deadlineLabel sizeToFit];
    self.deadlineLabel.x = self.couponNameLabel.x;
    self.deadlineLabel.bottom = CouponCell.cellHeight - 15;
    
    self.scopeLabel.textColor = isVaild ? LYZTheme_paleBrown : RGB(201, 201, 201);
    self.scopeLabel.text = model.range;
    [self.scopeLabel sizeToFit];
    self.scopeLabel.centerY = self.deadlineLabel.centerY;
    self.scopeLabel.right = SCREEN_WIDTH - 48;
    
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _CouponCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _CouponCellHeight;
}


-(void)dealloc{
    LYLog(@"dealloc");
}

-(void)instruction:(UIButton *)sender{
    LYLog(@"clicked !!!!!  ");
    CouponViewController *vc = (CouponViewController *)self.controller;
     CouponModel *model = (CouponModel *)self.data;
    if ([vc respondsToSelector:@selector(announcement:)]) {
        [vc announcement:model];
    }
}


@end
