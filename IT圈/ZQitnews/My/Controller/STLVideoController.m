//
//  STLVideoController.m
//  IT圈
//
//  Created by 云志强 on 16/3/2.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "STLVideoController.h"
#import "LoginViewController.h"
#import "EnrollViewController.h"
#import "NewsViewController.h"
#import <Masonry.h>
@interface STLVideoController ()<LoginViewControllerDelegate, EnrollViewControllerDelegate>
@property(nonatomic,strong)UIImageView *logoimage;
@property(nonatomic,weak)UIButton *loginButton;
@property(nonatomic,weak)UIButton *enrollButton;
@property(nonatomic,weak)UIButton *returnButton;
@property(nonatomic,strong)UILabel *label;
@end

@implementation STLVideoController

- (void)zhucechenggong {
    [self.delegate zhucechenggong];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];
}
//logo 图片
- (UIImageView *)logoimage{
    if (!_logoimage) {
        UIImageView * image = [UIImageView new];
        _logoimage = image;
        [image setImage:[UIImage imageNamed:@"logo"]];
        [self.view addSubview:image];
    }
    return _logoimage;
}
//登录按钮
- (UIButton *)loginButton{
    if (!_loginButton) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _loginButton = btn;
        [btn addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"button"] forState:(UIControlStateNormal)];
        [self.view addSubview:btn];
    }
    return _loginButton;
}
//注册按钮
- (UIButton *)enrollButton{
    if (!_enrollButton) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _enrollButton = btn;
        [btn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(enrollButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    return _enrollButton;
}

- (void)loginchenggong {
    [self.delegate dengluchenggong];
}

//返回新闻界面
- (UIButton *)returnButton{
    if (!_returnButton) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _returnButton = btn;
        [btn addTarget:self action:@selector(returnButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"先逛逛" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
    return _returnButton;
}
-(void)layoutSubviews{
    //适配各种 iphone 屏幕
    self.logoimage.frame = CGRectMake(kScreenW-(kScreenW-30), 50, kScreenW-60, (kScreenW-60)/16*9);
    self.loginButton.frame = CGRectMake(kScreenW-(kScreenW-30),kScreenH-130 , kScreenW-60, 40);
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2, kScreenH-70, 5, 40)];
    self.enrollButton.frame = CGRectMake(kScreenW/2-100, kScreenH-70, 90, 40);
    self.returnButton.frame = CGRectMake(kScreenW/2+15, kScreenH-70, 60, 40);
    self.label.text = @"/";
    self.label.textColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    //去掉navigationController下边的阴影
    [self.navigationController.navigationBar.layer setMasksToBounds:YES];
}

//点击登录
-(void)loginButtonAction:(UIButton *)sender{
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.delegate = self;

    [self.navigationController pushViewController:loginVC animated:YES];
}
//注册
-(void)enrollButtonAction:(UIButton *)sender{
    EnrollViewController *enrollVC = [EnrollViewController new];
    enrollVC.delegate = self;
    [self.navigationController pushViewController:enrollVC animated:YES];
}

//到新闻界面
-(void)returnButtonAction:(UIButton *)sender{
    
    [_delegate dismissdefangfa];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
