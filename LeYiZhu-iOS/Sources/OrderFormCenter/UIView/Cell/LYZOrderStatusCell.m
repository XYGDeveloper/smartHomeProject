//
//  LYZOrderStatusCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderStatusCell.h"
#import "BaseOrderDetailModel.h"
#import "LYZOrderFormViewController.h"

#define kStatusTitleKey @"sTitlekey"
#define kStatusColorKey @"sColorkey"
#define kStatusBtnTitleKey @"sBtnTitleKey"
#define kWaitPayColor  [UIColor colorWithHexString:@"#d0021b"]
#define kwaitCheckInColor   [UIColor colorWithHexString:@"#e6853a"]
#define kCheckInColor   [UIColor colorWithHexString:@"#7387bc"]

@interface LYZOrderStatusCell ()

@property(nonatomic, strong) UILabel *statusLabel;
@property(nonatomic, strong) UIButton *cancelBtn;

@end

static CGFloat _OrderStatusCellHeight = 50.0f;

@implementation LYZOrderStatusCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace , 0, 90, LYZOrderStatusCell.cellHeight )];
    self.statusLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:18];
    [self addSubview:self.statusLabel];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 88, (LYZOrderStatusCell.cellHeight - 21)/2.0, 88, 22);
    self.cancelBtn.layer.cornerRadius = 11.0f;
    self.cancelBtn.layer.borderWidth = 0.5;
    self.cancelBtn.layer.borderColor = LYZTheme_paleBrown.CGColor;
    [self.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self.cancelBtn addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    self.cancelBtn.hidden = YES;
    
}


- (void)loadContent {
    
    if ([self.data isKindOfClass:[BaseOrderDetailModel class]]) {
        BaseOrderDetailModel *model = (BaseOrderDetailModel *)self.data;
        if (model.orderJson.hostStatus.integerValue == 1) {
            if (model.orderJson.childStatus.integerValue == 0) {
                self.cancelBtn.hidden = NO;
            }else{
                self.cancelBtn.hidden = YES;
            }
        }else{
            self.cancelBtn.hidden = YES;
        }
        
        if (model.orderJson.hostStatus.integerValue == 1) {
            self.statusLabel.textColor = [[self getStatusTextAndTextColor:model.orderJson.childStatus.integerValue] objectForKey:kStatusColorKey];
            self.statusLabel.text = [[self getStatusTextAndTextColor:model.orderJson.childStatus.integerValue] objectForKey:kStatusTitleKey];
        }else if (model.orderJson.hostStatus.integerValue == 0){
            self.statusLabel.textColor = LYZTheme_warmGreyFontColor;
             self.statusLabel.text = @"已取消";
        }
        
        if ([model.orderJson.isCancel isEqualToString:@"Y"]) {
            self.cancelBtn.hidden = NO;
        }else{
            self.cancelBtn.hidden = YES;
        }
    }
}



- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderStatusCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderStatusCellHeight;
}


#pragma mark --Private method


-(NSDictionary *)getStatusTextAndTextColor:(NSInteger)status{
    NSDictionary *dic = nil;
    switch (status) {
        case 0:
            dic = @{kStatusTitleKey:@"待支付",kStatusColorKey:kWaitPayColor,kStatusBtnTitleKey:@"立即支付"};
            break;
        case 1:
            dic = @{kStatusTitleKey:@"待入住",kStatusColorKey:kwaitCheckInColor,kStatusBtnTitleKey:@"酒店地址"};
            break;
        case 2:
            dic = @{kStatusTitleKey:@"已入住",kStatusColorKey:kCheckInColor,kStatusBtnTitleKey:@"续住"};
            break;
        case 3:
            dic = @{kStatusTitleKey:@"已入住",kStatusColorKey:LYZTheme_warmGreyFontColor,kStatusBtnTitleKey:@"续住"};
            break;
        case 4:
            dic = @{kStatusTitleKey:@"已退房",kStatusColorKey:LYZTheme_warmGreyFontColor,kStatusBtnTitleKey:@"重新预订"};
            break;
        default:
            break;
    }
    return dic;
}

-(void)cancelOrder:(id)sender{
    
    NSString *orderNo = nil;
    NSString *orderType;
    if ([self.data isKindOfClass:[BaseOrderDetailModel class]]) {
        BaseOrderDetailModel *model = (BaseOrderDetailModel *)self.data;
        orderNo = model.orderJson.orderNO;
        orderType = [NSString stringWithFormat:@"%@",model.orderJson.orderType];
        LYZOrderFormViewController *vc = (LYZOrderFormViewController *)self.controller;
        if ([vc respondsToSelector:@selector(cancelOrder:orderType:)]) {
            [vc cancelOrder:orderNo orderType:orderType];
        }
    }
   
}


-(void)dealloc{
    LYLog(@"dealloc");
}


@end
