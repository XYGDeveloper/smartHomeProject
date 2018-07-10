//
//  LYZTagsCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZTagsCell.h"
#import "IrregularGridCollectionView.h"
#import "LYZFacilitiesIrregularCell.h"
#import "NSString+Size.h"
#import "NSString+LabelWidthAndHeight.h"


#define FacilitiesBtnHeight 25.0f

typedef enum : NSUInteger {
    
    DirectionHorizontalType = 1000,
    DirectionVerticalType,
    
} IrregularGridCollectionViewTag;


@interface LYZTagsCell ()<IrregularGridCollectionViewDelegate>

@property(nonatomic , strong) IrregularGridCollectionView *irregularGridView;

@end

@implementation LYZTagsCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    self.irregularGridView = [IrregularGridCollectionView irregularGridCollectionViewWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 0)
                                                                                      delegate:self
                                                                                 registerCells:@[gridViewCellClassType([LYZFacilitiesIrregularCell class],  nil)]
                                                                               scrollDirection:UICollectionViewScrollDirectionVertical
                                                                             contentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                                   lineSpacing:10
                                                                              interitemSpacing:10.f
                                                                                    gridHeight:FacilitiesBtnHeight];
    self.irregularGridView.tag      = DirectionVerticalType;
    [self.contentView addSubview:self.irregularGridView];
    
}


- (void)loadContent {
    HotelIntroModel *hotelIntro = (HotelIntroModel *)self.data;
    
    NSString *tags = [hotelIntro.tags stringByReplacingOccurrencesOfString:@" " withString:@""]; //去掉空字符
    NSMutableArray *array  = [NSMutableArray array];
    if (tags && tags.length > 0 ) {
        NSArray *tagsArr = [tags componentsSeparatedByString:@","];
        if (tagsArr.count > 0) {
            for (int i = 0; i < tagsArr.count; i++) {
                
                NSString *string = tagsArr[i];
                CGFloat   value  = [string widthWithStringFont:[UIFont fontWithName:@"Avenir-Light" size:12]] + FacilitiesBtnHeight ;
                [array addObject:[LYZFacilitiesIrregularCell  dataAdapterWithData:string type:0 itemWidth:value]];
            }
        }
    }
    self.irregularGridView.adapters = array;
    [self.irregularGridView resetSize];
    if (self.dataAdapter.cellHeight !=  self.irregularGridView.height + 15) {
        [self updateWithNewCellHeight: self.irregularGridView.height + 15 animated:YES];
    }
    
    
}

- (void)selectedEvent {
    
}

#pragma mark - class property.



@end
