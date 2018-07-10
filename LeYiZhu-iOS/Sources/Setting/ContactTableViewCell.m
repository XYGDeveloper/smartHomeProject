//
//  ContactTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "Masonry.h"
@implementation ContactTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
        [self.contentView addSubview:_nameLabel];
        self.telephoneLabel = [[UILabel alloc]init];
        self.telephoneLabel.textColor =  [UIColor blackColor];
        self.telephoneLabel.textAlignment = NSTextAlignmentLeft;
        self.telephoneLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
        [self.contentView addSubview:_telephoneLabel];
        self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_editButton];
        [self.editButton setBackgroundImage:[UIImage imageNamed:@"EditContacts"] forState:UIControlStateNormal];
        [self.editButton addTarget:self action:@selector(toEdit:) forControlEvents:UIControlEventTouchUpInside];
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = kLineColor;
        [self.contentView addSubview:_line];
        
    }

    return self;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(10);
    }];
    [self.telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(2);
    }];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).mas_equalTo(-20);
        make.width.height.mas_equalTo(13);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(1);
        make.height.mas_equalTo(1);
        
    }];
    
    
    
    
}


- (void)toEdit:(UIButton *)toEdit{

    if (self.isEdit) {
        self.isEdit();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
