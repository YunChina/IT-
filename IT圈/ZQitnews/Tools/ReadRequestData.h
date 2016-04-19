//
//  ReadRequestData.h
//  IT圈
//
//  Created by 云志强 on 16/3/2.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadModel.h"
typedef void(^block)(NSArray * array);

@interface ReadRequestData : NSObject
+ (instancetype)shareRuqustData;

- (void)getDataWithUrl:(NSString *)url block:(block)block;


@property(nonatomic,strong)NSMutableArray * array;



@end
