//
//  QRMenu.h
//  QRCode
//
//  Created by Mac_Mini on 15/9/15.
//  Copyright (c) 2015年 Chenxuhun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRItem.h"

typedef void(^QRMenuDidSelectedBlock)(QRItem *item);

@interface QRMenu : UIView

@property (nonatomic, copy) QRMenuDidSelectedBlock didSelectedBlock;

- (instancetype)initWithFrame:(CGRect)frame;
@end
