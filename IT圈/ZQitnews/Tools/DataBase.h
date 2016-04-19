//
//  DataBase.h
//  IT圈
//
//  Created by 云志强 on 16/3/5.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface DataBase : NSObject

// 打开数据库
+ (FMDatabase *)openDataBase;

// 关闭数据库
+ (void)closeDataBase;

/** 归档 */
+ (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key;

/** 返归档 */
+ (id)unarchiverObject:(NSData *)data forKey:(NSString *)key;

/** 插入一条数据, 给一个标识符 */
+ (void)insertObject:(id)anyObject title:(NSString *)title;

/** 从数据库获取数据(这个是一个数组) */
+ (id)getDataWithDatabase:(NSString *)title;


@end
