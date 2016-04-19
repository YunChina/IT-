//
//  ReadRequestData.m
//  IT圈
//
//  Created by 云志强 on 16/3/2.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "ReadRequestData.h"
#import <AFNetworking.h>
#import "ReadModel.h"
@implementation ReadRequestData
+ (instancetype)shareRuqustData{
    static ReadRequestData * single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [ReadRequestData new];
    });
    return single;
}


- (void)getDataWithUrl:(NSString *)url block:(block)block {
    self.array = [NSMutableArray array];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSString * key in responseObject) {
            if ([key isEqualToString:@"段子"]) {
                for (NSDictionary * dic in responseObject[key]) {
                    ReadModel * model = [ReadModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.array addObject:model];
                }
            }
        }
        block(self.array.mutableCopy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
