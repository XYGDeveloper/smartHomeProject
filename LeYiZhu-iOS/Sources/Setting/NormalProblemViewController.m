//
//  NormalProblemViewController.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/16.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "NormalProblemViewController.h"
#import "ProblemTableViewCell.h"
#import "ProblemHeaderView.h"
#import "ClassModel.h"
#import "ProblemModel.h"
#import <AudioToolbox/AudioToolbox.h>

static NSString *infoCellFlag = @"problemCell";
static NSString *infoHeadFlag = @"problemHeader";

@interface NormalProblemViewController ()<UITableViewDelegate,UITableViewDataSource,CustomHeaderFooterViewDelegate>

@property (nonatomic, strong) UITableView     *tableView;

@property (nonatomic, strong) NSMutableArray  *classModels;

@property (nonatomic) BOOL                     sectionFirstLoad;

@property (nonatomic, weak)   ProblemHeaderView *tmpHeadView;

@property (nonatomic, strong) UIImageView *headImgView;

@end

@implementation NormalProblemViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"常见问题";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self createTableView];
    [self getProblemData];
    [self firstLoadDataAnimation];
}






-(void)getProblemData{
    
    [[LYZNetWorkEngine sharedInstance] getProblemListWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType limit:@"1000" pages:@"1" block:^(int event, id object) {
        if (event == 1) {
            GetProblemListResponse *response = (GetProblemListResponse *)object;
            BaseProblemListModel *baseProblem = response.baseProblemList;
            NSArray * promblems = baseProblem.problems;
            self.classModels = [[NSMutableArray alloc] init];
            for (int count = 0; count < promblems.count; count++) {
                ClassModel *classModel = [[ClassModel alloc] init];
                ProblemModel *model = promblems[count];
                classModel.num = [NSString stringWithFormat:@"%i",count + 1];
                classModel.problem = model.title;
                MyProblemModel * myModel = [[MyProblemModel alloc] init];
                myModel.reply = model.reply;
                myModel.problemID = model.problemID;
                classModel.problems =@[myModel];
                 [self.classModels addObject:classModel];
            }
            LYLog(@"class models is  %@",_classModels);
            [self.tableView reloadData];

            
        }else{
            LYLog(@" error  error  error ");
        }
    }];
    
  
}

-(UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
        _headImgView.image = [UIImage imageNamed:@"banner_problem"];
    }
    return _headImgView;
}

-(void)createTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.delegate                       = self;
    self.tableView.dataSource                     = self;
    self.tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator   = NO;
    self.tableView.tableHeaderView = self.headImgView;
    

    [self.tableView registerClass:[ProblemTableViewCell class] forCellReuseIdentifier:infoCellFlag];
    [self.tableView registerClass:[ProblemHeaderView class] forHeaderFooterViewReuseIdentifier:infoHeadFlag];
    
    [self.view addSubview:self.tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ClassModel *model = _classModels[section];
    
    if (model.expend == YES) {
        
        return [model.problems count];
        
    } else {
        
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.sectionFirstLoad == NO) {
        
        return 0;
        
    } else {
        
        return [_classModels count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProblemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellFlag];

    
    ClassModel   *classModel   = _classModels[indexPath.section];
    MyProblemModel *problemModel = classModel.problems[indexPath.row];
    cell.model                  = problemModel;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ProblemHeaderView *titleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:infoHeadFlag];
    titleView.HeaderFooterViewBackgroundColor = [UIColor whiteColor];
    titleView.delegate         = self;
    titleView.data             = _classModels[section];
    titleView.section          = section;
    [titleView loadContent];
    
    if (section == 0) {
        
        self.tmpHeadView = titleView;
        
    }
    
    ClassModel *model = _classModels[section];
    if (model.expend == YES) {
        
        [titleView extendStateAnimated:NO];
        
    } else {
        
        [titleView normalStateAnimated:NO];
        
    }
    
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassModel   *classModel   = _classModels[indexPath.section];
    MyProblemModel *problemModel = classModel.problems[indexPath.row];
   return [ProblemTableViewCell returnCellHeight:problemModel];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




- (void)customHeaderFooterView:(CustomHeaderFooterView *)customHeaderFooterView event:(id)event {
    
    NSInteger section = customHeaderFooterView.section;
    ClassModel *model = _classModels[section];
    
    ProblemHeaderView *classHeaderView = (ProblemHeaderView *)customHeaderFooterView;
    
    if (model.expend == YES) {
        
        // 缩回去
        model.expend = NO;
        [classHeaderView normalStateAnimated:YES];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < model.problems.count; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
        }
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
       
        
    } else {
        
        // 显示出来
        model.expend = YES;
        [classHeaderView extendStateAnimated:YES];
        
        [self playSound];

        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < model.problems.count; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
        }
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

-(void) playSound{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"caf"];
    SystemSoundID soundID;
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
    
}

- (void)firstLoadDataAnimation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // Extend sections.
        self.sectionFirstLoad = YES;
        NSIndexSet *indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.classModels.count)];
        [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            // Extend cells.
//            [self customHeaderFooterView:self.tmpHeadView event:nil];
        });
        
    });
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
