//
//  LoginViewController.m
//  IT圈
//
//  Created by 云志强 on 16/3/2.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "LoginViewController.h"
#import "UITextField+Shake.h"
@interface LoginViewController ()

@property(nonatomic,strong)UITextField *nameField;
@property(nonatomic,strong)UITextField *passworkField;
@property(nonatomic,weak)UIButton *loginBut;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,weak)UIButton * weiboBtn;
@property(nonatomic,weak)UIButton * TencentBtn;
@property(nonatomic,weak)UIButton * WeChatBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];
}
//帐号
- (UITextField *)nameField{
    if (!_nameField) {
        UITextField *textField = [UITextField new];
        _nameField = textField;
        textField.placeholder = @"请输入帐号";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:textField];
    }
    return _nameField;
}
//密码
- (UITextField *)passworkField{
    if (!_passworkField) {
        UITextField *textField = [UITextField new];
        _passworkField = textField;
        textField.placeholder = @"请输入密码";
        textField.secureTextEntry = YES;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:textField];
    }
    return _passworkField;
}

//登录按钮
- (UIButton *)loginBut{
    if (!_loginBut) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _loginBut = btn;
        [btn addTarget:self action:@selector(loginButAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"button"] forState:(UIControlStateNormal)];
        [self.view addSubview:btn];
    }
    return _loginBut;
}
//其他方式登录
- (UILabel *)label{
    if (!_label) {
        UILabel * label = [UILabel new];
        _label = label;
        label.text = @"其他方式登录";
        label.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:label];
    }
    return _label;
}
//微博
- (UIButton *)weiboBtn{
    if (!_weiboBtn) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _weiboBtn = btn;
        [btn addTarget:self action:@selector(weibobtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setBackgroundImage:[UIImage imageNamed:@"weico_light"] forState:(UIControlStateNormal)];
        [self.view addSubview:btn];
    }
    return _weiboBtn;
}
//腾讯 QQ 登录
- (UIButton *)TencentBtn{
    if (!_TencentBtn) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _TencentBtn = btn;
        [btn addTarget:self action:@selector(tencentbtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setBackgroundImage:[UIImage imageNamed:@"qq_light"] forState:(UIControlStateNormal)];
        [self.view addSubview:btn];
    }
    return _TencentBtn;
}

//布局视图
-(void)layoutSubviews{
    //背景
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    [imgview setImage:[UIImage imageNamed:@"backdrop"]];
    [self.view addSubview:imgview];
    //title 字体以及颜色
    self.title = @"登录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"preview_lastbtn2"] style:(UIBarButtonItemStyleDone) target:self action:@selector(webView)];
    //适配各种 iphone 屏幕
    self.loginBut.frame = CGRectMake(kScreenW-(kScreenW-70),kScreenH/5+140 , kScreenW-140, 40);
    self.nameField.frame = CGRectMake(kScreenW-(kScreenW-70), kScreenH/5, kScreenW-140, 40);
    self.passworkField.frame = CGRectMake(kScreenW-(kScreenW-70), kScreenH/5+60, kScreenW-140, 40);
    self.label.frame = CGRectMake(kScreenW/2-40, kScreenH/2+20, 80, 30);
    self.weiboBtn.frame = CGRectMake(kScreenW/3-25, kScreenH/2+60, 50, 50);
    self.TencentBtn.frame = CGRectMake(kScreenW/3*2-25, kScreenH/2+60, 50, 50);
}

-(void)webView{
    [self.navigationController popViewControllerAnimated:YES];
}
//登录按钮触发方法
-(void)loginButAction:(UIButton *)sender{
    // 判断用户名和密码是否为空
    if (self.nameField.text.length == 0) {
        [self.nameField shake];
        return;
    }else if(self.passworkField.text.length == 0) {
        [self.passworkField shake];
        return;
    }
    //登录....
    if ([[NSUserDefaults standardUserDefaults]objectForKey:self.nameField.text]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults]setObject:self.nameField.text forKey:@"userName"];
        [self.delegate loginchenggong];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查您的帐号密码是否匹配" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];

    }
    
}
//TextFild 内无内容时点击登录TextFild抖动
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameField resignFirstResponder];
    [self.passworkField resignFirstResponder];
}

//微博按钮触发方法
- (void)weibobtnAction:(UIButton *)btn {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此功能正在紧张适配中, 敬请关注IT圈V1.1版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
//    WeiBoViewController * weiboVC = [[WeiBoViewController alloc]init];
//    [self showViewController:weiboVC sender:nil];
}
//腾讯按钮触发方法
- (void)tencentbtnAction:(UIButton *)btn {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此功能正在紧张适配中, 敬请关注IT圈V1.1版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
//    TencentViewController * tencentVC = [[TencentViewController alloc]init];
//    [self showViewController:tencentVC sender:nil];
}


@end
