//
//  NewsModel.h
//  IT圈
//
//  Created by 云志强 on 16/2/29.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject<NSCoding>
/**
 *  内容页网址
 */
@property (nonatomic, strong) NSString * newsurl;

/**
 *  标题
 */
@property (nonatomic, strong) NSString * title;
/**
 *  图片的地址
 */
@property (nonatomic, strong) NSString * image;
/**
 *  时间
 */
@property (nonatomic, strong) NSString * postdate;
/**
 *  评论数量
 */
@property (nonatomic, strong) NSString * commentcount;

@end
