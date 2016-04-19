//
//  NewsViewCell.m
//  IT圈
//
//  Created by 云志强 on 16/3/1.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "NewsViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "NewsModel.h"
@implementation NewsViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (UIImageView *)images {
    // 不要给他 frame, 不要给他任何关于位置的信息
    if (!_images) {
        _images = [UIImageView new];
        [_images sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
        [self.contentView addSubview:_images];
    }
    return _images;
}

-(UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [UILabel new];
        _titlelabel.numberOfLines = 2;
        _titlelabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titlelabel];
    }
    return _titlelabel;
}

-(UILabel *)postdate{
    if (!_postdate) {
        _postdate = [UILabel new];
        _postdate.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:_postdate];
    }
    return _postdate;
}

-(UILabel *)commentlabel{
    if (!_commentlabel) {
        _commentlabel = [UILabel new];
        _commentlabel.font = [UIFont systemFontOfSize:9];
        _commentlabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_commentlabel];
    }
    return _commentlabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WS(weakSelf);
    [self.images mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(10);
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.bottom.equalTo(weakSelf.contentView).offset(-5);
        make.width.mas_equalTo(85);
    }];
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.images).offset(3);
        make.left.equalTo(weakSelf.images.mas_right).offset(10);
        make.right.equalTo(weakSelf.contentView).offset(-10);
    }];
    
    [self.postdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-10);
        make.left.equalTo(weakSelf.images.mas_right).offset(10);
    }];
    
    [self.commentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-10);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
}

- (void)setModel:(NewsModel *)model{
    self.titlelabel.text = model.title;
    self.newsurllabel.text = model.newsurl;
    self.postdate.text = model.postdate;
    self.commentlabel.text = model.commentcount;
    [self.images sd_setImageWithURL:[NSURL URLWithString:model.image]];
}

@end
