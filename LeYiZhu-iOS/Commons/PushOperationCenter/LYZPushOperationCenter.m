//
//  LYZPushOperationCenter.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/27.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZPushOperationCenter.h"
#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "LYZOrderFormViewController.h"
#import "GCD.h"
#import "LYZAdView.h"
#import "CouponViewController.h"
#import "Public+JGHUD.h"
#import "LoginManager.h"

@interface LYZPushOperationCenter ()

//
// The microphone used to get input.
//
@property (nonatomic,strong) EZMicrophone *microphone;

//
// Used to calculate a rolling FFT of the incoming audio data.
//
@property (nonatomic, strong) EZAudioFFTRolling *fft;

@property (nonatomic, assign) NSInteger targetFreqency;
@property (nonatomic ,copy) NSString *roomID;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int count;


@end

static vDSP_Length const FFTViewControllerFFTWindowSize = 4096;

@implementation LYZPushOperationCenter


+ (instancetype)instance
{
    static LYZPushOperationCenter *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYZPushOperationCenter alloc] init];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _count = 0;
    }
    return self;
}

-(void)pushCouponToUser:(NSString *)imgUrl{
    NSString *imgName = nil;
    NSString  *h5Url                =  nil;
    actionType type               =  couponType;
    [GCDQueue executeInMainQueue:^{
        AdViewMessageObject *messageObject = MakeAdViewObject(imgUrl, imgName,h5Url, type, YES);
        [LYZAdView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:1002];
    }];
}

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
    [messageView hide];
    if (messageView.tag == 1002){
        AdViewMessageObject *object = (AdViewMessageObject *)event;
        if (object.type == couponType) {
            if (object.canClick) {
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                BaseTabBarController *tab =(BaseTabBarController*) delegate.rootTab;
                CouponViewController *vc = [[CouponViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [tab.selectedViewController pushViewController:vc  animated:YES];
                
            }
        }
    }
}


-(void)handleCode:(NSString *)code{
    
    AppDelegate *delegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
    BaseTabBarController *tab =(BaseTabBarController*) delegate.rootTab;
    [tab setSelectedIndex:1];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationStayPlanList object:self userInfo:nil];
}

-(void)jumpToTargetWithOrderNo:(NSString *)orderNo orderType:(NSString *)orderType{
    AppDelegate *delegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
    BaseTabBarController *tab =(BaseTabBarController*) delegate.rootTab;
    LYZOrderFormViewController *vc = [[LYZOrderFormViewController alloc] init];
    vc.orderNo = orderNo;
    vc.orderType = orderType;
    [tab.viewControllers[0] pushViewController:vc  animated:YES];
    
}

-(void)beginGetCurrentSoundFrequecy:(NSDictionary *)info{
      self.count = 0;
    //反馈服务器 收到极光推送通知 带上极光推送id
    NSString *jpushID = info[@"jpushlogid"];
    [[LYZNetWorkEngine sharedInstance] confirmJPushWithPushID:jpushID block:^(int event, id object) {
        //给后台一个反馈，不需要其他操作
    }];
    
    NSString *isAutoOpen = [IICommons getPersistenceDataWithKey:kAutoOpenDoorKey];
    if (!isAutoOpen || ![isAutoOpen isEqualToString:@"Y"]) {
        return;
    }
    
    NSString *targetFrequencyStr = info[@"swtWaveformCode"];
    self.roomID = info[@"roomID"];
    NSString *frontStr = [targetFrequencyStr substringToIndex:2];
    NSString *endStr = [targetFrequencyStr substringWithRange:NSMakeRange(2, 2)];
    NSNumber *targetFrequencyNum = [IICommons numberHexString:[NSString stringWithFormat:@"%@%@",endStr,frontStr]];
    self.targetFreqency = targetFrequencyNum.integerValue;
    
#ifdef OpenIndicator
     AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd HH:mm:ss"];
    del.indicatorView.TnotificationLabel.text = [formatter stringFromDate:[NSDate date]];
    del.indicatorView.CnoitificationLabel.text = [NSString stringWithFormat:@"目标频率:%ld",(long)self.targetFreqency];
#endif
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error)
    {
        NSLog(@"Error setting up audio session category: %@", error.localizedDescription);
    }
    [session setActive:YES error:&error];
    if (error){
        NSLog(@"Error setting up audio session active: %@", error.localizedDescription);
    }
    
       self.microphone = [EZMicrophone microphoneWithDelegate:self];
    
    //
    // Create an instance of the EZAudioFFTRolling to keep a history of the incoming audio data and calculate the FFT.
    //
    self.fft = [EZAudioFFTRolling fftWithWindowSize:FFTViewControllerFFTWindowSize
                                         sampleRate:self.microphone.audioStreamBasicDescription.mSampleRate
                                           delegate:self];
    
    //
    // Start the mic
    //
    [self.microphone startFetchingAudio];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 *60 target:self selector:@selector(stopGetFreqency) userInfo:nil repeats:NO];
    
}

-(void)stopGetFreqency{
    [self.microphone stopFetchingAudio];
#ifdef OpenIndicator
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd HH:mm:ss"];
    del.indicatorView.TOutTimeLabel.text = [formatter stringFromDate:[NSDate date]];
    del.indicatorView.COutTimeLabel.text = @"超过5分钟未处理";
#endif
    
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - EZMicrophoneDelegate
//------------------------------------------------------------------------------

-(void)    microphone:(EZMicrophone *)microphone
     hasAudioReceived:(float **)buffer
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
{
    //
    // Calculate the FFT, will trigger EZAudioFFTDelegate
    //
    [self.fft computeFFTWithBuffer:buffer[0] withBufferSize:bufferSize];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
    });
}

//------------------------------------------------------------------------------
#pragma mark - EZAudioFFTDelegate
//------------------------------------------------------------------------------

- (void)        fft:(EZAudioFFT *)fft
 updatedWithFFTData:(float *)fftData
         bufferSize:(vDSP_Length)bufferSize
{
    
    float maxFrequency = [fft maxFrequency];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [GCDQueue executeInMainQueue:^{
#ifdef OpenIndicator
        del.indicatorLabel.text = [NSString stringWithFormat:@"Frequency: %.2f", maxFrequency];
#endif
    }];
    if (_count == 0) { //确保只执行一次
        if (maxFrequency >= self.targetFreqency - 100 && maxFrequency <= self.targetFreqency + 100 ) {
            [_timer invalidate];
            _timer = nil;
#ifdef OpenIndicator
             [GCDQueue executeInMainQueue:^{
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd HH:mm:ss"];
            del.indicatorView.TmatchLabel.text = [formatter stringFromDate:[NSDate date]];
            del.indicatorView.CmatchLabel.text = @"匹配成功";
                  }];
#endif
            //先关闭
            [self.microphone stopFetchingAudio];
            self.count ++;
            NSString *userID = [LoginManager instance].appUserID;
            
            [[LYZNetWorkEngine sharedInstance] openKey:VersionCode devicenum:DeviceNum fromtype:FromType roomID:self.roomID  appUserID:userID pactVersion:@"1.0"  block:^(int event, id object) {
                if (event == 1) {
                    [GCDQueue executeInMainQueue:^{
                        NSLog(@"Open The Door------>!!!!!");
//                                                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"开锁成功" message:@" Door opened" preferredStyle:(UIAlertControllerStyleAlert)];
//                                                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//                        
//                                                }];
//                                                [alertC addAction:alertA];
                        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        [Public showJGHUDWhenSuccess:del.window msg:@"开锁成功"];
#ifdef OpenIndicator
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        [formatter setDateFormat:@"dd HH:mm:ss"];
                        del.indicatorView.TOpenDoorLabel.text = [formatter stringFromDate:[NSDate date]];
                        del.indicatorView.COpenDooLabel.text = @"开锁成功";
#endif
                        //                        [del.rootTab presentViewController:alertC animated:YES completion:nil];
                    }];
                }else{
                    [Public showJGHUDWhenError:del.window msg:@"服务器异常"];
//                    //如果失败再打开
//                    [self.microphone startFetchingAudio];
#ifdef OpenIndicator
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"dd HH:mm:ss"];
                    del.indicatorView.TOpenDoorLabel.text = [formatter stringFromDate:[NSDate date]];
                    del.indicatorView.COpenDooLabel.text = object;
#endif
                }
            }];
        }
    }
    
   
    
    
//    NSString *noteName = [EZAudioUtilities noteNameStringForFrequency:maxFrequency
//                                                        includeOctave:YES];
    LYLog(@"frequecy is %.2f",maxFrequency);
    
//    __weak typeof (self) weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        weakSelf.maxFrequencyLabel.text = [NSString stringWithFormat:@"Highest Note: %@,\nFrequency: %.2f", noteName, maxFrequency];
//        [weakSelf.audioPlotFreq updateBuffer:fftData withBufferSize:(UInt32)bufferSize];
//    });
}

@end
