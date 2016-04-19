//
//  EnrollViewController.h
//  IT圈
//
//  Created by 云志强 on 16/3/2.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EnrollViewControllerDelegate <NSObject>

- (void)zhucechenggong;

@end

@interface EnrollViewController : UIViewController

@property (nonatomic, weak) id <EnrollViewControllerDelegate> delegate;

@end
