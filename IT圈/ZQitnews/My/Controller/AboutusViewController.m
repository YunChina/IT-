//
//  AboutusViewController.m
//  IT圈
//
//  Created by 云志强 on 16/3/7.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "AboutusViewController.h"

@interface AboutusViewController ()
@property(nonatomic,strong)UILabel *labeltitle;
@property(nonatomic,strong)UILabel *label;
@end

@implementation AboutusViewController

- (UILabel *)labeltitle{
    if (!_labeltitle) {
        UILabel * label = [UILabel new];
        _labeltitle = label;
        label.text = @"关于我们";
        label.font = [UIFont systemFontOfSize:30];
        [self.view addSubview:label];
    }
    return _labeltitle;
}- (UILabel *)label{
    if (!_label) {
        UILabel * label = [UILabel new];
        _label = label;
        label.text = @"     IT圈，专注与IT类的新闻APP，因为专注，所以专业。微博及腾讯QQ的SSO授权登录正在紧张修复中，刀已经架在程序猿脖子上。下个版本见!如果您有好的建议可以联系我们。\n\n邮箱:y@hbcsxy.com  \n新浪微博:@云志强\nTwitter:@yunzhiqiang";
        label.font = [UIFont systemFontOfSize:18];
        label.numberOfLines = 0;
        [self.view addSubview:label];
    }
    return _label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.labeltitle.frame = CGRectMake(kScreenW/2-70, 70, 140, 40);
    self.label.frame = CGRectMake(20,130 , kScreenW-40, 240);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"preview_lastbtn2"] style:(UIBarButtonItemStyleDone) target:self action:@selector(webView)];
}
-(void)webView{
    [self.navigationController popViewControllerAnimated:YES];
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
