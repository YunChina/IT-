//
//  STLVideoController.h
//  IT圈
//
//  Created by 云志强 on 16/3/2.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "STLVideoViewController.h"

@protocol STLVideoControllerDelegate <NSObject>

- (void)dismissdefangfa;

- (void)dengluchenggong;

- (void)zhucechenggong;

@end

@interface STLVideoController : STLVideoViewController


@property (nonatomic, weak) id <STLVideoControllerDelegate> delegate;

@end
