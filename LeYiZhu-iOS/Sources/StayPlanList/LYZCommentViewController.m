//
//  LYZCommentViewController.m
//  LeYiZhu-iOS
//
//  Created by L on 2018/1/19.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "LYZCommentViewController.h"
#import "LoginManager.h"
#import "Public+JGHUD.h"
#import "NSDate+Formatter.h"
#import "PlaceHolderTextView.h"
#import "PointView.h"
#import "PlaceHolderTextView.h"
#import "HXPhotoPicker.h"
#import "Masonry.h"
#import "LYZImaageUploaderManager.h"
#import "LYZImageModel.h"
@interface LYZCommentViewController ()<UITextViewDelegate,HXPhotoViewDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)UIScrollView  *contentView;
@property (nonatomic, strong)  PlaceHolderTextView *textView;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
@property (strong, nonatomic) UIButton *commitButton;
@property (strong, nonatomic) UIView *bootomView;
@property (strong, nonatomic) NSArray *images;

@end

@implementation LYZCommentViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    UINavigationController *nav = self.tabBarController.viewControllers[1];
    nav.navigationBarHidden = NO;
    [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEEF0"];
    UIScrollView *contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(12.5, 64, kScreenWidth - 25,470)];
    contentView.alwaysBounceVertical = YES;
    [self.view addSubview:contentView];
    self.contentView = contentView;
    self.contentView.layer.cornerRadius = 8.0f;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowRadius = 8.0;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.roomName = [[UILabel alloc]initWithFrame:CGRectMake(20, 24,self.contentView.width - 40 , 30)];
    self.roomName.textAlignment = NSTextAlignmentCenter;
    self.roomName.textColor = LYZTheme_BlackFontColorFontColor;
    self.roomName.font = [UIFont fontWithName:LYZTheme_Font_Regular size:17];
    [self.contentView addSubview:self.roomName];
    
    self.roomType = [[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(self.roomName.frame)+10,self.contentView.width - 40 , 25)];
    self.roomType.textAlignment = NSTextAlignmentCenter;
    self.roomType.textColor = LYZTheme_warmGreyFontColor;
    self.roomType.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    [self.contentView addSubview:self.roomType];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(self.roomType.frame)+20,self.contentView.width - 40 , 25)];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = LYZTheme_warmGreyFontColor;
    self.timeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    [self.contentView addSubview:self.timeLabel];
    
    self.baseLine = [[UILabel alloc]initWithFrame:CGRectMake(0.5,CGRectGetMaxY(self.timeLabel.frame)+20,self.contentView.width - 1 , 0.5)];
    self.baseLine.backgroundColor = kLineColor;
    [self.contentView addSubview:self.baseLine];
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake((self.contentView.width - 250)/2.0 , self.baseLine.bottom + 24, 250, 40) numberOfStars:5];
    self.starRateView.scorePercent = 1.0;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = YES;
    self.starRateView.needGesture = YES;
    [self.contentView addSubview:self.starRateView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.5,CGRectGetMaxY(self.starRateView.frame)+24,self.contentView.width - 1 , 0.5)];
    label.backgroundColor = kLineColor;
    [self.contentView addSubview:label];
    
    self.textView = [[PlaceHolderTextView alloc] initWithFrame:CGRectMake(0, label.bottom + 5, self.contentView.width, 110)];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.delegate = self;
    self.textView.textColor = LYZTheme_BlackFontColorFontColor;
    self.textView.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.textView.scrollEnabled = NO;
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.returnKeyType = UIReturnKeyDone;//改变为完成键，如果在项目中导入了YYText框架那么原生的就被替换掉了，变为returnKeyType = UIKeyboardTypeTwitter;

    self.textView.placeholder = @"请输入您的评价";
    self.textView.placeholderColor = RGB(200, 200, 200);
    [self.contentView addSubview:self.textView];
    
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(5, CGRectGetMaxY(self.textView.frame),self.contentView.width-10, 0);
    photoView.delegate = self;
    photoView.outerCamera = YES;
    photoView.lineCount = 4;
    photoView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:photoView];
    self.photoView = photoView;
    self.bootomView = [[UIView alloc]initWithFrame:CGRectMake(12.5, CGRectGetMaxY(self.contentView.frame)-10, kScreenWidth - 25,60)];
    self.bootomView.backgroundColor = [UIColor whiteColor];
    self.bootomView.layer.cornerRadius = 8.0f;
    self.bootomView.layer.masksToBounds = YES;
    self.bootomView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bootomView.layer.shadowRadius = 8.0;
    self.bootomView.layer.shadowOffset = CGSizeMake(0, 0);
    [self.view addSubview:self.bootomView];
    self.commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitButton.backgroundColor = LYZTheme_paleBrown;
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.bootomView addSubview:self.commitButton];
    [self.commitButton addTarget:self action:@selector(toCommit:) forControlEvents:UIControlEventTouchUpInside];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(self.bootomView.width);
        make.bottom.mas_equalTo(self.bootomView.mas_bottom).mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self configUI];
    // Do any additional setup after loading the view.
}

-(void)configUI{
    self.roomName.text = self.stayModel.hotelName;
    self.roomType.text = self.stayModel.roomType;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter_1  = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"MM月dd日"];
    NSDate *checkIn = [formatter dateFromString:self.stayModel.checkInDate];
    NSDate *checkOut = [formatter dateFromString:self.stayModel.checkOutDate];
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",[formatter_1 stringFromDate:checkIn], [formatter_1 stringFromDate:checkOut]];
}

- (void)toCommit:(UIButton *)button{
    
    NSString *appUserID = [LoginManager instance].appUserID;
    if (!_textView.text || [_textView.text isEqualToString:@""] || [_textView.text isEqualToString:@"请填入我的意见"]) {
        [Public showJGHUDWhenError:self.view msg:@"请认真填写您的评价"];
        return;
    }
    
    NSNumber *score = [NSNumber numberWithFloat:self.starRateView.scorePercent * 5] ;

    if (self.images) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [LYZImaageUploaderManager uploadImgs:self.images withResult:^(id imgs) {
            LYLog(@"imgs is ----> %@",imgs);
            NSArray *imageArray = (NSArray *)imgs;
            [[LYZNetWorkEngine sharedInstance] addComment:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID hotelID:self.stayModel.hotelID childOrderId:self.stayModel.childOrderId orderNO:self.stayModel.orderNO comments:self.textView.text satisFaction:score images:imageArray block:^(int event, id object) {
                if (event == 1) {
                    AddCommentResponse *response = (AddCommentResponse *)object;
                    NSString *point = [NSString stringWithFormat:@"积分 +%@",[((NSDictionary *)response.result) objectForKey:@"points"]] ;
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                        // Do something...
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                        });
                    });
                    
                    PointViewMessageObject *messageObject = MakePointViewObject(@"iconIntegral",point , @"评论成功");
                    [PointView showAutoHiddenMessageViewInKeyWindowWithMessageObject:messageObject];
                    //             [Public showJGHUDWhenSuccess:self.view msg:@"感谢您的评价"];
                    [self performSelector:@selector(back:) withObject:nil afterDelay:2.1];
                }else{
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                        // Do something...
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                        });
                    });                }
            }];
        }];
    }else{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [[LYZNetWorkEngine sharedInstance] addComment:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID hotelID:self.stayModel.hotelID childOrderId:self.stayModel.childOrderId orderNO:self.stayModel.orderNO comments:self.textView.text satisFaction:score images:@[] block:^(int event, id object) {
            if (event == 1) {
                AddCommentResponse *response = (AddCommentResponse *)object;
                NSString *point = [NSString stringWithFormat:@"积分 +%@",[((NSDictionary *)response.result) objectForKey:@"points"]] ;
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    // Do something...
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                });
                PointViewMessageObject *messageObject = MakePointViewObject(@"iconIntegral",point , @"评论成功");
                [PointView showAutoHiddenMessageViewInKeyWindowWithMessageObject:messageObject];
                //             [Public showJGHUDWhenSuccess:self.view msg:@"感谢您的评价"];
                [self performSelector:@selector(back:) withObject:nil afterDelay:2.1];
            }else{
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    // Do something...
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                });
            }
        }];
    }
  
   
  
    
}

-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.openCamera = YES;
        _manager.configuration.lookLivePhoto = YES;
        _manager.configuration.photoMaxNum = 9;
        _manager.configuration.videoMaxNum = 1;
        _manager.configuration.maxNum = 10;
        _manager.configuration.videoMaxDuration = 500.f;
        _manager.configuration.saveSystemAblum = NO;
        //        _manager.configuration.reverseDate = YES;
        _manager.configuration.showDateSectionHeader = NO;
        _manager.configuration.selectTogether = NO;
        _manager.configuration.rowCount = 4;
        //        _manager.configuration.movableCropBox = YES;
        //        _manager.configuration.movableCropBoxEditSize = YES;
        //        _manager.configuration.movableCropBoxCustomRatio = CGPointMake(1, 1);
        
        __weak typeof(self) weakSelf = self;
        //        _manager.configuration.replaceCameraViewController = YES;
        _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager) {
            
            // 这里拿使用系统相机做例子
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
            NSString *requiredMediaTypeImage = ( NSString *)kUTTypeImage;
            NSString *requiredMediaTypeMovie = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes;
            if (cameraType == HXPhotoConfigurationCameraTypePhoto) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage,nil];
            }else if (cameraType == HXPhotoConfigurationCameraTypeVideo) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeMovie,nil];
            }else {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediaTypeMovie,nil];
            }
            [imagePickerController setMediaTypes:arrMediaTypes];
            // 设置录制视频的质量
            [imagePickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [imagePickerController setVideoMaximumDuration:60.f];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    HXPhotoModel *model;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        model = [HXPhotoModel photoModelWithImage:image];
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools savePhotoToCustomAlbumWithName:self.manager.configuration.customAlbumName photo:model.thumbPhoto];
        }
    }else  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *url = info[UIImagePickerControllerMediaURL];
        NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                         forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
        float second = 0;
        second = urlAsset.duration.value/urlAsset.duration.timescale;
        model = [HXPhotoModel photoModelWithVideoURL:url videoTime:second];
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools saveVideoToCustomAlbumWithName:self.manager.configuration.customAlbumName videoURL:url];
        }
    }
    if (self.manager.configuration.useCameraComplete) {
        self.manager.configuration.useCameraComplete(model);
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didNavBtnClick {
    [self.photoView goPhotoViewController];
}

//- (void)photoViewCurrentSelected:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal{
//    NSMutableArray *images = [NSMutableArray array];
//    for (HXPhotoModel *model in allList) {
//        UIImage *image = model.previewPhoto;
//        [images addObject:image];
//    }
//    self.images = images;
//
//    NSLog(@"%@",self.images);
//
//}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    if([text  isEqualToString:@"\n"])
    {
        [textView  resignFirstResponder];
        return NO;
    }
    return YES;
}

//点击空白处回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event

{
    [self.view endEditing:YES];
}
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
  
    [self.toolManager getSelectedImageList:allList success:^(NSArray<UIImage *> *imageList) {
        self.images = imageList;
    } failed:^{
        
    }];

}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.contentView.contentSize = CGSizeMake(self.contentView.frame.size.width, CGRectGetMaxY(frame) + 5);
    
}
@end
