//
//  ProblemTableViewCell.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/17.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "ProblemTableViewCell.h"

@interface ProblemTableViewCell()

@property (nonatomic ,strong) UILabel *problemLabel;

@end


@implementation ProblemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupCell];
    }
    
    return self;
}

-(void)setModel:(MyProblemModel *)model{
    self.problemLabel.text = model.reply;
     [self layoutSubviews];
}

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
}

-(UILabel *)problemLabel{
    if (!_problemLabel) {
        _problemLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _problemLabel.textColor = [UIColor blackColor];
        _problemLabel.font = [UIFont systemFontOfSize:14];
        _problemLabel.numberOfLines = 0;
        [self.contentView addSubview:_problemLabel];
    }
    return _problemLabel;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self buildSubview];
}

- (void)buildSubview {
    
//    UIView * roundView = [[UIView alloc] initWithFrame:CGRectMake(31, 30, 10, 10)];
//    roundView.layer.cornerRadius = 5;
//    roundView.backgroundColor = LYZTheme_paleBrown;
//    [self.contentView addSubview:roundView];
    CGFloat height = [[self class] HeightForText:self.problemLabel.text];
    self.problemLabel.frame      = CGRectMake(20 + 15,  20, SCREEN_WIDTH - 70, height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- Method

/// 返回Cell高度
+ (CGFloat)returnCellHeight:(MyProblemModel *)model
{
    CGFloat height = [[self class]  HeightForText:model.reply];
    return height + 40;
}

/// 计算内容文本的高度方法
+ (CGFloat)HeightForText:(NSString *)text
{
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize size = CGSizeMake(SCREEN_WIDTH - 70, 2000);
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
}



@end
