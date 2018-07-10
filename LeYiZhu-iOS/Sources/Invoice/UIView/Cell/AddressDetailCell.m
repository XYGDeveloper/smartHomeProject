//
//  AddressDetailCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AddressDetailCell.h"
#import "PlaceHolderTextView.h"
#import "NSString+Size.h"
#import "RecieverInfoModel.h"

#define kTitle_content_space 20.0f
#define kTFWidth 250.0f
#define minCellHeight 62.0f

@interface AddressDetailCell ()<UITextViewDelegate>

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) PlaceHolderTextView *contentTextView;


@end

@implementation AddressDetailCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, 60, minCellHeight)];
    self.titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
    self.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:15];
    [self addSubview:self.titleLabel];
    
    self.contentTextView = [[PlaceHolderTextView alloc] initWithFrame:CGRectMake(self.titleLabel.right + 20, (minCellHeight - 40)/2.0, SCREEN_WIDTH -140, 0)];
    self.contentTextView.delegate = self;
    //    self.contentTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.contentTextView.placeholderColor = RGB(200, 200, 200);
    self.contentTextView.backgroundColor = [UIColor clearColor];
    self.contentTextView.textColor = LYZTheme_BlackFontColorFontColor;
    self.contentTextView.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.contentTextView.scrollEnabled = NO;
    self.contentTextView.showsVerticalScrollIndicator = NO;
    self.contentTextView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.contentTextView];
}

- (void)loadContent {
    NSDictionary *dic = self.data;
    self.titleLabel.text = [dic objectForKey:@"title"];
    RecieverInfoModel *model = (RecieverInfoModel *)[dic objectForKey:@"content"];
    self.contentTextView.placeholder = [dic objectForKey:@"placeHolder"];
    
    if ([[dic objectForKey:@"title"] isEqualToString:@"详细地址"]) {
        if (model.address) {
            self.contentTextView.text = model.address;
        }
    }
    self.contentTextView.frame = CGRectMake(self.titleLabel.right + 20, (minCellHeight - 40)/2.0, SCREEN_WIDTH -140, [self heightForTextView]);
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+(CGFloat)cellHeightWithData:(id)data{
    NSString *content = data;
    CGFloat height;
    if (content) {
        UITextView *textview = [[UITextView alloc] init];
        textview.textColor = LYZTheme_BlackFontColorFontColor;
        textview.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
        textview.text = content;
        height = [textview sizeThatFits:CGSizeMake(SCREEN_WIDTH -140 , FLT_MAX)].height ;
        height += 22;
        
        //        CGSize constraint = CGSizeMake(SCREEN_WIDTH -140 - 16 , CGFLOAT_MAX);
        //        CGRect size = [content boundingRectWithSize:constraint
        //                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
        //                                         attributes:@{NSFontAttributeName:  [UIFont fontWithName:LYZTheme_Font_Regular size:15]}
        //                                            context:nil];
        //        height = size.size.height + 16;
        //
        //        height += 22;
        if (height < 62) {
            height = 62;
        }
        return height ;
    }else{
        return 62;
    }
}


- (float) heightForTextView{
    CGFloat height = [self.contentTextView sizeThatFits:CGSizeMake(self.contentTextView.width , FLT_MAX)].height ;
    LYLog(@" TextView height is ----> %f",height);
    return height;
}


- (CGFloat)cellHeight
{
    
    CGFloat height =[self heightForTextView] + 22;
    return MAX(minCellHeight, height );
}




#pragma mark -- TextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
    [UIView animateWithDuration:0.5 animations:^{
        [self updateUI]; //调整其他UI
        LYLog(@" cell height is ----> %f\n ContentView height is -- > %f",[self cellHeight],self.contentView.height);
        [self updateWithNewCellHeight:[self cellHeight] animated:YES];
        //
    } completion:nil];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    NSDictionary *dic = self.data;
    self.titleLabel.text = [dic objectForKey:@"title"];
    RecieverInfoModel *model = (RecieverInfoModel *)[dic objectForKey:@"content"];
    if ([[dic objectForKey:@"title"] isEqualToString:@"详细地址"]) {
        model.address = textView.text;
    }
    
}


-(void)updateUI{
    self.contentTextView.frame = CGRectMake(self.titleLabel.right + 20, (minCellHeight - 40)/2.0, SCREEN_WIDTH -140, [self heightForTextView]);
}


@end
