//
//  NewsModel.m
//  IT圈
//
//  Created by 云志强 on 16/2/29.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "NewsModel.h"   
#import <NSObject+NSCoding.h>

@implementation NewsModel


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self autoEncodeWithCoder:aCoder];
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        [self autoDecode:coder];
    }
    return self;
}


@end
