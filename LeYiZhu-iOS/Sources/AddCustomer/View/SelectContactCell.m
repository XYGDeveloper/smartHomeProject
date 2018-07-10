//
//  SelectContactCell.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/18.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "SelectContactCell.h"
#import "LYZContactsModel.h"

#define EditBtnWidth 22.0f

@interface SelectContactCell ()

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *contactNameLabel;

@end

static CGFloat _contactCellHeight = 47.0f;

@implementation SelectContactCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.backgroundColor = [UIColor whiteColor];
    self.selectBtn                        = [[UIButton alloc] initWithFrame:CGRectMake(DefaultLeftSpace - 10, 0 , SelectContactCell.cellHeight, SelectContactCell.cellHeight)];
    [self.selectBtn setImage:[UIImage imageNamed:@"indent_icon_unchoose"] forState:UIControlStateNormal];
//    [self.selectBtn addTarget:self action:@selector(selectContact:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectBtn];
    
    self.contactNameLabel           = [[UILabel alloc] initWithFrame:CGRectMake(self.selectBtn.right + 20, 0, 200, SelectContactCell.cellHeight)];
    self.contactNameLabel.textColor = LYZTheme_paleBrown;
    self.contactNameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [self addSubview:self.contactNameLabel];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - SelectContactCell.cellHeight, 0, SelectContactCell.cellHeight, SelectContactCell.cellHeight);
    [editBtn setImage:[UIImage imageNamed:@"EditContacts"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:editBtn];
}

- (void)loadContent {
    LYZContactsModel *model = self.data;
    self.contactNameLabel.text = model.name;
    if (model.unselectable) {
        [self.selectBtn setImage:[UIImage imageNamed:@"unselectable"] forState:UIControlStateNormal];
    }else{
        if (model.isSelect) {
             [self.selectBtn setImage:[UIImage imageNamed:@"indent_icon_choose"] forState:UIControlStateNormal];
        }else{
            [self.selectBtn setImage:[UIImage imageNamed:@"indent_icon_unchoose"] forState:UIControlStateNormal];
        }
        
    }
}

- (void)selectedEvent {
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
//        
//        [self.delegate customCell:self event:self.data];
//    }
    LYZContactsModel *model = (LYZContactsModel *)self.data;
    if (!model.unselectable) {
        if (self.selectBtnHandler) {
            self.selectBtnHandler(model);
        }
    }
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _contactCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return  _contactCellHeight;
}


#pragma mark - Btn Actions

//-(void)selectContact:(id)sender{
//     LYZContactsModel *model = (LYZContactsModel *)self.data;
//
//   if (self.selectBtnHandler) {
//    self.selectBtnHandler(model);
//   }
//
//}


-(void)editBtnClick:(id)sender{
    if (self.editBtnHandler) {
        self.editBtnHandler(self.data);
    }
}

@end
