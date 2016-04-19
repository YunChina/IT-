//
//  NewsViewCell.h
//  IT圈
//
//  Created by 云志强 on 16/3/1.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsViewCell : UITableViewCell
@property(nonatomic,strong)NewsModel *model;
@property(nonatomic,strong)UILabel *titlelabel;   //标题
@property(nonatomic,strong)UILabel *newsurllabel; //新闻内容网址
@property(nonatomic,strong)UILabel *postdate;     //时间
@property(nonatomic,strong)UIImageView *images;   //图片
@property(nonatomic,strong)UILabel *commentlabel; //评论条数
@end
