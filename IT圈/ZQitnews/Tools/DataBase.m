//
//  DataBase.m
//  IT圈
//
//  Created by 云志强 on 16/3/5.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "DataBase.h"

@implementation DataBase

+ (FMDatabase *)openDataBase {
    NSString * dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"db.sqlite"];
    FMDatabase * database = [FMDatabase databaseWithPath:dbPath];
    NSLog(@"%@", dbPath);
    [database open];
    [database executeUpdate:@"create table LastData(title text, data blob)"];
    if ([database open]) {
        return database;
    }
    return nil;
}

// 将对象归档和反归档
+ (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    return data;
}
//反归档
+ (id)unarchiverObject:(NSData *)data forKey:(NSString *)key{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id object = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    return object;
}

+ (void)closeDataBase {
    [[DataBase openDataBase]close];
}

+ (void)deleteDataWithTitle:(NSString *)title {
    [[DataBase openDataBase] executeUpdate:@"delete from LastData where title = ?", title];
}

+ (void)insertObject:(id)anyObject title:(NSString *)title {
    [self deleteDataWithTitle:title];
    NSData * data = [self dataOfArchiverObject:anyObject forKey:title];
    [[DataBase openDataBase] executeUpdate:@"insert into LastData (title, data) values (?,?)", title, data];
}

+ (id)getDataWithDatabase:(NSString *)title {
    NSArray * array;
    FMResultSet * set = [[DataBase openDataBase] executeQuery:@"select data FROM LastData"];
    while (set.next) {
        NSData * data = [set dataForColumn:[NSString stringWithFormat:@"data"]];
        array = [self unarchiverObject:data forKey:title];
    }
    return array;
}




@end
