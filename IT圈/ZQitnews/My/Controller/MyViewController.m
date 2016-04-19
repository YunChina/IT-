//
//  MyViewController.m
//  IT圈
//
//  Created by 云志强 on 16/2/29.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "MyViewController.h"
#import "STLVideoController.h"
#import "AboutusViewController.h"
#import "QRCodeViewController.h"
#import "MBProgressHUD+MJ.h"
#import <UIImageView+WebCache.h>

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate, STLVideoControllerDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UIImageView *image;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableview];
    
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.bounces=NO;
    self.tableview.showsVerticalScrollIndicator = NO;//不显示右侧滑块
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;//分割线
    self.arr=@[@"扫一扫",@"清理缓存",@"关于我们"];

    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.label.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"]) {
        
    } else {
        STLVideoController *stlVideo = [STLVideoController new];
        stlVideo.delegate = self;
        UINavigationController *stlVideoNV = [[UINavigationController alloc]initWithRootViewController:stlVideo];
        [stlVideoNV.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
        [self presentViewController:stlVideoNV animated:YES completion:nil];
    }
}

#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分组数 也就是section数
    return 3;
}


- (void)zhucechenggong {
    self.tabBarController.selectedIndex = 2;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1) {
        return self.arr.count;
    }else{
        return 1;
    }

}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 40;
    }else if (section==1) {
        return 20;
    }else{
        return 30;
    }
}

- (void)dengluchenggong {
    self.tabBarController.selectedIndex = 2;
}

//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    return 40;
}

//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section==0) {
        UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logomini"]];
        image1.frame = CGRectMake(10, 0, 80, 80);
        [cell addSubview:image1];
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 160, 80)];
        nameLabel.text= [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        _label = nameLabel;
        [cell.contentView addSubview:nameLabel];
    }else if (indexPath.section==1) {
        cell.textLabel.text=[self.arr objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text=@"退出登陆";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    return cell;
}



- (void)dismissdefangfa {
    self.tabBarController.selectedIndex = 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击cell  松开后颜色恢复点击前的颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1 && indexPath.row == 0) {
        [self setswitch];
    } else if (indexPath.section == 1 && indexPath.row == 1){
        //弹出框
        UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定清除缓存?" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self setDelete];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alerVC addAction:action1];
        [alerVC addAction:action2];
        [self presentViewController:alerVC animated:YES completion:nil];
    } else if (indexPath.section == 1 && indexPath.row == 2){
        AboutusViewController *aboutus = [AboutusViewController new];
        [self.navigationController pushViewController:aboutus animated:YES];
    }
    
    if (indexPath.section == 2) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userName"];
        STLVideoController *stlVideo = [STLVideoController new];
        stlVideo.delegate = self;
        UINavigationController *stlVideoNV = [[UINavigationController alloc]initWithRootViewController:stlVideo];
        [stlVideoNV.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
        [self presentViewController:stlVideoNV animated:NO completion:nil];
    }
    
    
}

//扫一扫
-(void)setswitch
{
    if ([self validateCamera]) {
        
        [self showQRViewController];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头或摄像头不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}


//清除缓存
-(void)setDelete
{
    [MBProgressHUD showMessage:@"清理中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[SDImageCache sharedImageCache] clearMemory];
        [MBProgressHUD showSuccess:[NSString stringWithFormat:@"成功清理图片缓存"]];
    });
}


#pragma mark-二维码三个方法
//方法一
-(void)validateCanmere
{
    if ([self validateCamera]) {
        
        [self showQRViewController];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头或摄像头不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
//方法二
- (BOOL)validateCamera{
    
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

//方法三
- (void)showQRViewController{
    
    QRCodeViewController *qrVC = [[QRCodeViewController alloc] init];
    [self.navigationController pushViewController:qrVC animated:YES];
    
}
















@end
