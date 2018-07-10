//
//  LYZStayCheckInTable.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayCheckInTable.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "UserStaysModel.h"
#import "GCD.h"
#import "LYZStayHotelInfoCell.h"
#import "LYZStayPswCell.h"
#import "LYZStayNoticeTwoCell.h"
#import "LYZStayFunctionCell.h"
#import <objc/runtime.h>
#import "UIView+SetRect.h"

#define kEyeStatus @"eyeStatus"

#define kHotelInfoCellScale 0.144
#define kPswCellScale 0.375
#define kNoticeCellScale 0.05
#define kFunctionCellScale 0.07

@interface LYZStayCheckInTable ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate>{
//       NSNumber *_isEyeOpen;
}

@property (nonatomic, strong) UITableView *checkInTable;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong)  UIView *footArrowView;


@end

static BOOL isEyeOpen = YES;

@implementation LYZStayCheckInTable

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.layer.masksToBounds = YES;
//        self.layer.borderWidth = 0.5;
//        self.layer.borderColor = LYZTheme_PinkishGeryColor.CGColor;
//         self.backgroundColor = LYZTheme_BackGroundColor;
//        
//        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0,-50, self.height ,self.height + 100)];
//        [self addSubview:_baseView];
       
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(12.5, 55 , self.width - 25, 432 )];
        self.backView.clipsToBounds = NO;
        self.backView.layer.cornerRadius = 8.0;
        self.backView.layer.shadowOffset = CGSizeMake(0, 0);
        self.backView.layer.shadowOpacity = .6;
        self.backView.layer.shadowColor = LYZTheme_warmGreyFontColor.CGColor;
        self.backView.backgroundColor = LYZTheme_BackGroundColor;
//        [self.baseView addSubview:self.backView];
         [self addSubview:self.backView];
        [self.backView addSubview:self.checkInTable];
//        [self configEyeStatus];
     [self configArrowView];
    }
    return self;
}

-(void)configArrowView{
    self.footArrowView =[[UIView alloc] initWithFrame:CGRectMake(0, self.height - 58-5 , SCREEN_WIDTH, 58)];
    self.footArrowView.backgroundColor = [UIColor clearColor];
    
    UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10, SCREEN_WIDTH, 22)];
    footLabel.textAlignment = NSTextAlignmentCenter;
    footLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    footLabel.textColor = LYZTheme_warmGreyFontColor;
    footLabel.text = @"后续入住计划";
    
    UIImageView *footImgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 32)/2.0, 58 - 32, 32, 32)];
    footImgView.image = [UIImage imageNamed:@"live_icon_up"];
    [self.footArrowView addSubview:footImgView];
    [self.footArrowView addSubview:footLabel];
    [self addSubview:self.footArrowView];
}

-(void)setShowNext:(BOOL)showNext{
    _showNext = showNext;
    self.footArrowView.hidden = !_showNext;
}


-(UITableView *)checkInTable{
    if (!_checkInTable) {
        _checkInTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, self.backView.height)];
        _checkInTable.delegate        = self;
        _checkInTable.dataSource      = self;
        _checkInTable.backgroundColor = [UIColor clearColor];
        _checkInTable.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _checkInTable.scrollEnabled = NO;
        _checkInTable.layer.cornerRadius = 8;
        _checkInTable.clipsToBounds = YES;
        [ColorSpaceCell registerToTableView:_checkInTable];
        [LYZStayHotelInfoCell registerToTableView:_checkInTable];
        [LYZStayPswCell registerToTableView:_checkInTable];
        [LYZStayNoticeTwoCell registerToTableView:_checkInTable];
        [LYZStayFunctionCell registerToTableView:_checkInTable];
    }
    return _checkInTable;
}

-(void)setDataSource:(UserStaysModel *)dataSource{
    _dataSource = dataSource;
    if (!self.adapters) {
        _adapters= [NSMutableArray array];
    }
    if (self.adapters.count) {
        [_adapters removeAllObjects];
    }
    [_adapters addObject:[LYZStayHotelInfoCell dataAdapterWithData:dataSource cellHeight:SCREEN_HEIGHT *kHotelInfoCellScale]];
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    [_adapters addObject:[LYZStayPswCell dataAdapterWithData:dataSource cellHeight:SCREEN_HEIGHT *kPswCellScale]];
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    [_adapters addObject:[LYZStayNoticeTwoCell dataAdapterWithData:dataSource cellHeight:SCREEN_HEIGHT *kNoticeCellScale]];
       [_adapters addObject:[LYZStayFunctionCell dataAdapterWithData:nil cellHeight:SCREEN_HEIGHT *kFunctionCellScale]];
    [GCDQueue executeInMainQueue:^{
        [self layoutSubviews];
      
        [self.checkInTable reloadData];
    }];
}

-(void)layoutSubviews{
    self.backView.height = SCREEN_HEIGHT * (kHotelInfoCellScale + kPswCellScale + kNoticeCellScale + kFunctionCellScale) + 1;
    self.backView.centerY = (SCREEN_HEIGHT - 64 - 49) / 2.0;
    self.checkInTable.height = self.backView.height;
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
    if ([cell isKindOfClass:[LYZStayPswCell class]]) {
        LYZStayPswCell *pswCell = (LYZStayPswCell *)cell;
//        pswCell.isEyeOpen = _isEyeOpen.integerValue;
        pswCell.isEyeOpen = isEyeOpen;
        pswCell.showPswHandler = ^(BOOL isOpen){
//            NSNumber *open = isOpen?@1:@0;
//             objc_setAssociatedObject(self, &eyeStatusKey,open, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            _isEyeOpen = open;
            isEyeOpen = isOpen;
            [self.checkInTable reloadData];
        };
        pswCell.OpenDoorHandler =^(){
            if (self.delegate && [self.delegate respondsToSelector:@selector(openDoorSlider:)]) {
                [self.delegate openDoorSlider:self.dataSource];
            }
        };
        pswCell.changePswHandler = ^(UserStaysModel *model){
            if (self.delegate && [self.delegate respondsToSelector:@selector(changePswBtnClick:)]) {
                [self.delegate changePswBtnClick:model];
            }
        };
    }
    
    if ([cell isKindOfClass:[LYZStayFunctionCell class]]) {
         LYZStayFunctionCell *funcCell = (LYZStayFunctionCell *)cell;
        funcCell.shareBtn = ^(){
            if (self.delegate && [self.delegate respondsToSelector:@selector(shareBtnClicked)]) {
                [self.delegate shareBtnClicked];
            }
        };
        funcCell.checkOutBtn= ^(){
            if (self.delegate && [self.delegate respondsToSelector:@selector(checkoutBtnClicked:)]) {
                [self.delegate checkoutBtnClicked:self.dataSource];
            }
        };
        funcCell.renewBtn = ^(){
            if (self.delegate && [self.delegate respondsToSelector:@selector(renewBtnClicked:)]) {
                [self.delegate renewBtnClicked:self.dataSource];
            }
        };
    }
    [cell loadContent];
    // WEAKSELF;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    LYLog(@"%@", event);
}

-(void)dealloc{
    LYLog(@"dealloc");
}

@end
