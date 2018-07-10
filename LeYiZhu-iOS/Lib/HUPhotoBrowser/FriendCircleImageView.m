//
//  FriendCircleImageView.m
//  ReactCocoaDemo
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "FriendCircleImageView.h"
#import "FriendCircleImageCell.h"
#import "SDPhotoBrowser.h"
#import "LTUITools.h"
#import "HUPhotoBrowser.h"
#import "HUImagePickerViewController.h"
#import "Masonry.h"
@interface FriendCircleImageView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SDPhotoBrowserDelegate,HUImagePickerViewControllerDelegate>

/** <#des#> */
//@property (nonatomic,strong) UICollectionView * collectionView;

/** <#des#> */
@property (nonatomic,strong) NSArray * images;
@end

@implementation FriendCircleImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self setConstant];
    }
    return self;
}

- (void)awakeFromNib
{
    
    [super awakeFromNib];
    [self setupUI];
    [self setConstant];
}

#pragma mark - 设置UI
- (void)setupUI
{
    self.collectionView = [LTUITools lt_creatCollectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    self.collectionView.scrollEnabled = NO;
    
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 4;
    layout.minimumInteritemSpacing = 4;
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerClass:[FriendCircleImageCell class] forCellWithReuseIdentifier:@"FriendCircleImageCell"];
    [self addSubview:self.collectionView];
    
}

#pragma mark - 设置约束
- (void)setConstant
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCircleImageCell * cell = (FriendCircleImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FriendCircleImageCell" forIndexPath:indexPath];
    [cell cellDataWithImageName:self.images[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.images.count == 1) {
        return CGSizeMake((kScreenWidth - 88)/3, (kScreenWidth - 88)/3);
    } else if(self.images.count >1){
        return CGSizeMake((kScreenWidth - 88)/3, (kScreenWidth - 88)/3);
    }else{
        return CGSizeMake(0,0);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = indexPath.row;
    browser.sourceImagesContainerView = self.collectionView;
    browser.imageCount = self.images.count;
    browser.delegate = self;
    [browser show];
    
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSURL *url;
    if (index < self.images.count) {
        url = [NSURL URLWithString:self.images[index]];
    }
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    FriendCircleImageCell * cell = (FriendCircleImageCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"FriendCircleImageCell" forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return cell.imageView.image;
}

- (void)cellDataWithImageArray:(NSArray *)imageArray
{
    self.images = imageArray;
    CGFloat height = 0;
    if (imageArray.count == 1) {
        height = (kScreenWidth - 88)/3;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(height);
        }];
    } else if (imageArray.count > 1){
        int columnCount = ceilf(self.images.count * 1.0 / 3);
        height = ((kScreenWidth - 88)/3) * columnCount;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    } else{
        height = 0;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    }
    
    [self.collectionView reloadData];
}

@end
