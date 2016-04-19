//
//  NewsRequestData.m
//  IT圈
//
//  Created by 云志强 on 16/2/29.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "NewsRequestData.h"
#import "NewsModel.h"
#import <GDataXMLNode.h>
@implementation NewsRequestData
+ (void)getDataWithUrlStr:(NSString *)urlStr success:(void (^)(NSArray * array))success {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableArray * modelArr = [NSMutableArray array];
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSError * xmlDataErr = nil;
                GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:data error:&xmlDataErr];
                if (!xmlDataErr) {
                    GDataXMLElement * rootEle = [document rootElement];
                    NSArray * RootElements = [rootEle elementsForName:@"channel"];
                    GDataXMLElement * dataEle = RootElements.firstObject;
                    NSArray * array = [dataEle elementsForName:@"item"];
                    for (GDataXMLElement * ele in array) {
                        NewsModel * model = [[NewsModel alloc]init];
                        model.title = [[[ele elementsForName:@"title"] firstObject] stringValue];
                        model.newsurl = [[[ele elementsForName:@"url"] firstObject] stringValue];
                        model.postdate = [[[ele elementsForName:@"postdate"] firstObject]stringValue];
                        model.image = [[[ele elementsForName:@"image"] firstObject] stringValue];
                        model.commentcount = [[[ele elementsForName:@"commentcount"] firstObject] stringValue];
                        [modelArr addObject:model];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(modelArr.mutableCopy);
                    });
                } else {
                    NSLog(@"%@", error);
                }
            } else {
                NSLog(@"%@", error);
                return ;
            }
            
        }];
        [task resume];

    });
   
}

+ (void)getPicDataWithUrlStr:(NSString *)urlStr success:(void(^)(NSArray * picArr, NSArray * titleArr))success{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray * picArr = [NSMutableArray array];
        NSMutableArray * titleArr = [NSMutableArray array];
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSError * xmlDataErr = nil;
                GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:data error:&xmlDataErr];
                if (!xmlDataErr) {
                    GDataXMLElement * rootEle = [document rootElement];
                    NSArray * RootElements = [rootEle elementsForName:@"channel"];
                    GDataXMLElement * dataEle = RootElements.firstObject;
                    NSArray * array = [dataEle elementsForName:@"item"];
                    for (GDataXMLElement * ele in array) {
                        NewsModel * model = [[NewsModel alloc]init];
                        model.title = [[[ele elementsForName:@"title"] firstObject] stringValue];
                        model.image = [[[ele elementsForName:@"image"] firstObject] stringValue];
                        [picArr addObject:model.image];
                        [titleArr addObject:model.title];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        success(picArr.mutableCopy, titleArr.mutableCopy);
                    });
                } else {
                    NSLog(@"%@", error);
                }
            } else {
                NSLog(@"%@", error);
                return ;
            }
            
        }];
        [task resume];

        
    });
    
}
@end
