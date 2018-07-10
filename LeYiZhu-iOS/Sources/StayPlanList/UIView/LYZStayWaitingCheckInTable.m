                                                                                                                                                                                                                                                                                                                                                                              //
//  LYZWaitingCheckInTable.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayWaitingCheckInTable.h"
#import "LYZStayPlanDateCell.h"
#import "LYZStayRoomTypeCell.h"
#import "LYZStayAddressCell.h"
#import "LYZStayGuideCell.h"
#import "LYZStayNoticeCell.h"
#import "LYZStayShareCell.h"
#import "ColorSpaceCell.h"
#import "CustomCell.h"
#import "UIView+SetRect.h"

#import "UserStaysModel.h"
#import "GCD.h"

#define kTableScale 0.64
#define kDateCellScale 0.144
#define kNameCellScale 0.121
//#define kAddressCellScale 0.079
//#define kIndicatorCellScale 0.172
#define kNoticeCellScale 0.052
#define kShareCellScale 0.072

@interface LYZStayWaitingCheckInTable ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate>

@property (nonatomic , strong) UITableView *waitingCheckInTable;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *headArrowView;
@property (nonatomic, strong) UIView *footArrowView;

@end

@implementation LYZStayWaitingCheckInTable

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(12.5, 0 , self.width - 25, kTableScale *SCREEN_HEIGHT )];
//        self.backView.centerY = frame.size.height /2.0;
        self.backView.clipsToBounds = NO;
        self.backView.layer.cornerRadius = 8.0;
        self.backView.layer.shadowOffset = CGSizeMake(0, 0);
        self.backView.layer.shadowOpacity = .6;
        self.backView.layer.shadowColor = LYZTheme_warmGreyFontColor.CGColor;
        self.backView.backgroundColor = LYZTheme_BackGroundColor;
         [self addSubview:self.backView];
        [self.backView addSubview:self.waitingCheckInTable];
        [self configArrowView];
    }
    return self;
}

-(void)configArrowView{
    
    self.footArrowView =[[UIView alloc] initWithFrame:CGRectMake(0, self.height - 58 , SCREEN_WIDTH, 58)];
    self.footArrowView.backgroundColor = [UIColor clearColor];
    
    UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 22)];
    footLabel.textAlignment = NSTextAlignmentCenter;
    footLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    footLabel.textColor = LYZTheme_warmGreyFontColor;
    footLabel.text = @"后续入住计划";
    
    UIImageView *footImgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 32)/2.0, 58 - 32, 32, 32)];
    footImgView.image = [UIImage imageNamed:@"live_icon_up"];
    [self.footArrowView addSubview:footImgView];
    [self.footArrowView addSubview:footLabel];
    [self addSubview:self.footArrowView];
    
    self.headArrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, 58)];
    self.headArrowView.backgroundColor = [UIColor clearColor];
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 32)/2.0, 0, 32, 32)];
    headImgView.image = [UIImage imageNamed:@"live_icon_down"];
    [self.headArrowView addSubview:headImgView];
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headImgView.bottom - 6, SCREEN_WIDTH, 22)];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    headLabel.textColor = LYZTheme_warmGreyFontColor;
    headLabel.text = @"正在入住";
    [self.headArrowView addSubview:headLabel];
    [self addSubview:self.headArrowView];
}

-(void)setShowNext:(BOOL)showNext{
    _showNext = showNext;
    self.footArrowView.hidden = !_showNext;
}

-(void)setShowUp:(BOOL)showUp{
    _showUp = showUp;
    self.headArrowView.hidden = !_showUp;
}



-(UITableView *)waitingCheckInTable{
    if (!_waitingCheckInTable) {
        _waitingCheckInTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, self.backView.height)];
        _waitingCheckInTable.delegate        = self;
        _waitingCheckInTable.dataSource      = self;
        _waitingCheckInTable.backgroundColor = [UIColor clearColor];
        _waitingCheckInTable.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _waitingCheckInTable.showsVerticalScrollIndicator = NO;
        _waitingCheckInTable.clipsToBounds = YES;
        _waitingCheckInTable.scrollEnabled = NO;
        _waitingCheckInTable.layer.cornerRadius = 8.0;
        [ColorSpaceCell registerToTableView:_waitingCheckInTable];
        [LYZStayPlanDateCell registerToTableView:_waitingCheckInTable];
        [LYZStayRoomTypeCell registerToTableView:_waitingCheckInTable];
        [LYZStayAddressCell registerToTableView:_waitingCheckInTable];
        [LYZStayShareCell registerToTableView:_waitingCheckInTable];
        [LYZStayGuideCell registerToTableView:_waitingCheckInTable];
        [LYZStayNoticeCell registerToTableView:_waitingCheckInTable];
    }
    return _waitingCheckInTable;
}


-(void)setDataSource:(UserStaysModel *)dataSource{
    _dataSource = dataSource;
    if (!self.adapters) {
        _adapters= [NSMutableArray array];
    }
    if (self.adapters.count) {
        [_adapters removeAllObjects];
    }
    [_adapters addObject:[LYZStayPlanDateCell dataAdapterWithData:dataSource cellHeight:SCREEN_HEIGHT *kDateCellScale]];
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    [_adapters addObject:[LYZStayRoomTypeCell dataAdapterWithData:dataSource cellHeight:SCREEN_HEIGHT *kNameCellScale]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    [_adapters addObject:[LYZStayAddressCell dataAdapterWithData:dataSource cellHeight:[LYZStayAddressCell cellHeightWithData:dataSource]]];
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    [_adapters addObject:[LYZStayGuideCell dataAdapterWithData:nil cellHeight:[LYZStayGuideCell cellHeight]]];
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    [_adapters addObject:[LYZStayNoticeCell dataAdapterWithData:nil cellHeight:SCREEN_HEIGHT *kNoticeCellScale]];
    [_adapters addObject:[LYZStayShareCell dataAdapterWithData:nil cellHeight:SCREEN_HEIGHT *kShareCellScale]];
//    self.backView.height =[LYZStayAddressCell cellHeightWithData:dataSource] + [LYZStayGuideCell cellHeight] + SCREEN_HEIGHT*(kDateCellScale + kNameCellScale  + kNoticeCellScale +kShareCellScale) + 2;
    
    [GCDQueue executeInMainQueue:^{
//        self.backView.centerY = (SCREEN_HEIGHT -64 - 49)/2.0;
//        self.waitingCheckInTable.height = self.backView.height;
        [self layoutSubviews];
        [self.waitingCheckInTable reloadData];
    }];
    
}

-(void)layoutSubviews{
        self.backView.height =[LYZStayAddressCell cellHeightWithData:_dataSource] + [LYZStayGuideCell cellHeight] + SCREEN_HEIGHT*(kDateCellScale + kNameCellScale  + kNoticeCellScale +kShareCellScale) + 2;
            self.backView.centerY = (SCREEN_HEIGHT -64 - 49)/2.0;
            self.waitingCheckInTable.height = self.backView.height;
}

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height{
    if (type == kSpace) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" :LYZTheme_BackGroundColor} cellHeight:15.f];
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :[UIColor colorWithHexString:@"E8E8E8"]} cellHeight:0.5f];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" : [UIColor colorWithHexString:@"E8E8E8"], @"leftGap" : @(20.f)} cellHeight:0.5f];
        
    } else {
        return nil;
    }
}

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
    [cell loadContent];
    // WEAKSELF;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableClickAtIndex:withDataSource:)]) {
        [self.delegate tableClickAtIndex:indexPath.row withDataSource:self.dataSource];
    }
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    LYLog(@"%@", event);
}



-(void)dealloc{
    LYLog(@"dealloc");
}

@end
