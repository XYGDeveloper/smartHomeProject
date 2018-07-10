//
//  LYZMineFunctionsCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZMineFunctionsCell.h"
#import "MineFunctionsCollectionViewCell.h"
#import "LYZMineViewController.h"

@interface LYZMineFunctionsCell  ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;

@end

static CGFloat _FunctionsCellHeight = 280.0f;

@implementation LYZMineFunctionsCell

- (void)setupCell {
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)buildSubview {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing=0.f;//item左右间隔
    layout.minimumLineSpacing=0.f;//item上下间隔
    layout.sectionInset=UIEdgeInsetsMake(0,0,0, 0);//item对象上下左右的距离
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/3.0, 120);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, LYZMineFunctionsCell.cellHeight - 20) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    //代理设置
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;    //注册item类型 这里使用系统的类型
    [self.collectionView registerClass:[MineFunctionsCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    self.collectionView.scrollEnabled = NO;
    [self addSubview:self.collectionView];
}

- (void)loadContent {
    self.dataSource = self.data;
    [self.collectionView reloadData];
}


#pragma mark - Collection Delegate

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineFunctionsCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid"
                                                                             forIndexPath:indexPath];
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.imageName = dic[@"icon"];
    cell.title = dic[@"title"];
    cell.subTitle = dic[@"subTitle"];
    return cell;
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LYZMineViewController *vc = (LYZMineViewController *)self.controller;
    if ([vc respondsToSelector:@selector(didSelectedFunctionItemAtIndex:)]) {
        [vc didSelectedFunctionItemAtIndex:indexPath.row];
    }
}




#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _FunctionsCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _FunctionsCellHeight;
}


@end
