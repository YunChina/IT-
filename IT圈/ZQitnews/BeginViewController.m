//
//  BeginViewController.m
//  IT圈
//
//  Created by 云志强 on 16/2/29.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "BeginViewController.h"
#import "NewsViewController.h"
#import "ReadViewController.h"
#import "MyViewController.h"
#import <SDCycleScrollView.h>

@interface BeginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *Time;

@end

@implementation BeginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    //向启动界面传递时间
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日 EEEE"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.Time.text = dateString;
    //2秒后pop到新闻界面
    double time = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        //***1.创建tabBarController
        UITabBarController *rootTBC = [[UITabBarController alloc]init];
        //新闻控制器
        NewsViewController *newsTVC = [[NewsViewController alloc]init];
        
        newsTVC.tabBarItem.title = @"新闻";
        //2.设置image
        newsTVC.tabBarItem.image = [UIImage imageNamed:@"news1.png"];
        //3.设置选中image
        newsTVC.tabBarItem.selectedImage = [UIImage imageNamed:@"news2.png"];
        
        //段子控制器
        ReadViewController *readTVC = [[ReadViewController alloc]init];
        UINavigationController *qingsongTNC = [[UINavigationController alloc]initWithRootViewController:readTVC];
        //设置属性
        readTVC.title = @"   ";
        readTVC.tabBarItem.title = @"轻松一刻";
        readTVC.tabBarItem.image = [UIImage imageNamed:@"qingsong1.png"];
        readTVC.tabBarItem.selectedImage = [UIImage imageNamed:@"qingsong2.png"];
        
        [qingsongTNC.navigationBar setBackgroundImage:[UIImage imageNamed:@"red_nav.png"] forBarMetrics:UIBarMetricsDefault];
        
        //个人控制器
        MyViewController *myTVC = [[MyViewController alloc]init];
        UINavigationController *myTNC = [[UINavigationController alloc]initWithRootViewController:myTVC];
        myTVC.tabBarItem.title = @"个人中心";
        myTVC.tabBarItem.image = [UIImage imageNamed:@"my1.png"];
        myTVC.tabBarItem.selectedImage = [UIImage imageNamed:@"my2.png"];
        
        [myTNC.navigationBar setBackgroundImage:[UIImage imageNamed:@"red_nav2.png"] forBarMetrics:UIBarMetricsDefault];
        
        rootTBC.viewControllers = @[newsTVC,qingsongTNC,myTNC];
        //tabBar选中颜色
        rootTBC.tabBar.tintColor = [UIColor redColor];
        //样式
        rootTBC.tabBar.barStyle = UIBarStyleDefault;
        //bartint颜色
        rootTBC.tabBar.barTintColor = [UIColor whiteColor];
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = rootTBC;
        
        [self presentViewController:rootTBC animated:NO completion:nil];
    });
    
}
//状态栏白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}
@end
