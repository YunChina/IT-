//
//  CustomViewController.h
//  QRCode
//
//  Created by Mac_Mini on 15/9/15.
//  Copyright (c) 2015年 Chenxuhun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QRUrlBlock)(NSString *url);
@interface QRCodeViewController : UIViewController

@property (nonatomic, copy) QRUrlBlock qrUrlBlock;

@end
