//
//  BarCodeViewController.m
//  百宝箱
//
//  Created by huchunyuan on 15/10/12.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "BarCodeViewController.h"

//#import "UIImageView+WebCache.h"
#import <UIImageView+WebCache.h>
//#import "AFNetworking.h"
#import <AFNetworking.h>
@interface BarCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *titleSrc;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *faccode;
@property (weak, nonatomic) IBOutlet UILabel *goubie;
@property (weak, nonatomic) IBOutlet UILabel *fac_name;
@property (weak, nonatomic) IBOutlet UILabel *fac_status;
@property (nonatomic,strong) NSMutableDictionary *dic;
@end

@implementation BarCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dic = [NSMutableDictionary dictionary];
    /** AFNetWorking GET请求JSON */
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *str = @"http://www.liantu.com/tiaoma/query.php?ean=";
    NSString *url = [str stringByAppendingString:_ean];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"----------%@",responseObject);
        NSDictionary * dict = responseObject;
        
        self.fac_name.text = dict[@"fac_name"];
        self.faccode.text = dict[@"faccode"];
        self.fac_status = dict[@"fac_status"];
        self.price.text = [NSString stringWithFormat:@"%@元", [dict[@"price"] stringValue]];
        self.goubie.text = dict[@"guobie"];
        NSString *str = dict[@"titleSrc"];
        [self.titleSrc sd_setImageWithURL:[NSURL URLWithString:str]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
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
