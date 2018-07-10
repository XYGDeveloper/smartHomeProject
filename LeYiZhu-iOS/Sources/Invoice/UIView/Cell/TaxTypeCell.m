//
//  InvoiceTaxTypeCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "TaxTypeCell.h"
#import "InvoiceTitleModel.h"
#import "InvoiceTitleInfoViewController.h"

#define kTitle_content_space 20.0f
#define KSelectImgWidth 17.0f

@interface TaxTypeCell ()

@property (nonatomic, strong) UIImageView *enterpriseImgView;

@property (nonatomic, strong) UIImageView *governmentImgView;

@property (nonatomic, strong) UIImageView *personalImgView;

@property (nonatomic, strong) UILabel *enterpriseLabel;

@property (nonatomic, strong) UILabel *governmentLabel;

@property (nonatomic, strong) UILabel *personalLabel;


@end

static CGFloat _taxTypeCellHeight = 62.0f;

@implementation TaxTypeCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 60, TaxTypeCell.cellHeight)];
    titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    titleLabel.text = @"类型";
    [self addSubview:titleLabel];
    
    self.enterpriseImgView = [[UIImageView alloc] initWithFrame:CGRectMake(titleLabel.right + kTitle_content_space, (TaxTypeCell.cellHeight - KSelectImgWidth)/2.0, KSelectImgWidth, KSelectImgWidth)];
    self.enterpriseImgView.image = [UIImage imageNamed:@"icon_unchoice"];
    [self addSubview:self.enterpriseImgView];
    
    self.enterpriseLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.enterpriseImgView.right + 8, 0, 50, TaxTypeCell.cellHeight)];
    self.enterpriseLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
//    self.enterpriseLabel.textColor = [UIColor blackColor];
    self.enterpriseLabel.textColor = LYZTheme_BlackFontColorFontColor;
    self.enterpriseLabel.text  =@"企业";
    [self addSubview:self.enterpriseLabel];
    
    self.governmentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_enterpriseLabel.right ,  (TaxTypeCell.cellHeight - KSelectImgWidth)/2.0, KSelectImgWidth, KSelectImgWidth)];
    self.governmentImgView.image = [UIImage imageNamed:@"icon_unchoice"];
    [self addSubview:self.governmentImgView];
    
    self.governmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.governmentImgView.right + 8, 0, 80, TaxTypeCell.cellHeight)];
    self.governmentLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    self.governmentLabel.textColor =LYZTheme_BlackFontColorFontColor;
    self.governmentLabel.numberOfLines = 0;
    self.governmentLabel.text  =@"政府机关\n行政机构";
    [self addSubview:self.governmentLabel];
    
    self.personalImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_governmentLabel.right,  (TaxTypeCell.cellHeight - KSelectImgWidth)/2.0, KSelectImgWidth, KSelectImgWidth)];
    self.personalImgView.image = [UIImage imageNamed:@"icon_unchoice"];
    [self addSubview:self.personalImgView];
    
    self.personalLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.personalImgView.right + 8, 0, 40, TaxTypeCell.cellHeight)];
    self.personalLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    self.personalLabel.textColor = LYZTheme_BlackFontColorFontColor;
    self.personalLabel.text  =@"个人";
    [self addSubview:self.personalLabel];
    
    UIButton *enterpriseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterpriseBtn.frame = CGRectMake(_enterpriseImgView.x - 5, 0, 85, TaxTypeCell.cellHeight);
    enterpriseBtn.tag =  100;
    [enterpriseBtn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:enterpriseBtn];
    
    UIButton *governmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    governmentBtn.frame = CGRectMake(_governmentImgView.x - 5, 0, 100, TaxTypeCell.cellHeight);
    governmentBtn.tag =  101;
    [governmentBtn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:governmentBtn];
    
    UIButton *personalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    personalBtn.frame = CGRectMake(_personalImgView.x - 5, 0, 60, TaxTypeCell.cellHeight);
    personalBtn.tag =  102;
    [personalBtn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:personalBtn];
}

- (void)loadContent {
    InvoiceTitleModel *model = (InvoiceTitleModel *)self.data;
    [self setItemSelected:(NSInteger)model.type];
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _taxTypeCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _taxTypeCellHeight;
}

-(void)setItemSelected:(NSInteger)index{
    self.enterpriseImgView.image = [UIImage imageNamed:@"icon_unchoice"];
    self.enterpriseLabel.textColor = [UIColor blackColor];
    self.governmentImgView.image = [UIImage imageNamed:@"icon_unchoice"];
    self.governmentLabel.textColor = [UIColor blackColor];
    self.personalImgView.image = [UIImage imageNamed:@"icon_unchoice"];
    self.personalLabel.textColor = [UIColor blackColor];
    if (index == 0) {
        self.enterpriseImgView.image = [UIImage imageNamed:@"icon_choice"];
        self.enterpriseLabel.textColor = LYZTheme_paleBrown;
    }else if (index == 1){
        self.governmentImgView.image = [UIImage imageNamed:@"icon_choice"];
        self.governmentLabel.textColor = LYZTheme_paleBrown;
    }else if (index == 2){
        self.personalImgView.image = [UIImage imageNamed:@"icon_choice"];
        self.personalLabel.textColor = LYZTheme_paleBrown;
    }
}

#pragma mark -- Btn Actions

-(void)btnSelected:(UIButton *)sender{
    NSInteger index = sender.tag - 100;
    [self setItemSelected:index];
     InvoiceTitleModel *model = (InvoiceTitleModel *)self.data;
    model.type = (taxType)index;
    InvoiceTitleInfoViewController *vc = (InvoiceTitleInfoViewController *)self.controller;
    if ([vc respondsToSelector:@selector(taxTypeSelected:)]) {
        [vc taxTypeSelected:model];
    }
}

@end
