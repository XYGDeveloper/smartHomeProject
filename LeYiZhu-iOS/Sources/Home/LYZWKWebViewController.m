//
//  ViewController.m
//  WKWebViewDemo
//
//  Created by hujunhua on 2016/11/17.
//  Copyright © 2016年 hujunhua. All rights reserved.
//

#import "LYZWKWebViewController.h"
#import <WebKit/WebKit.h>
#import "LYZSearchController.h"
#import "LYZHotelViewController.h"
#import "UIViewController+TFModalView.h"
#import "GCD.h"
#import "LYZWKDelegateViewController.h"


static CGFloat addViewHeight = 500;   // 添加自定义 View 的高度
static BOOL showAddView = NO;        // 是否添加自定义 View
static BOOL useEdgeInset = NO;        // 用哪种方法添加自定义View， NO 使用 contentInset，YES 使用 div

@interface LYZWKWebViewController ()<
    WKNavigationDelegate,
    WKUIDelegate,
    UIScrollViewDelegate,
    WKScriptMessageHandler,
    WKDelegate
>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) CGFloat delayTime;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) UIView *addView;
@property (nonatomic, strong)  UIButton *rightButton;
@property (nonatomic, assign) BOOL isCancel;
@property (nonatomic,weak)UIViewController *searchVC;
@end

@implementation LYZWKWebViewController

#pragma mark - Life Cycle

-(instancetype)init{
    if (self= [super init]) {
        self.type = iNoneType;
    }
    return self;
}

// 用来测试的一些url链接
- (NSURL *)testurl {
    NSString *encodedString = [self.strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedString];
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    NSURL *url = [NSURL URLWithString:@"https://github.com/"];
//    NSURL *url = [NSURL URLWithString:@"https://z.yeemiao.com/share/share.html"]; // 自建证书，在iOS8下面，无法通过验证
    return url;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.view.backgroundColor = LYZTheme_BackGroundColor;
    
    [self configWKWebView];
    if (self.type != iNoneType) {
         [self setRightButton];
    }
   
    self.isCancel = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self setBackBtn];
}


-(void)setBackBtn{
    UIImage * leftImg = [[UIImage imageNamed:@"icon_returned"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftNavItem = [[UIBarButtonItem alloc] initWithImage:leftImg style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = -30;
    
    UIImage * leftImg2 = [[UIImage imageNamed:@"icon_webclose"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftNavItem2 = [[UIBarButtonItem alloc] initWithImage:leftImg2 style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    
    self.navigationItem.leftBarButtonItems =@[ leftNavItem,fixedSpaceBarButtonItem,leftNavItem2];
}

- (void)setRightButton{
    
//    self.title = @"乐易住";
    
   
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.rightButton.frame = CGRectMake(0, 0,70, 30);
    
    self.rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [self.rightButton setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
    
    [self.rightButton setTitle:@"立即预订" forState:UIControlStateNormal];
    
    [self.rightButton addTarget:self action:@selector(toBookRoom:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = - 10;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
}

-(void)toBookRoom:(id)sender{
    if (self.type == iRecommendType) {
        LYZHotelViewController *vc = [[LYZHotelViewController alloc] init];
        vc.i_hotelId = self.hotelID;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (self.searchVC) {
            return;
        }
        LYZSearchController *vc = [LYZSearchController new];
        [self showTFModalViewControllerWithController:vc AndShowScale:0.7 AndShowDirection:TFModalViewControllerShowDirectionFromTop WithShowCompletionBlock:^{
            self.searchVC = vc;
        }];
        
    }
    
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"reservenow"];
}


-(void)configWKWebView{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    // 支持内嵌视频播放，不然网页中的视频无法播放
    config.allowsInlineMediaPlayback = YES;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64) configuration:config];
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.webView];
    self.webView.scrollView.delegate = self;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    // 开始右滑返回手势
    self.webView.allowsBackForwardNavigationGestures = YES;
    
    
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    [self.view addSubview:self.progressView];
    self.progressView.progressTintColor =LYZTheme_paleBrown;
    self.progressView.trackTintColor = [UIColor clearColor];
    
    NSKeyValueObservingOptions observingOptions = NSKeyValueObservingOptionNew;
    // KVO 监听属性，除了下面列举的两个，还有其他的一些属性，具体参考 WKWebView 的头文件
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:observingOptions context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:observingOptions context:nil];
    
    // 监听 self.webView.scrollView 的 contentSize 属性改变，从而对底部添加的自定义 View 进行位置调整
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:observingOptions context:nil];
    // 交互对象设置
    
    LYZWKDelegateViewController * delegateController = [[LYZWKDelegateViewController alloc] init];
    delegateController.delegate = self;
     [self.webView.configuration.userContentController addScriptMessageHandler:delegateController name:@"reservenow"];
    NSURL *url = [self testurl];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress < 1.0) {
            self.delayTime = 1 - self.webView.estimatedProgress;
            return;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.progress = 0;
        });
    } else if ([keyPath isEqualToString:@"title"]) {
//        self.navigationItem.title = self.webView.title && ![self.webView.title isEqualToString:@""] ? self.webView.title : @"乐易住";
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        if (self.contentHeight != self.webView.scrollView.contentSize.height) {
            self.contentHeight = self.webView.scrollView.contentSize.height;
            self.addView.frame = CGRectMake(0, self.contentHeight - addViewHeight, SCREEN_WIDTH, addViewHeight);
            NSLog(@"----------%@", NSStringFromCGSize(self.webView.scrollView.contentSize));
        }
    }
}



#pragma mark - WKNavigationDelegate

// 开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation   ====    %@", navigation);
}

// 页面加载完调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"didFinishNavigation   ====    %@", navigation);
    
    if (!showAddView) return;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self.webView.scrollView addSubview:self.addView];
        
        if (useEdgeInset) {
            // url 使用 test.html 对比更明显
            self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, addViewHeight, 0);
        } else {
            NSString *js = [NSString stringWithFormat:@"\
                            var appendDiv = document.getElementById(\"AppAppendDIV\");\
                            if (appendDiv) {\
                            appendDiv.style.height = %@+\"px\";\
                            } else {\
                            var appendDiv = document.createElement(\"div\");\
                            appendDiv.setAttribute(\"id\",\"AppAppendDIV\");\
                            appendDiv.style.width=%@+\"px\";\
                            appendDiv.style.height=%@+\"px\";\
                            document.body.appendChild(appendDiv);\
                            }\
                            ", @(addViewHeight), @(SCREEN_WIDTH), @(addViewHeight)];
            [self.webView evaluateJavaScript:js completionHandler:^(id value, NSError *error) {
                // 执行完上面的那段 JS, webView.scrollView.contentSize.height 的高度已经是加上 div 的高度
                self.addView.frame = CGRectMake(0, self.webView.scrollView.contentSize.height - addViewHeight, SCREEN_WIDTH, addViewHeight);
            }];
        }
    });
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation   ====    %@\nerror   ====   %@", navigation, error);
}

// 内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"didCommitNavigation   ====    %@", navigation);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationAction   ====    %@", navigationAction);
    if (navigationAction.navigationType==WKNavigationTypeBackForward) {                  //判断是返回类型
        if (webView.backForwardList.backList.count>0) {                                  //得到栈里面的list
            //            WKBackForwardListItem * item = webView.backForwardList.currentItem;          //得到现在加载的list
            //            for (WKBackForwardListItem * backItem in webView.backForwardList.backList) { //循环遍历，得到你想退出到
            //                //添加判断条件
            //                [webView goToBackForwardListItem:[webView.backForwardList.backList firstObject]];
            //            }
            [webView goBack];
        }
    }
    
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationResponse   ====    %@", navigationResponse);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 加载 HTTPS 的链接，需要权限认证时调用  \  如果 HTTPS 是用的证书在信任列表中这不要此代理方法
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

#pragma mark - WKUIDelegate

// 提示框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
        textField.placeholder = defaultText;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.webView evaluateJavaScript:@"parseFloat(document.getElementById(\"AppAppendDIV\").style.width);" completionHandler:^(id value, NSError * _Nullable error) {
        NSLog(@"======= %@", value);
    }];
}

#pragma mark -- WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:message.body];
    NSLog(@"JS交互参数：%@", dic);
    
    if ([message.name isEqualToString:@"reservenow"] ) {
        
        NSLog(@"currentThread  ------   %@", [NSThread currentThread]);
        [self reservenow];
        
    } else {
        return;
    }
}

-(void)reservenow{
    [GCDQueue executeInMainQueue:^{
        if (self.type == iRecommendType) {
            LYZHotelViewController *vc = [[LYZHotelViewController alloc] init];
            vc.i_hotelId = self.hotelID;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            [self.rightButton setTitle:@"立即预订" forState:UIControlStateNormal];
            self.isCancel = YES;
            if (self.searchVC) {
                return;
            }
            LYZSearchController *vc = [LYZSearchController new];
            [self showTFModalViewControllerWithController:vc AndShowScale:0.7 AndShowDirection:TFModalViewControllerShowDirectionFromTop WithShowCompletionBlock:^{
                self.searchVC = vc;
            }];
        }
    }];
}


#pragma mark - Setter & Getter



- (UIView *)addView {
    if (!_addView) {
        _addView = [[UIView alloc] init];
        _addView.backgroundColor = [UIColor redColor];
    }
    return _addView;
}

// UIWebView 使用的权限认证方式，
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    if ([navigationAction.request.URL.absoluteString containsString:@"https://"] && IOSVersion < 9.0 && !self.httpsAuth) {
//        self.originRequest = navigationAction.request;
//        self.httpsUrlConnection = [[NSURLConnection alloc] initWithRequest:self.originRequest delegate:self];
//        [self.httpsUrlConnection start];
//        decisionHandler(WKNavigationActionPolicyCancel);
//        return;
//    }
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//    if ([challenge previousFailureCount] == 0) {
//        self.httpsAuth = YES;
//        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
//    } else {
//        [[challenge sender] cancelAuthenticationChallenge:challenge];
//    }
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    self.httpsAuth = YES;
//    [self.webView loadRequest:self.originRequest];
//    [self.httpsUrlConnection cancel];
//}
//
//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
//    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
//}

-(void)back:(UIButton *)sender{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)close:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end




















































