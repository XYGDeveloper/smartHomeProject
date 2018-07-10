//
//  LYZFacilitiesCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZHotelFacilitiesCell.h"
#import "NSString+Size.h"
#import "UIView+SetRect.h"
#import "IrregularGridCollectionView.h"
#import "NSString+LabelWidthAndHeight.h"
#import "UILabel+SizeToFit.h"
#import "LYZFacilitiesIrregularCell.h"
#import "LYZHotelDetailModel.h"

#define FacilitiesBtnWidth  45.0f
#define FacilitiesBtnHeight 25.0f
#define FacilitiesBtnGap  5.0f

@interface LYZHotelFacilitiesCell ()<IrregularGridCollectionViewDelegate>

@property(nonatomic , strong) IrregularGridCollectionView *irregularGridView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

static CGFloat _HotelFacilitiesCellHeight = 45.0f;

@implementation LYZHotelFacilitiesCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
}


- (void)buildSubview {
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - 15 ,(LYZHotelFacilitiesCell.cellHeight - 15)/2.0  , 15, 15)];
    arrowImg.image = [UIImage imageNamed:@"hotle_icon_show"];
    [self addSubview:arrowImg];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    self.titleLabel.textColor = LYZTheme_paleBrown;
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    NSString *text = @"酒店详情";
    [self.titleLabel sizeToFitWithText:text config:^(UILabel *label) {
        label.centerY = self.height/2.0;
        label.right = arrowImg.left - 10;
    }];
    [self addSubview:self.titleLabel];
}


- (void)createDirectionVerticalType:(NSArray *)tags {
    
    // Create dataSource.
    NSMutableArray *array  = [NSMutableArray array];
//    NSArray        *titles = @[@"临近地铁",
//                               @"极速WiFi",
//                               @"乳胶大床",
//                               @"超大淋浴",
//                               @"有窗户",
//                               @"隔音好",
//                               @"互联网电视"
//                               ];
    
    for (int i = 0; i < tags.count; i++) {
        
        NSString *string = tags[i];
        CGFloat   value  = [string widthWithStringFont:[UIFont fontWithName:@"Avenir-Light" size:11]] + 20 ;
        [array addObject:[LYZFacilitiesIrregularCell  dataAdapterWithData:string type:0 itemWidth:value]];
        
    }
    
    // Create IrregularGridCollectionView.
    //    IrregularGridCollectionView *irregularGridView;
    self.irregularGridView = [IrregularGridCollectionView irregularGridCollectionViewWithFrame:CGRectMake(10, 0,  _titleLabel.left - 20, 0)
                                                                                      delegate:self
                                                                                 registerCells:@[gridViewCellClassType([LYZFacilitiesIrregularCell class],  nil)]
                                                                               scrollDirection:UICollectionViewScrollDirectionVertical
                                                                             contentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                                   lineSpacing:10
                                                                              interitemSpacing:10.f
                                                                                    gridHeight:FacilitiesBtnHeight];
    self.irregularGridView.adapters = array;
    [self.irregularGridView resetSize];
    [self.contentView addSubview:self.irregularGridView];
    
}


- (void)loadContent {
    LYZHotelDetailModel *model = (LYZHotelDetailModel *)self.data;
    NSString *tags = model.tags;
    tags = [tags stringByReplacingOccurrencesOfString:@" " withString:@""]; //去掉空字符
    if (tags && tags.length > 0 ) {
        NSArray *array = [tags componentsSeparatedByString:@","];
        if (array.count) {
            [self createDirectionVerticalType:array];
        }
    }
   
    
      
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _HotelFacilitiesCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _HotelFacilitiesCellHeight;
}

#pragma mark - Btn Actions


@end
