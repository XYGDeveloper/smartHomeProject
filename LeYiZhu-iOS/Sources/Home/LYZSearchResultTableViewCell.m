//
//  LYZSearchResultTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/4/20.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZSearchResultTableViewCell.h"
#import "Masonry.h"
#import "SearchLoadHotelModel.h"
#define GeneralLabel(f, c) [UIHelper labelWithFont:f textColor:c]
#define GeneralLabelA(f, c, a) [UIHelper labelWithFont:f textColor:c textAlignment:a]
@interface LYZSearchResultTableViewCell()


@end


@implementation LYZSearchResultTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.HotelNameLabel = [[UILabel alloc]init];
        self.HotelNameLabel.textColor = [UIColor blackColor];
        self.HotelNameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        [self.contentView addSubview:self.HotelNameLabel];
        self.separatorInset = UIEdgeInsetsZero;
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            self.layoutMargins = UIEdgeInsetsZero;
        }
        if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            self.preservesSuperviewLayoutMargins = NO;
        }
        
        [self configLaout];
    }
    return self;
}

- (void)refreshWithSearchGoodsModel:(SearchLoadHotelModel *)resultModel withSearchText:(NSString *)searchText {
    
    // 获取关键字的位置
    NSRange range = [resultModel.name rangeOfString:searchText];
    // 转换成可以操作的字符串类型.
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:resultModel.name];
    
    // 添加属性(粗体)
    [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:range];
    
    // 关键字高亮
    [attribute addAttribute:NSForegroundColorAttributeName value:LYZTheme_paleBrown range:range];
    
    // 将带属性的字符串添加到cell.textLabel上.
    [self.HotelNameLabel setAttributedText:attribute];
    
}

#pragma mark - Layout
- (void)configLaout {
    
    [self.HotelNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(- 10);
        make.top.equalTo(@5);
        make.height.mas_equalTo(35);
    }];
}


#pragma mark - Properties

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
