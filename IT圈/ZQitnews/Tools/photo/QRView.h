//
//  QRView.h
//  QRCode
//
//  Created by Mac_Mini on 15/9/15.
//  Copyright (c) 2015年 Chenxuhun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRMenu.h"

@protocol QRViewDelegate <NSObject>

-(void)scanTypeConfig:(QRItem *)item;

@end
@interface QRView : UIView


@property (nonatomic, weak) id<QRViewDelegate> delegate;
/**
 *  透明的区域
 */
@property (nonatomic, assign) CGSize transparentArea;
@end
