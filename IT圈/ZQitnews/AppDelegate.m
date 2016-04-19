//
//  AppDelegate.m
//  ZQitnews
//
//  Created by 云志强 on 16/3/8.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "AppDelegate.h"
#import "BeginViewController.h"
#import "NewFeatureViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    BeginViewController *rootVC = [BeginViewController new];
    
    //    判断版本及启动图片
    // 获取当前版本号
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // 获取上一次版本号
    NSString * lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"banben"];
    // 版本号相同
    if ([currentVersion isEqualToString:lastVersion]) {
        // UITabBarController 控制器的 view 在一创建控制器的时候就会加载 view
        // UIViewController 的 view，才是懒加载
        self.window.rootViewController = rootVC;
    } else {
        // 版本号不同
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:@"banben"];
        NewFeatureViewController * newFeatVC = [[NewFeatureViewController alloc]init];
        self.window.rootViewController = newFeatVC;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
