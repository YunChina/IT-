//
//  PhotoWebViewController.m
//  工具箱
//
//  Created by huchunyuan on 15/10/8.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "PhotoWebViewController.h"
#import "AFNetworking.h"

@interface PhotoWebViewController ()<UIWebViewDelegate>

@end

@implementation PhotoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = nil;
    self.title = @"浏览网址";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *str = [_path substringToIndex:3];
    NSLog(@"%@",str);

        if ([str isEqualToString:@"www"]) {
            url = [@"http://" stringByAppendingString:_path];
            [self webViewWithUrlStr:url];
        }else if([str isEqualToString:@"htt"]){
            url = _path;
            [self webViewWithUrlStr:url];
        }else{
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 50, [UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.height-100)];
            textView.text = _path;
            textView.font = [UIFont systemFontOfSize:40];
            [self.view addSubview:textView];
        }
    

}
- (void)webViewWithUrlStr:(NSString *)url{
    UIWebView *wv = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:wv];
    wv.delegate = self;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSLog(@"===%@",self.path);
    [wv loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
