//
//  QRItem.h
//  QRCode
//
//  Created by Mac_Mini on 15/9/15.
//  Copyright (c) 2015年 Chenxuhun. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, QRItemType) {
    QRItemTypeQRCode = 0,
    QRItemTypeOther,
};


@interface QRItem : UIButton

@property (nonatomic, assign) QRItemType type;

- (instancetype)initWithFrame:(CGRect)frame
                       titile:(NSString *)titile;
@end
