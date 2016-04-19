//
//  CollectionViewCell.h
//  IT圈
//
//  Created by 云志强 on 16/3/7.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImage * image;
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
@end
