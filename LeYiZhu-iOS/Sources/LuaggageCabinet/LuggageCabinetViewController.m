//
//  LuaggageCabinetViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LuggageCabinetViewController.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "Public+JGHUD.h"
#import "GCD.h"
#import "LYZHotelCommonTitleCell.h"
#import "CabinetNormsCell.h"
#import "CabinetNormsModel.h"
#import "CabinetInfoModel.h"
#import "SureCustomActionSheet.h"
#import "SureCustonActionSheetModel.h"
#import "GCD.h"
#import "AlertView.h"
#import "BaseMessageView.h"
#define ttg 100000

@interface LuggageCabinetViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate,UIAlertViewDelegate,BaseMessageViewDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;

@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIView *actionSheetHeadView;
@property (nonatomic, copy) NSString *selectedNormInfo; //用于显示 规格和大小拼接而成
@property (nonatomic, copy) NSString *targetNorm; //最终开柜的规格


@end

@implementation LuggageCabinetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"行李存放";
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置默认的格子规格
    for (CabinetNormsModel *model in self.cabinetInfo.normjar) {
        if ([model.ishavecloselat isEqualToString:@"Y"]) {
            self.selectedNormInfo =model.norminfo;
            self.targetNorm = model.norm;
            break;
        }
    }
    [self createTableViewAndRegisterCells];
    [self createOpenBtn];
    [self createDataSource];
    
}
#pragma mark - UI Config

- (void)createTableViewAndRegisterCells {
    
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - 64)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = self.footView;
    [self.view addSubview:_tableView];
    [ColorSpaceCell  registerToTableView:self.tableView];
    [LYZHotelCommonTitleCell registerToTableView:self.tableView];
    [CabinetNormsCell registerToTableView:self.tableView];
    
}


- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    
    if (type == kSpace) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : LYZTheme_BackGroundColor} cellHeight:height];
        
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor} cellHeight:0.5f];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor, @"leftGap" : @(20.f)} cellHeight:0.5f];
        
    } else {
        
        return nil;
    }
}

-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
        _footView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.text = @"温馨提示:";
        titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel sizeToFit];
        titleLabel.x = DefaultLeftSpace;
        titleLabel.y = 20;
        [_footView addSubview:titleLabel];
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;// 字体的行间距
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:14],
                                     NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:LYZTheme_warmGreyFontColor
                                     };
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, titleLabel.bottom + 5, SCREEN_WIDTH - 2*DefaultLeftSpace, 0)];
        textView.editable = NO;
        textView.scrollEnabled = NO;
        
        NSString *message = @"1、本行李寄存柜只提供存放，不负责保管。贵重物品请随身携带。\n2、行李寄存柜数量有限，为了节省资源，方便有需要人仕使用，住客在入住当天和离店当天可以使用一次，其它时间恕不提供使用。\n3、打开格子时如发现有物品存放，请尽快通知客服。\n4、存放行李后，请务必关闭好柜门。\n5、行李只允许存放一次，在关柜门前请确认已经把需要存放的物品放入。\n6、每次只可寄存24小时，超时可能会被提出。\n7、有问题请联系客服（4009670533）";
         textView.attributedText =  [[NSAttributedString alloc] initWithString:message attributes:attributes];
        CGSize constraintSize = CGSizeMake(textView.width, MAXFLOAT);
        CGSize size = [textView sizeThatFits:constraintSize];
        textView.height = size.height;
        [_footView addSubview:textView];
    }
    return _footView;
}

- (UIView*)actionSheetHeadView {
    if (!_actionSheetHeadView) {
        _actionSheetHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 50)];
        _actionSheetHeadView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width - 20, 30)];
        titleLabel.text = @"请选择合适的柜子规格";
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.textColor = [UIColor colorWithRed:73/255.0 green:75/255.0 blue:90/255.0 alpha:1];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_actionSheetHeadView addSubview:titleLabel];
        
      
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, self.view.bounds.size.width - 20, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [_actionSheetHeadView addSubview:line];
    }
    return _actionSheetHeadView;
}


-(void)createOpenBtn{
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.frame = CGRectMake(DefaultLeftSpace, SCREEN_HEIGHT - 64  - 20 - 45, SCREEN_WIDTH - 2*DefaultLeftSpace , 45);
    openBtn.layer.cornerRadius  = 5.0f;
    openBtn.backgroundColor = LYZTheme_paleBrown;
//    openBtn.clipsToBounds = YES;
    [openBtn setTitle:@"打开柜门存放行李" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    openBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [openBtn addTarget:self action:@selector(OpenLuaggage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];
}

#pragma mark - Data Config

-(void)createDataSource{
    if (!_adapters) {
        _adapters= [NSMutableArray array];
    }
    if (_adapters.count > 0) {
        [_adapters removeAllObjects];
    }
    
    [_adapters addObject:[LYZHotelCommonTitleCell dataAdapterWithData:@{@"title":@"所需格子"} cellHeight:LYZHotelCommonTitleCell.cellHeight]];
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    
 
    [_adapters addObject:[CabinetNormsCell dataAdapterWithData:self.selectedNormInfo cellHeight:CabinetNormsCell.cellHeight]];
    [_adapters addObject:[self lineType:kSpace height:15]];
    
    [GCDQueue executeInMainQueue:^{
        [self.tableView reloadData];
    }];
}


#pragma mark - TableView Delegate & DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellDataAdapter *adapter = _adapters[indexPath.row];
    CustomCell      *cell    = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter         = adapter;
    cell.data                = adapter.data;
    cell.indexPath           = indexPath;
    cell.tableView           = tableView;
    cell.delegate            = self;
    cell.controller          = self;
    [cell loadContent];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
    if (indexPath.row == 2) {
       
        NSMutableArray *sheetArr = [NSMutableArray array];
        for (int i = 0; i < self.cabinetInfo.normjar.count; i ++) {
            CabinetNormsModel *cabinet = self.cabinetInfo.normjar[i];
            SureCustonActionSheetModel *model = [[SureCustonActionSheetModel alloc] init];
            model.content = cabinet.norminfo;
            model.selectable = [cabinet.ishavecloselat isEqualToString:@"Y"] ? YES:NO;
            [sheetArr addObject:model];
        }
        NSArray *optionsArr = [NSArray arrayWithArray:sheetArr];
        
         WEAKSELF;
        SureCustomActionSheet *optionsView = [[SureCustomActionSheet alloc] initWithTitleView:self.actionSheetHeadView optionsArr:optionsArr cancelTitle:@"取消" selectedBlock:^(NSInteger  index) {
                CabinetNormsModel *cabinet = weakSelf.cabinetInfo.normjar[index];
                weakSelf.selectedNormInfo = cabinet.norminfo;
                weakSelf.targetNorm = cabinet.norm;
                [weakSelf createDataSource];
        } cancelBlock:^{
            
        }];
         [self.view addSubview:optionsView];
    }

}



#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    LYLog(@"%@", event);
}

-(void)showScanMessageTitle:(NSString *)title content:(NSString *)content leftBtnTitle:(NSString *)left rightBtnTitle:(NSString *)right tag:(NSInteger)tag{
    [GCDQueue executeInMainQueue:^{
        NSArray  *buttonTitles ;
        if (left && right) {
            buttonTitles   =  @[AlertViewNormalStyle(left),AlertViewRedStyle(right)];
        }else{
            buttonTitles = @[AlertViewRedStyle(left)];
        }
        AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(title,content, buttonTitles);
        [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:tag];
    }];
}
#pragma mark - Btn Actions

-(void)OpenLuaggage:(id)sender{
    
    [[LYZNetWorkEngine sharedInstance] openCabinet:self.cabinetInfo.cabinetID cabtype:self.cabinetInfo.cabtype opentype:self.cabinetInfo.opentype latticeid:nil norm:self.targetNorm block:^(int event, id object) {
        if (event == 1) {
             [Public showJGHUDWhenSuccess:self.view msg:@"开柜成功"];
            [GCDQueue executeInMainQueue:^{
                [self.navigationController popViewControllerAnimated:YES];
            } afterDelaySecs:0.8];
        }else{
            [self showScanMessageTitle:@"提示信息" content:object leftBtnTitle:@"取消" rightBtnTitle:@"联系客服" tag:ttg];
        }
    }];
    
}

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
    if (messageView.tag == ttg) {
        NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",@"400-967-0533"];
        UIApplication * app = [UIApplication sharedApplication];
        if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
            [app openURL:[NSURL URLWithString:PhoneStr]];
        }
    }
    [messageView hide];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
