//
//  ReadViewCell.m
//  IT圈
//
//  Created by 云志强 on 16/3/2.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "ReadViewCell.h"

@implementation ReadViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ReadModel *)model{
    self.mostlylabel.text = model.digest;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allViews];
    }
    return self;
}

-(void)allViews{
    self.mostlylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height-20)];
    //断行
    self.mostlylabel.numberOfLines = 0;
    //字号
    self.mostlylabel.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:self.mostlylabel];
    
}
////实现label自适应高度的方法
+(CGFloat)heithForLabelText:(NSString *)text{
    CGSize size = CGSizeMake(300, 1000);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}

@end
