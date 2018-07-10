//
//  CheckInCommentViewController.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/2/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "CheckInCommentViewController.h"
#import "LoginManager.h"
#import "Public+JGHUD.h"
#import "NSDate+Formatter.h"
#import "PlaceHolderTextView.h"
#import "PointView.h"
#import "HXPhotoView.h"
#import "UIView+YYAdd.h"
@interface CheckInCommentViewController ()<UITextViewDelegate,HXPhotoViewDelegate>

@property (nonatomic, strong)  PlaceHolderTextView *textView;

@end

@implementation CheckInCommentViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    UINavigationController *nav = self.tabBarController.viewControllers[1];
    nav.navigationBarHidden = NO;
    [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"入住";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEEF0"];
    self.baseView.layer.cornerRadius = 8.0f;
    self.baseView.layer.masksToBounds = YES;
    self.baseView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.baseView.layer.shadowRadius = 8.0;
    self.baseView.layer.shadowOffset = CGSizeMake(0, 0);
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.timeLabel.bottom + 12, self.baseView.width, 0.5)];
    line1.backgroundColor = kLineColor;
    [self.baseView addSubview:line1];
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake((self.baseView.width - 250)/2.0 , self.timeLabel.bottom + 24, 250, 40) numberOfStars:5];
    self.starRateView.scorePercent = 1.0;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = YES;
    self.starRateView.needGesture = YES;
    [self.baseView addSubview:self.starRateView];
    
    UIView *line2 = [[UIView alloc]  initWithFrame:CGRectMake(0, self.starRateView.bottom + 12, self.baseView.width, 0.5)];
    line2.backgroundColor = kLineColor;
    [self.baseView addSubview:line2];
    self.textView = [[PlaceHolderTextView alloc] initWithFrame:CGRectMake(0, line2.bottom + 5, self.baseView.width, 160)];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = LYZTheme_BlackFontColorFontColor;
    self.textView.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.textView.scrollEnabled = NO;
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.placeholder = @"请输入您的评价";
    self.textView.placeholderColor = RGB(200, 200, 200);
    [self.baseView addSubview:self.textView];
    HXPhotoView *photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(0, self.textView.bottom,self.textView.width, 0) manager:self.manager];
    photoView.delegate = self;
    photoView.backgroundColor = [UIColor whiteColor];
    [self.baseView addSubview:photoView];
    [photoView refreshView];
    [self configUI];
    
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"%@",allList);
}
- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame
{
    self.baseView.size = CGSizeMake(self.baseView.width,CGRectGetMaxY(frame) + 12.0f);
}

-(void)configUI{
    self.hotelNameLabel.text = self.stayModel.hotelName;
    self.hotelRoomTypeLabel.text = self.stayModel.roomType;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter_1  = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"MM月dd日"];
    NSDate *checkIn = [formatter dateFromString:self.stayModel.checkInDate];
    NSDate *checkOut = [formatter dateFromString:self.stayModel.checkOutDate];
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",[formatter_1 stringFromDate:checkIn], [formatter_1 stringFromDate:checkOut]];
}

-(IBAction)comment:(id)sender{
    NSString *appUserID = [LoginManager instance].appUserID;
    if (!_textView.text || [_textView.text isEqualToString:@""] || [_textView.text isEqualToString:@"请填入我的意见"]) {
        [Public showJGHUDWhenError:self.view msg:@"请认真填写您的评价"];
        return;
    }
    
    NSNumber *score = [NSNumber numberWithFloat:self.starRateView.scorePercent * 5] ;
   
//    [[LYZNetWorkEngine sharedInstance] addComment:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID hotelID:self.stayModel.hotelID childOrderId:self.stayModel.childOrderId  orderNO:self.stayModel.orderNO  comments:self.textView.text satisFaction:score  block:^(int event, id object) {
//        if (event == 1) {
//            AddCommentResponse *response = (AddCommentResponse *)object;
//            NSString *point = [NSString stringWithFormat:@"积分 +%@",[((NSDictionary *)response.result) objectForKey:@"points"]] ;
//
//            PointViewMessageObject *messageObject = MakePointViewObject(@"iconIntegral",point , @"评论成功");
//            [PointView showAutoHiddenMessageViewInKeyWindowWithMessageObject:messageObject];
////             [Public showJGHUDWhenSuccess:self.view msg:@"感谢您的评价"];
//            [self performSelector:@selector(back:) withObject:nil afterDelay:2.1];
//        }
//
//    }];
}

-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
