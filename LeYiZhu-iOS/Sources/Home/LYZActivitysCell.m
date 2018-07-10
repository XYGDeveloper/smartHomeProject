//
//  LYZActivitysCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/20.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZActivitysCell.h"
#import "ActivitysModel.h"
#import "NSString+Size.h"
#import "UIImageView+WebCache.h"
#import "LYZIndexController.h"
#import "UIView+SetRect.h"

@interface LYZActivitysCell ()

@property (nonatomic, strong) UIImageView *activityImg_1;
@property (nonatomic, strong) UIImageView *activityImg_2;
@property (nonatomic, strong) UILabel *scopeLabel_1;
@property (nonatomic, strong) UILabel *scopeLabel_2;
@property (nonatomic, strong) UILabel *subtitleLable_1;
@property (nonatomic, strong) UILabel *subtitleLable_2;
@property (nonatomic, strong) UILabel *pubtimeLabel_1;
@property (nonatomic, strong) UILabel *pubtimeLabel_2;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *btn2;

@end

static CGFloat _activitysHotelCellHeight = 365.0f;

@implementation LYZActivitysCell
- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)buildSubview {
    
    UIView *line = [[UIView alloc]  initWithFrame:CGRectMake( 105, 20, SCREEN_WIDTH - 105 *2, 1)];
    line.backgroundColor = LYZTheme_paleBrown;
    [self addSubview:line];
    
    UIView *round = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 8)/2.0, line.y - 3.5  , 8, 8)];
    round.layer.cornerRadius = 4;
    round.backgroundColor = LYZTheme_paleBrown;
    [self addSubview:round];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, line.bottom + 15, SCREEN_WIDTH, 24)];
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:20];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"品牌活动";
    [self addSubview:titleLabel];
    
    CGFloat leftspace = iPhone6_6sPlus ? 25:20;
    CGFloat space = 32;
    CGFloat imgSize = (SCREEN_WIDTH - leftspace*2 -space)/2.0;
    
    self.activityImg_1 = [[UIImageView alloc] initWithFrame:CGRectMake(leftspace,titleLabel.bottom + 23, imgSize, imgSize)];
    self.activityImg_2 =  [[UIImageView alloc] initWithFrame:CGRectMake(self.activityImg_1.right + space, titleLabel.bottom + 23, imgSize, imgSize)];
    [self addSubview:self.activityImg_1];
    [self addSubview:self.activityImg_2];
    
    self.scopeLabel_1 = [[UILabel alloc] initWithFrame:CGRectMake(self.activityImg_1.x, self.activityImg_1.bottom + 15, 150, 12)];
    self.scopeLabel_1.font = [UIFont fontWithName:LYZTheme_Font_Light size:12];
    self.scopeLabel_1.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.scopeLabel_1];
    
    self.scopeLabel_2 = [[UILabel alloc] initWithFrame:CGRectMake(self.activityImg_2.x, self.activityImg_2.bottom + 15, 150, 12)];
    self.scopeLabel_2.font = [UIFont fontWithName:LYZTheme_Font_Light size:12];
    self.scopeLabel_2.textColor = LYZTheme_warmGreyFontColor;
    [self addSubview:self.scopeLabel_2];
    
    self.subtitleLable_1 = [[UILabel alloc] initWithFrame:CGRectMake(self.activityImg_1.x, self.scopeLabel_1.bottom + 8, 150, 0)];
    self.subtitleLable_1.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    self.subtitleLable_1.textColor = LYZTheme_paleBrown;
    self.subtitleLable_1.numberOfLines = 0;
    [self addSubview:self.subtitleLable_1];
    
    self.subtitleLable_2 = [[UILabel alloc] initWithFrame:CGRectMake(self.activityImg_2.x, self.scopeLabel_1.bottom + 8, 150, 0)];
    self.subtitleLable_2.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    self.subtitleLable_2.textColor = LYZTheme_paleBrown;
     self.subtitleLable_2.numberOfLines = 0;
    [self addSubview:self.subtitleLable_2];
    
    self.pubtimeLabel_1 =  [[UILabel alloc] initWithFrame:CGRectMake(self.activityImg_1.x, self.subtitleLable_1.bottom + 8, 150, 14)];
    self.pubtimeLabel_1.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.pubtimeLabel_1.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.pubtimeLabel_1];
    
    self.pubtimeLabel_2 =  [[UILabel alloc] initWithFrame:CGRectMake(self.activityImg_2.x, self.subtitleLable_1.bottom + 8, 150, 14)];
    self.pubtimeLabel_2.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.pubtimeLabel_2.textColor = LYZTheme_BrownishGreyFontColor;
    [self addSubview:self.pubtimeLabel_2];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(leftspace, 0, 150 ,LYZActivitysCell.cellHeight );
    [self addSubview:self.btn];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2.frame = CGRectMake(self.btn.right + 38, 0, 150 ,LYZActivitysCell.cellHeight );
    [self addSubview:  self.btn2];
    
    
    
}


- (void)loadContent {
    NSArray <ActivitysModel *> *activitys = ( NSArray<ActivitysModel *> *)self.data;
    if (activitys.count == 0) {
        return;
    }else if (activitys.count == 1){
        ActivitysModel *model = activitys[0];
        [self.activityImg_1 sd_setImageWithURL:[NSURL URLWithString:model.imgpath] placeholderImage:nil];
        self.scopeLabel_1.text = model.scope;
        self.subtitleLable_1.text = model.subtitle;
        [self.subtitleLable_1 sizeToFit];
//        self.pubtimeLabel_1.text = model.pubtime;
//        self.pubtimeLabel_1.y = self.subtitleLable_1.bottom + 6;
         [self.btn addTarget:self action:@selector(activityOneClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        ActivitysModel *model = activitys[0];
        ActivitysModel *model2 = activitys[1];
        [self.activityImg_1 sd_setImageWithURL:[NSURL URLWithString:model.imgpath] placeholderImage:nil];
        [self.activityImg_2 sd_setImageWithURL:[NSURL URLWithString:model2.imgpath] placeholderImage:nil];
        self.scopeLabel_1.text = model.scope;
        self.scopeLabel_2.text = model2.scope;
        
        self.subtitleLable_1.text = model.subtitle;
        [self.subtitleLable_1 sizeToFit];
        
        self.subtitleLable_2.text = model2.subtitle;
        [self.subtitleLable_2 sizeToFit];
        
//        self.pubtimeLabel_1.text = model.pubtime;
////        self.pubtimeLabel_2.text = model2.pubtime;
//        self.pubtimeLabel_1.y = self.subtitleLable_1.bottom + 6;
//        self.pubtimeLabel_2.y = self.subtitleLable_2.bottom + 6;
        [self.btn2 addTarget:self action:@selector(activityTwoClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn addTarget:self action:@selector(activityOneClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _activitysHotelCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _activitysHotelCellHeight;
}

#pragma mark -- Private Method

+(CGFloat)addressCellHeight:(NSString *)str{
    CGFloat realHeight ;
    CGFloat totalStringHeight = [str heightWithFont:[UIFont fontWithName:LYZTheme_Font_Regular size:16] constrainedToWidth:150];
    if (totalStringHeight <= 23) {
        realHeight = 23.0f;
    }else{
        realHeight = totalStringHeight + 16;
    }
    return realHeight;
}

#pragma mark - Btn Action

-(void)activityOneClick:(id)sender{
    LYZIndexController *vc = (LYZIndexController *)self.controller;
    if ([vc respondsToSelector:@selector(activityDetail:)]) {
        NSArray <ActivitysModel *> *activitys = ( NSArray<ActivitysModel *> *)self.data;
        ActivitysModel *model = activitys[0];
        [vc activityDetail:model];
    }
}

-(void)activityTwoClick:(id)sender{
    LYZIndexController *vc = (LYZIndexController *)self.controller;
    if ([vc respondsToSelector:@selector(activityDetail:)]) {
        NSArray <ActivitysModel *> *activitys = ( NSArray<ActivitysModel *> *)self.data;
        ActivitysModel *model2 = activitys[1];
        [vc activityDetail:model2];
    }
    
}

@end
