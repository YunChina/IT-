//
//  WebViewController.m
//  IT圈
//
//  Created by 云志强 on 16/3/7.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "WebViewController.h"
#import "NewsModel.h"
@interface WebViewController ()
@property(nonatomic,strong)UIWebView *webview;
@end

@implementation WebViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableString *str = [NSMutableString new];
    [str appendString:self.model.newsurl];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", kWeb, str];
    NSLog(@"%@",urlStr);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"preview_lastbtn2"] style:(UIBarButtonItemStyleDone) target:self action:@selector(webView)];
    self.webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webview.scalesPageToFit = YES;//自适应手机尺寸
    [self.view addSubview:_webview];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
}

- (void)webView{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
