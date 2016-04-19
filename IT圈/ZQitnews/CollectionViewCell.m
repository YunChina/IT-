//
//  CollectionViewCell.m
//  IT圈
//
//  Created by 云志强 on 16/3/7.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "CollectionViewCell.h"
#import "BeginViewController.h"
@interface CollectionViewCell ()

@property (nonatomic, weak) UIImageView * imageView;

@end

@implementation CollectionViewCell

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.userInteractionEnabled = YES;
        _imageView = imgView;
        [self.contentView addSubview:imgView];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    
}
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count {
    if (indexPath.row == count - 1) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self.imageView addGestureRecognizer:tap];
    } else {
 
    }
}

- (void)tapAction {
    BeginViewController * beginVC = [[BeginViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = beginVC;
}

@end
