//
//  HYNewFeatureCtr.m
//  NewAssemProduct
//
//  Created by why on 2017/1/3.
//  Copyright © 2017年 moreShare. All rights reserved.
//

#import "HYNewFeatureCtr.h"
#import "CABasicAnimation+Ext.h"

#pragma mark =============    定义    =============

NSString *const NewFeatureVersionKey = @"NewFeatureVersionKey";

#define DOT_WIDTH     11   //圆点宽度
#define DOT_HEIGHT    11   //圆点高度
#define DOTS_INTERVAL 10   //圆点空隙

#pragma mark =============    CoreArchive    =============

@interface CoreArchive : NSObject
/**
 *  保存普通字符串
 */
+ (void)setStr:(NSString *)str key:(NSString *)key;

/**
 *  读取
 */
+ (NSString *)strForKey:(NSString *)key;

@end


#pragma mark =============    NewFeatureScrollView    =============



@interface NewFeatureScrollView : UIScrollView

@end




#pragma mark =============    HYPageControl    =============

@interface HYPageControl : UIView

@property (nonatomic,assign)int currentPage;
@property (nonatomic,assign)int numberOfPages;
@property (nonatomic,strong)UIImage *dotImage;
@property (nonatomic,strong)UIImage *currentDotImage;

@end



#pragma mark =============    CoreArchive实现    =============

@implementation CoreArchive

// 保存普通对象
+ (void)setStr:(NSString *)str key:(NSString *)key{
	// 获取preference
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	// 保存
	[defaults setObject:str forKey:key];
	// 立即同步
	[defaults synchronize];
	
}

// 读取
+ (NSString *)strForKey:(NSString *)key{
	//获取preference
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//读取
	NSString *str=(NSString *)[defaults objectForKey:key];
	
	return str;
}

@end


#pragma mark =============    NewFeatureScrollView实现    =============

@implementation NewFeatureScrollView

- (instancetype)initWithFrame:(CGRect)frame{
	
	self = [super initWithFrame:frame];
	if(self){
		//视图准备
		[self viewPrepare];
	}
	return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder{
	self=[super initWithCoder:aDecoder];
	if(self){
		//视图准备
		[self viewPrepare];
	}
	return self;
}


// 视图准备
- (void)viewPrepare{
	
	//开启分页
	self.pagingEnabled = YES;
	
	//隐藏各种条
	self.showsHorizontalScrollIndicator = NO;
	self.showsVerticalScrollIndicator = NO;
	
	//取消boundce
	self.bounces = NO;
}

- (void)layoutSubviews{
	
	[super layoutSubviews];
	
	__block CGRect frame = self.bounds;
	
	__block NSUInteger count = 0;
	
	[self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
		
		if([subView isKindOfClass:[UIImageView class]]){
			
			CGFloat frameX = frame.size.width * idx;
			
			frame.origin.x = frameX;
			
			subView.frame = frame;
			
			count ++;
		}
	}];
	
	self.contentSize = CGSizeMake(frame.size.width * count, 0);
}

@end

#pragma mark =============    HYPageControl实现    =============


@implementation HYPageControl

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
	
	}
	return self;
}

- (void)setNumberOfPages:(int)numberOfPages
{
	if (numberOfPages == 0) return;
	//移除子视图
	[self removeSubViews:self];
	
	int offset_x = (self.bounds.size.width - (numberOfPages - 1)* DOTS_INTERVAL - numberOfPages * DOT_WIDTH)/2;
	//添加新视图
	for (int i=0; i < numberOfPages; i ++) {
		UIImageView *dot = [[UIImageView alloc] initWithFrame:CGRectMake(offset_x, (self.bounds.size.height - DOT_HEIGHT)/2, 7, 7)];
		[self addSubview:dot];
        dot.layer.cornerRadius = 7/2;
        dot.layer.masksToBounds = YES;
		offset_x += DOTS_INTERVAL + DOT_WIDTH;
	}
    
}

- (void)setCurrentPage:(int)currentPage
{
	NSArray *imageViews = [self subviews];
	for (int i=0; i < [imageViews count]; i ++) {
		UIImageView *dot = [imageViews objectAtIndex:i];
		dot.image = i == currentPage?self.currentDotImage:self.dotImage;
	}
}

//移除所有子视图
- (void)removeSubViews:(UIView *)superView
{
	for (UIView *subView in [superView subviews]) {
		[subView removeFromSuperview];
	}
}

@end


@interface HYNewFeatureCtr ()<UIScrollViewDelegate>
/** 模型数组 */
@property (nonatomic,strong) NSArray *imageNames;

/** scrollView */
@property (nonatomic,weak) NewFeatureScrollView *scrollView;

/** 播放器 */
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

/** 点 */
@property (nonatomic, strong) HYPageControl *pageControl;

/** 登录代码块 */
@property (nonatomic,copy) void(^enterBlock)();

@end

@implementation HYNewFeatureCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

// 控制器准备
- (UIButton *)vcPrepareDotImage:(NSString *)dotImage currentDotImage:(NSString *)currentDotImage{
	//添加scrollView
	NewFeatureScrollView *scrollView = [[NewFeatureScrollView alloc] init];
	scrollView.delegate = self;
	self.scrollView = scrollView;
	
	//添加
	[self.view addSubview:scrollView];
	
	//添加约束
	scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
	
	//添加底部的圆点
	CGFloat pageOriginY = kScreenHeight - 32;
	CGRect pageControlRect = CGRectMake(0, pageOriginY, kScreenWidth, 20);
	
	//	self.pageControl
	_pageControl = [[HYPageControl alloc] initWithFrame:pageControlRect];
	_pageControl.numberOfPages = _scrollView.contentSize.width / kScreenWidth;
    _pageControl.dotImage = [UIImage imageWithColor:[UIColor lightGrayColor]];
    _pageControl.currentDotImage = [UIImage imageWithColor:[UIColor whiteColor]];
	NSUInteger pageNum = self.imageNames.count;
	[_pageControl setNumberOfPages:(int)pageNum];
	[_pageControl setCurrentPage:0];
	
	[self.view insertSubview:_pageControl aboveSubview:_scrollView];
	//添加图片
	return [self imageViewsPrepare];
	
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGPoint offset = scrollView.contentOffset;
	CGRect bounds = scrollView.frame;
		
	[_pageControl setCurrentPage:offset.x/bounds.size.width];
	
    NSLog(@"%f",offset.x/bounds.size.width);
    
    if (offset.x/bounds.size.width == 4.000000) {
        
        self.pageControl.hidden = YES;
    }else{
        
        self.pageControl.hidden = NO;

    }
    
}




// 添加图片
- (UIButton *)imageViewsPrepare{
	
	[self.imageNames enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        
		UIImageView *imageV = [[UIImageView alloc] init];
		
		//设置图片
		imageV.image = [UIImage imageNamed:imageName];
		//记录tag
		imageV.tag = idx;
		
		[_scrollView addSubview:imageV];
		
		if(idx == self.imageNames.count - 1) {
            
			// 添加按钮 最后一个界面
			_enterButton = [self setUpEnterButton:imageV];
            
        }
	}];
	
	return _enterButton;
}

/** 初始化按钮 */
- (UIButton *)setUpEnterButton:(UIImageView *)imageView
{
	imageView.userInteractionEnabled = YES;
	UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[imageView addSubview:enterButton];
    
    [enterButton.layer addAnimation:[CABasicAnimation opacityForever_Animation:0.5] forKey:nil];

	[enterButton addTarget:self action:@selector(chickEnterButton) forControlEvents:UIControlEventTouchUpInside];
	return enterButton;
    
}

- (void)chickEnterButton
{
	[self dismiss];
}

- (void)dismiss{
	
	if(self.enterBlock != nil) _enterBlock();
}



// 显示了版本新特性，保存版本号
- (void)saveVersion{
	
	//系统直接读取的版本号
	NSString *versionValueStringForSystemNow=[[NSBundle mainBundle].infoDictionary valueForKey:(NSString *)kCFBundleVersionKey];
	
	//保存版本号
	[CoreArchive setStr:versionValueStringForSystemNow key:NewFeatureVersionKey];
	
}
// 监听通知
- (void)setUpNotification
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self.playerLayer.player.currentItem cancelPendingSeeks];
	[self.playerLayer.player.currentItem.asset cancelLoading];
}

#pragma mark - 初始化播放器
- (AVPlayerLayer *)playerWith:(NSURL *)URL
{
	if (_playerLayer == nil) {
		
		// 2.创建AVPlayerItem
		AVPlayerItem *item = [AVPlayerItem playerItemWithURL:URL];
		
		// 3.创建AVPlayer
		AVPlayer * player = [AVPlayer playerWithPlayerItem:item];
		
		// 4.添加AVPlayerLayer
		AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
		
		playerLayer.frame = self.view.bounds;
		[self.view.layer addSublayer:playerLayer];
		[player play];
	}
	return _playerLayer;
}



// 初始化滚动图片新特性界面
+ (instancetype)newFeatureVCWithImageNames:(NSArray *)imageNames dotImage:(NSString *)dotImage currentDotImage:(NSString *)currentDotImage enterBlock:(void(^)())enterBlock configuration:(void (^)(UIButton *enterButton))configurationBlock
{
	HYNewFeatureCtr *newFeatureVC = [[HYNewFeatureCtr alloc] init];
	
	newFeatureVC.imageNames = imageNames;
	
	//控制器准备
	configurationBlock([newFeatureVC vcPrepareDotImage:dotImage currentDotImage:currentDotImage]);
	
	//显示了版本新特性，保存版本号
	[newFeatureVC saveVersion];
	
	//记录block
	newFeatureVC.enterBlock = enterBlock;
	
	return newFeatureVC;
}


// 初始化视频新特性界面
+ (instancetype)newFeatureVCWithPlayerURL:(NSURL *)URL enterBlock:(void(^)())enterBlock configuration:(void (^)(AVPlayerLayer *playerLayer))configurationBlock
{
	HYNewFeatureCtr *newFeatureVC = [[HYNewFeatureCtr alloc] init];
	
	// 初始化播放器
	configurationBlock([newFeatureVC playerWith:URL]);
	
	// 监听通知
	[newFeatureVC setUpNotification];
	
	//显示了版本新特性，保存版本号
	[newFeatureVC saveVersion];
	
	//记录block
	newFeatureVC.enterBlock = enterBlock;
	
	return newFeatureVC;
}





// 是否应该显示版本新特性页面
+ (BOOL)canShowNewFeature{
//    if (![AFNetworkReachabilityManager sharedManager].reachable) {
//        return NO;
//    }
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow=[[NSBundle mainBundle].infoDictionary valueForKey:(NSString *)kCFBundleVersionKey];
    NSLog(@"LLLLLLL%@",[NSBundle mainBundle].infoDictionary);
    //读取本地版本号
    NSString *versionLocal = [CoreArchive strForKey:NewFeatureVersionKey];
    if(versionLocal!=nil && [versionValueStringForSystemNow isEqualToString:versionLocal]){//说明有本地版本记录，且和当前系统版本一致
        return NO;
    }else{ // 无本地版本记录或本地版本记录与当前系统版本不一致
        //保存
        [CoreArchive setStr:versionValueStringForSystemNow key:NewFeatureVersionKey];
        return YES;
    }
}
@end
