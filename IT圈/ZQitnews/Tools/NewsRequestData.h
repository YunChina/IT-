//
//  NewsRequestData.h
//  IT圈
//
//  Created by 云志强 on 16/2/29.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsRequestData : NSObject
+ (void)getDataWithUrlStr:(NSString *)urlStr success:(void(^)(NSArray * array))success;
+ (void)getPicDataWithUrlStr:(NSString *)urlStr success:(void(^)(NSArray * picArr, NSArray * titleArr))success;

@end
