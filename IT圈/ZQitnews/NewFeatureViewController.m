//
//  NewFeatureViewController.m
//  IT圈
//
//  Created by 云志强 on 16/3/7.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "CollectionViewCell.h"
@interface NewFeatureViewController ()

@end

@implementation NewFeatureViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutCollectionViews];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)init {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置滚动方式
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置 cell 尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 清空间距
    layout.minimumLineSpacing = 0;
    return [self initWithCollectionViewLayout:layout];
}
- (void)layoutCollectionViews {
    // self.view != self.collectionView
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // 分页
    self.collectionView.pagingEnabled = YES;
    // 反弹
    self.collectionView.bounces = NO;
    // 滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString * imgName = [NSString stringWithFormat:@"IT_%ld", indexPath.row + 1];
    cell.image = [UIImage imageNamed:imgName];
    [cell setIndexPath:indexPath count:[self collectionView:self.collectionView numberOfItemsInSection:indexPath.section]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
