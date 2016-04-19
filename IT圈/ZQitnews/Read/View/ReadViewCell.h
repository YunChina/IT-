//
//  ReadViewCell.h
//  IT圈
//
//  Created by 云志强 on 16/3/2.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"
@interface ReadViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *mostlylabel;

@property(nonatomic,strong)ReadModel *model;

//label自适应的方法
+(CGFloat)heithForLabelText:(NSString *)text;
@end
