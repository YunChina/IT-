//
//  ReadModel.m
//  IT圈
//
//  Created by 云志强 on 16/3/2.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "ReadModel.h"
#import <NSObject+NSCoding.h>

@implementation ReadModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

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
