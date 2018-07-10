//
//  OrderGuestInfoCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "OrderCommitGuestInfoCell.h"
#import "OrderCommitCellMarcos.h"
#import "LYZOrderCommitViewController.h"
#import "LYZOrderGuestInfoModel.h"
#import "LYZContactsModel.h"



@interface OrderCommitGuestInfoCell ()

@property (nonatomic, strong) UILabel *guestTitleLabel;

@property (nonatomic, strong) UITextField *guestNameTF;

@property (nonatomic,strong) UITextField *identityTF;

@property (nonatomic, strong) UIButton *addGuestBtn;

@end

static CGFloat _OrderGuestInfoCellHeight = 60.0f;

@implementation OrderCommitGuestInfoCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.guestTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 90, OrderCommitGuestInfoCell.cellHeight)];
    self.guestTitleLabel.textColor = LYZTheme_warmGreyFontColor;
    self.guestTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14.0f];
    [self addSubview:self.guestTitleLabel];
    
    self.guestNameTF = [[UITextField alloc] initWithFrame:CGRectMake(self.guestTitleLabel.right + kTitle_Content_Space, 0, 150, OrderCommitGuestInfoCell.cellHeight/2.0)];
    self.guestNameTF.textColor = LYZTheme_greyishBrownFontColor;
    self.guestNameTF.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:16.0f];
    self.guestNameTF.enabled = NO;
    [self addSubview:self.guestNameTF];
    
    self.identityTF = [[UITextField alloc] initWithFrame:CGRectMake(self.guestTitleLabel.right + kTitle_Content_Space, self.guestNameTF.bottom, 150, OrderCommitGuestInfoCell.cellHeight/2.0)];
    self.identityTF.textColor = LYZTheme_warmGreyFontColor;
    self.identityTF.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
    self.identityTF.enabled = NO;
    [self addSubview:self.identityTF];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kTitle_Content_Space - 10, (OrderCommitGuestInfoCell.cellHeight  - 10) /2.0, 10, 10)];
    img.image = [UIImage imageNamed:@"indent_icon_show"];
    [self addSubview:img];

    
    UIButton *guestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    guestBtn.frame = CGRectMake(0, 0 , SCREEN_WIDTH, OrderCommitGuestInfoCell.cellHeight);
    [guestBtn addTarget:self action:@selector(AddGuestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:guestBtn];
    
   
}

-(UIButton *)addGuestBtn{
    if (!_addGuestBtn) {
        _addGuestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       _addGuestBtn.frame = CGRectMake(SCREEN_WIDTH - kTitle_Content_Space - 45, 0, 65, OrderCommitGuestInfoCell.cellHeight);
        
        [_addGuestBtn setImage:[UIImage imageNamed:@"add_guest"] forState:UIControlStateNormal];
        [_addGuestBtn addTarget:self action:@selector(AddGuestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addGuestBtn;
}

- (void)loadContent {
    LYZContactsModel *model = (LYZContactsModel *)self.data;
    self.guestTitleLabel.text = [NSString stringWithFormat:@"入住人(房间%li)",model.index];
    NSString *name = model.name ? model.name: @"";
    self.guestNameTF.text = [NSString stringWithFormat:@"%@",name];
    NSString *identity = model.phone ? model.phone:@"";
    self.identityTF.text = [NSString stringWithFormat:@"%@",identity];
//    if (self.indexPath.row == 9) {
//        [self addSubview:self.addGuestBtn];
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.guestNameTF.right + 35, (OrderCommitGuestInfoCell.cellHeight - 35)/2.0, 0.5, 35)];
//        line.backgroundColor = kLineColor;
//        [self addSubview:line];
//    }
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _OrderGuestInfoCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _OrderGuestInfoCellHeight;
}


#pragma mark --Btn Actions
-(void)AddGuestBtnClick:(UIButton *)sender{
    
    LYZContactsModel *model = (LYZContactsModel *)self.data;
    if ([self.controller respondsToSelector:@selector(addGuest:)]) {
        [(LYZOrderCommitViewController *)(self.controller) addGuest:model.index];
    }
}

-(void)guestBtnClick:(UIButton *)sender{
    if ([self.controller respondsToSelector:@selector(chooseGuest:)]) {
          LYZContactsModel *model = (LYZContactsModel *)self.data;
        [(LYZOrderCommitViewController *)(self.controller) chooseGuest:model.index];
    }
}


@end
