//
//  LYZCommentListViewController.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/19.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import "LYZCommentListViewController.h"
#import "LYZCommentDetailViewController.h"
#import "Masonry.h"
#import "HXTagsView.h"
#import "LYZCommentListCellTableViewCell.h"
#import "Masonry.h"
#import "GCD.h"
#import "MJRefresh.h"
#import "EmptyManager.h"
#import "CWStarRateView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJExtension.h"
#import "LYZImageModel.h"
#import "TagModel.h"
#import "NSDate+Formatter.h"
#import "NSDate+Utilities.h"
#import "Public+JGHUD.h"
#import "UIButton+LYZLoginButton.h"
#import "NSDate+Utilities.h"
#import "NSDate+Formatter.h"
#import "FriendCircleCell1.h"
#import "FriendCell2.h"
#import "SDRefresh.h"
#import "SafeCategory.h"
#import "XZHRefresh.h"
#import "LoginManager.h"
@interface LYZCommentListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    SDRefreshFooterView *_refreshFooter;
}
@property (nonatomic, strong) HXTagsView *tagsView;//tagsView
@property (nonatomic,strong)UITableView *commentTabview;
@property (nonatomic,strong)NSArray *commentArray;
@property (nonatomic,strong)UIButton *toOrderButton;
@property (nonatomic, strong)CWStarRateView *starRateView;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableArray *tages;
@property (nonatomic, strong) NSMutableArray *temparr;
@property (nonatomic, strong) NSMutableArray *tagesindex;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *tagesid;


/// 保存TagModel对象  id\name\count
@property(nonatomic, strong)NSMutableArray* countArr;

//当前选中的标签
@property(nonatomic,assign)NSInteger selectedTageIndex;

@end

@implementation LYZCommentListViewController

-(NSMutableArray *)countArr{
    if(!_countArr){
        _countArr = [[NSMutableArray alloc]init];
    }
    return _countArr;
}

- (NSMutableArray *)comments{
    if (!_comments) {
        
        _comments = [NSMutableArray array];
    }
    return _comments;
}

- (NSMutableArray *)tages{
    
    if(!_tages){
        
        _tages = [NSMutableArray array];
        
    }
    
    return _tages;
    
}

- (NSMutableArray *)temparr{
    
    if(!_temparr){
        
        _temparr = [NSMutableArray array];
        
    }
    return _temparr;
}

- (NSMutableArray *)tagesindex{
    
    if(!_tagesindex){
        
        _tagesindex = [NSMutableArray array];
        
    }
    
    return _tagesindex;
    
}

-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , _headView.height)];
        titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:17];
        titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
        titleLabel.text = [NSString stringWithFormat:@"全部评价(%.0f)",self.averageScore.floatValue];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:titleLabel];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(SCREEN_WIDTH - 10 - 20, 10, 20, 20);
        [closeBtn setImage:[UIImage imageNamed:@"pay_icon_close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:closeBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _headView.height - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = kLineColor;
        [_headView addSubview:line];
    }
    return _headView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.commentTabview.mj_header beginRefreshing];
    
    [[LYZNetWorkEngine sharedInstance]getHotelCommentTagWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType hotelID:self.hotelId block:^(int event, id object) {
        
        if (event == 1) {
            GetCommentTagResponse * response = (GetCommentTagResponse *)object;
            NSLog(@"%@",response);
            if(self.countArr.count > 0){
                [self.countArr removeAllObjects];
            }
            
            BaseCommentTagModel *basetag = response.tags;
            for (TagModel *model in basetag.tags) {
                
                [self.countArr addObject:model];
                NSString *tagTitle = [NSString stringWithFormat:@"%@(%@)",model.name,[model.count stringValue]];
                
                
                [self.tages addObject:tagTitle];
                
                if ([model.id isEqualToString:@""]) {
                    model.id = @"";
                }
                [self.tagesindex addObject:model.id];
                
            }
            self.tagsView.tags = self.tages;
            [self.tagsView reloadData];
        }
    }];
}

- (HXTagsView *)tagsView {
    if (!_tagsView) {
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth, 40)];
        _tagsView.backgroundColor = [UIColor whiteColor];
        _tagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _tagsView;
}

- (UITableView *)commentTabview{
    if (!_commentTabview) {
        _commentTabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _commentTabview.delegate = self;
        _commentTabview.dataSource = self;
        _commentTabview.backgroundColor = [UIColor whiteColor];
        //_commentTabview.showsVerticalScrollIndicator = NO;
    }
    return _commentTabview;
}

-(void)closeBtnClick:(UIButton *)sender{
    [self disMiss];
}

#pragma mark -- show VC
- (void)disMiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)updateData:(NSString *)tagid{
    
    if (tagid) {
        [[LYZNetWorkEngine sharedInstance]getHotelCommentWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType hotelID:self.hotelId limit:@"10" pages:[NSString stringWithFormat:@"%ld", self.page ] tagid:tagid  block:^(int event, id object) {
            
            [self.commentTabview.mj_header endRefreshing];
            [self.commentTabview.mj_footer endRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (event == 1) {
                
                GetHotelCommentResponse * response = (GetHotelCommentResponse *)object;
                NSLog(@"%@",response);
                BaseCommentModel * baseCommnet = response.baseComment;
                //self.comments = baseCommnet.comments.mutableCopy;
                
                if (self.page == 1) {
                    [self.comments removeAllObjects];
                    //[self.temparr removeAllObjects];
                }
                
                NSArray *arr = baseCommnet.comments.mutableCopy;
                for (HotelCommentsModel *model in arr) {
                    //[self.temparr addObject:model];
                    [self.comments addObject:model];
                }
                //self.comments = self.temparr;
                if (self.comments.count <= 0) {
                    UIImage *img = [UIImage imageNamed:@"no_live"];
                    [[EmptyManager sharedManager] showEmptyOnView:self.commentTabview withImage:img explain:@"暂无评论" operationText:@"" operationBlock:nil];
                }else{
                    [[EmptyManager sharedManager] removeEmptyFromView:self.commentTabview];
                }
                [self.commentTabview reloadData];
            }else{
                LYLog(@"error ---> %@",object);
            }
            [self endTheRefresh:self.comments.count];;
        }];
    }else{
        
        [[LYZNetWorkEngine sharedInstance]getHotelCommentWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType hotelID:self.hotelId limit:@"10" pages:[NSString stringWithFormat:@"%ld",self.page] tagid:tagid  block:^(int event, id object) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.commentTabview.mj_header endRefreshing];
            [self.commentTabview.mj_footer endRefreshing];
            
            if (event == 1) {
                GetHotelCommentResponse * response = (GetHotelCommentResponse *)object;
                NSLog(@"%@",response);
                BaseCommentModel * baseCommnet = response.baseComment;
                //self.comments = baseCommnet.comments.mutableCopy;
                
                if (self.page == 1) {
                    [self.comments removeAllObjects];
                    //[self.temparr removeAllObjects];
                }
                
                NSArray *arr = baseCommnet.comments.mutableCopy;
                for (HotelCommentsModel *model in arr) {
                    // [self.temparr addObject:model];
                    [self.comments addObject:model];
                }
                //self.comments = self.temparr;
                if (self.comments.count <= 0) {
                    UIImage *img = [UIImage imageNamed:@"no_live"];
                    [[EmptyManager sharedManager] showEmptyOnView:self.commentTabview withImage:img explain:@"暂无评论" operationText:@"" operationBlock:nil];
                }else{
                    [[EmptyManager sharedManager] removeEmptyFromView:self.commentTabview];
                }
                
                [self.commentTabview reloadData];
            }else{
                LYLog(@"error ---> %@",object);
            }
            [self endTheRefresh:self.comments.count];;
        }];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self showTagsView];
    weakify(self);
    self.page = 1;
    self.selectedTageIndex=0;
    self.commentTabview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        strongify(self);
        
        self.page = 1;
        if (self.tagesid) {
            [self updateData:self.tagesid];
            
        }else{
            [self updateData:@""];
        }
    }];
    
    
    //上拉刷新
    self.commentTabview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"refreshList" object:nil];
    
    [self.view addSubview:self.headView];
    
    CGFloat height = [HXTagsView getHeightWithTags:self.tagsView.tags layout:self.tagsView.layout tagAttribute:self.tagsView.tagAttribute width:kScreenWidth];
    [self.tagsView reloadData];
    
    self.tagsView.frame = CGRectMake(0,0,kScreenWidth, height);
    [self.commentTabview registerClass:[FriendCircleCell1 class] forCellReuseIdentifier:NSStringFromClass([FriendCircleCell1 class])];
    [self.commentTabview registerClass:[FriendCell2 class] forCellReuseIdentifier:NSStringFromClass([FriendCell2 class])];
    
    [self.view addSubview:self.commentTabview];
    self.commentTabview.tableHeaderView = self.tagsView;
    __weak typeof(self) wself = self;
    self.tagsView.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
        wself.page = 1;
        NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        [MBProgressHUD showHUDAddedTo:wself.view animated:YES];
        NSString *tagid = [wself.tagesindex objectAtIndex:currentIndex];
        wself.tagesid = tagid;
        wself.selectedTageIndex=currentIndex;
        [wself.comments removeAllObjects];
        [wself requestWithtag:tagid];
        
    };
    self.title =  @"酒店评价";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEEF0"];
    
    // Do any additional setup after loading the view.
}

- (void)refresh{
    [self updateData:self.tagesid];
}
-(void)footerRefreshAction{
    if (self.tagesid) {
        [self updateData:self.tagesid];
        
    }else{
        [self updateData:@""];
    }
}

-(void)endTheRefresh:(NSInteger)totalCounts{
    TagModel* model = self.countArr[self.selectedTageIndex];
    if(totalCounts == model.count.integerValue){
        self.commentTabview.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.page++;
    }
}
- (void)requestWithtag:(NSString *)tagid{
    
    if (tagid) {
        [[LYZNetWorkEngine sharedInstance]getHotelCommentWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType hotelID:self.hotelId limit:@"10" pages:[NSString stringWithFormat:@"%ld",self.page] tagid:tagid  block:^(int event, id object) {
            
            [self.commentTabview.mj_header endRefreshing];
            [self.commentTabview.mj_footer endRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (event == 1) {
                GetHotelCommentResponse * response = (GetHotelCommentResponse *)object;
                NSLog(@"%@",response);
                BaseCommentModel * baseCommnet = response.baseComment;
                self.comments = baseCommnet.comments.mutableCopy;
                
                [self.commentTabview reloadData];
            }else{
                LYLog(@"error ---> %@",object);
            }
            
            [self endTheRefresh:self.comments.count];
            
        }];
    }else{
        
        [[LYZNetWorkEngine sharedInstance]getHotelCommentWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType hotelID:self.hotelId limit:@"10" pages:[NSString stringWithFormat:@"%ld",self.page] tagid:tagid  block:^(int event, id object) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.commentTabview.mj_header endRefreshing];
            [self.commentTabview.mj_footer endRefreshing];
            
            if (event == 1) {
                GetHotelCommentResponse * response = (GetHotelCommentResponse *)object;
                NSLog(@"%@",response);
                BaseCommentModel * baseCommnet = response.baseComment;
                self.comments = baseCommnet.comments.mutableCopy;
                
                [self.commentTabview reloadData];
            }else{
                LYLog(@"error ---> %@",object);
            }
            [self endTheRefresh:self.comments.count];
        }];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotelCommentsModel *model = [self.comments safeObjectAtIndex:indexPath.row];
    if ([[model.isReply stringValue]isEqualToString:@"0"]) {
        FriendCell2 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FriendCell2 class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell cellDataWithModel:model];
        return cell;
    }else{
        
        FriendCircleCell1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FriendCircleCell1 class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell cellDataWithModel:model];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotelCommentsModel *model = [self.comments safeObjectAtIndex:indexPath.row];
    if ([[model.isReply stringValue]isEqualToString:@"0"]) {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([FriendCell2 class]) cacheByIndexPath:indexPath configuration:^(FriendCell2 *cell) {
            HotelCommentsModel *model = [self.comments objectAtIndex:indexPath.row];
            [cell cellDataWithModel:model];
        }];
        
    }else{
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([FriendCircleCell1 class]) cacheByIndexPath:indexPath configuration:^(FriendCircleCell1 *cell) {
            HotelCommentsModel *model = [self.comments safeObjectAtIndex:indexPath.row];
            [cell cellDataWithModel:model];
        }];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LYZCommentDetailViewController *detail = [LYZCommentDetailViewController new];
    HotelCommentsModel *model = [self.comments safeObjectAtIndex:indexPath.row];
    detail.commentId = model.commentId;
    detail.averageScore = [model.likeCount stringValue];
    [detail showInViewController:self];
    
}

- (void)showInViewController:(UIViewController *)vc{
    if (vc) {
        [vc addChildViewController:self];
        [vc.view addSubview:self.view];
        [self show];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

-(void)show{
    [self addKeyAnimation];
}

- (void)addKeyAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.calculationMode = kCAAnimationCubic;
    animation.values = @[@1.07,@1.06,@1.05,@1.03,@1.02,@1.01,@1.0];
    animation.duration = 0.4;
    [self.view.layer addAnimation:animation forKey:@"transform.scale"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
