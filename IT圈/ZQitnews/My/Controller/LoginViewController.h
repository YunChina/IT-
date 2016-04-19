//
//  LoginViewController.h
//  IT圈
//
//  Created by 云志强 on 16/3/2.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>

- (void)loginchenggong;

@end

@interface LoginViewController : UIViewController

@property (nonatomic, weak)id <LoginViewControllerDelegate> delegate;

@end
