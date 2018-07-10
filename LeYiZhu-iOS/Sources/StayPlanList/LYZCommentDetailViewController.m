//
//  LYZCommentDetailViewController.m
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/19.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

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
#import "LYZCommentDetailTableViewCell.h"
#import "LYZcommentDetailModel.h"
#import "LoginManager.h"
#import "LYZTableViewCell1.h"
@interface LYZCommentDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *commentTabview;
@property (nonatomic,strong)NSArray *commentArray;
@property (nonatomic, strong)CWStarRateView *starRateView;
@property (nonatomic, strong)LYZcommentDetailModel *model;
@property (nonatomic,strong)UIButton *toOrderButton;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LYZCommentDetailViewController

- (UITableView *)commentTabview{
    if (!_commentTabview) {
        _commentTabview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _commentTabview.delegate = self;
        _commentTabview.dataSource = self;
        _commentTabview.backgroundColor = [UIColor whiteColor];
    }
    return _commentTabview;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , _headView.height)];
        self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:17];
        self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
        self.titleLabel.text = [NSString stringWithFormat:@"%@人觉得很赞",[self.model.likeCount stringValue]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:self.titleLabel];
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentTabview.tableHeaderView = self.headView;
    [self.commentTabview registerClass:[LYZCommentDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LYZCommentDetailTableViewCell class])];
    [self.commentTabview registerClass:[LYZTableViewCell1 class] forCellReuseIdentifier:NSStringFromClass([LYZTableViewCell1 class])];

    [self.view addSubview:self.commentTabview];
    [self.commentTabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.title =  @"评价详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEEF0"];
    self.toOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.toOrderButton setImage:[UIImage imageNamed:@"comment_thum"] forState:UIControlStateNormal];
    self.toOrderButton.frame = CGRectMake(0, kScreenHeight-45, kScreenWidth, 45);
    self.toOrderButton.backgroundColor = LYZTheme_paleBrown;
    [self.toOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.toOrderButton];
    self.toOrderButton.backgroundColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1.0f];
    [self.toOrderButton addTarget:self action:@selector(toOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.toOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [[LYZNetWorkEngine sharedInstance]getHotelCommentSkanWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType commentID:self.commentId block:^(int event, id object) {
        if (event == 1) {
            SkanCommentResponse * response = (SkanCommentResponse *)object;
            NSLog(@"%@",response);
            self.model = (LYZcommentDetailModel *)response.detail;
            self.titleLabel.text = [NSString stringWithFormat:@"%@人觉得很赞",[self.model.likeCount stringValue]];
            if ([self.model.isLike isEqualToString:@"Y"]) {
                [self.toOrderButton setTitle:@"  已点赞" forState:UIControlStateNormal];
                self.toOrderButton.backgroundColor = LYZTheme_paleBrown;
            }else{
                [self.toOrderButton setTitle:@"  未点赞" forState:UIControlStateNormal];
                self.toOrderButton.backgroundColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1.0f];
                
            }

            [self.commentTabview reloadData];
        }else{
            LYLog(@"error ---> %@",object);
        }
        
    }];
    
    // Do any additional setup after loading the view.
}

-(void)closeBtnClick:(UIButton *)sender{
    [self disMiss];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshList" object:nil];
}

- (void)disMiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)toOrder:(UIButton *)order{
    
    if ([LoginManager instance].appUserID) {
        [self.commentTabview.mj_header endRefreshing];
        [[LYZNetWorkEngine sharedInstance] getHotelCommentUpvodeWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType commentID:self.commentId block:^(int event, id object) {
            
            NSLog(@"%@",object);
            
            if (event == 1) {
                
                if ([self.model.isLike isEqualToString:@"N"]) {
                    [Public showJGHUDWhenSuccess:self.view msg:@"点赞成功"];
                }else{
                    [Public showJGHUDWhenSuccess:self.view msg:@"取消点赞成功"];
                }
                [[LYZNetWorkEngine sharedInstance]getHotelCommentSkanWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType commentID:self.commentId block:^(int event, id object) {
                    if (event == 1) {
                        [self.commentTabview reloadData];
                        SkanCommentResponse * response = (SkanCommentResponse *)object;
                        NSLog(@"%@",response);
                        self.model = response.detail;
                        self.titleLabel.text = [NSString stringWithFormat:@"%@人觉得很赞",[self.model.likeCount stringValue]];
                        if ([self.model.isLike isEqualToString:@"Y"]) {
                            [self.toOrderButton setTitle:@"  已点赞" forState:UIControlStateNormal];
                            self.toOrderButton.backgroundColor = LYZTheme_paleBrown;
                        }else{
                            [self.toOrderButton setTitle:@"  未点赞" forState:UIControlStateNormal];
                            self.toOrderButton.backgroundColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1.0f];

                        }
                        
                    }else{
                        LYLog(@"error ---> %@",object);
                    }
                }];
            }else{
                
                [Public showJGHUDWhenError:self.view msg:object];
            }
            
        }];
    }else{
        [[LoginManager instance] userLogin];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[self.model.isReply stringValue]isEqualToString:@"0"]) {
        LYZTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LYZTableViewCell1 class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell cellDataWithModel:self.model];
        return cell;
    }else{
        LYZCommentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LYZCommentDetailTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell cellDataWithModel:self.model];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[self.model.isReply stringValue]isEqualToString:@"0"]) {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([LYZTableViewCell1 class]) cacheByIndexPath:indexPath configuration:^(LYZTableViewCell1 *cell) {
            [cell cellDataWithModel:self.model];
        }];
    }else{
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([LYZCommentDetailTableViewCell class]) cacheByIndexPath:indexPath configuration:^(LYZCommentDetailTableViewCell *cell) {
            [cell cellDataWithModel:self.model];
        }];
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
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
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (@available(iOS 11.0, *)) {
        
        return 0.0000001;
        
    }else{
        
        if (section == 0)
            return 0.0000001;
        return tableView.sectionHeaderHeight;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    return header;
    
}

@end
