//
//  ReadViewController.m
//  IT圈
//
//  Created by 云志强 on 16/2/29.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "ReadViewController.h"
#import <MJRefresh.h>
#import "ReadRequestData.h"
#import "ReadViewCell.h"
#import "DataBase.h"
#import <AFNetworking.h>
@interface ReadViewController ()
@property (nonatomic,strong) NSMutableArray *refreshImages;//刷新动画的图片数组
@property (nonatomic, strong) NSMutableArray * array;
@end

@implementation ReadViewController

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ReadViewCell class] forCellReuseIdentifier:@"cell"];
    //隐藏tableview横线
    self.tableView.separatorStyle = NO;
    //网络状态
    [self reachability];
    //下拉刷新
    [self MJRefreshGifHeader];
    //上拉加载
    [self MJRefreshFooter];

}
- (void)reachability{
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理
    /* AFNetworking的Block内使用self须改为weakSelf, 避免循环强引用, 无法释放 */
    //    __weak typeof(self) weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         switch (status)
         {
             case AFNetworkReachabilityStatusUnknown:{
                 NSArray * array = [DataBase getDataWithDatabase:self.title];
                 [self.array addObjectsFromArray:array];
             }
                 // 回调处理
                 break;
             case AFNetworkReachabilityStatusNotReachable:{
                 NSArray * array = [DataBase getDataWithDatabase:self.title];
                 [self.array addObjectsFromArray:array];
             }
                 // 回调处理
                 break;
             case AFNetworkReachabilityStatusReachableViaWWAN:{
                 [[ReadRequestData shareRuqustData]getDataWithUrl:k20Url block:^(NSArray *array) {
                     [self.array insertObjects:array atIndexes:[[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(0, array.count)]];
                     [self.array addObjectsFromArray:array];
                     [self.tableView reloadData];
                 }];
            }
                 // 回调处理
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:{
                 [[ReadRequestData shareRuqustData]getDataWithUrl:k20Url block:^(NSArray *array) {
                     [self.array insertObjects:array atIndexes:[[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(0, array.count)]];
                     [self.array addObjectsFromArray:array];
                     [self.tableView reloadData];
                 }];
             }
                 // 回调处理
                 break;
             default:
                 break;
         }
     }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [DataBase insertObject:self.array title:self.title];
}
//下拉刷新
-(void)MJRefreshGifHeader{
    MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setImages:self.refreshImages forState:MJRefreshStateRefreshing];
    [header setImages:self.refreshImages forState:MJRefreshStatePulling];
    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
}

//上拉加载
-(void)MJRefreshFooter{
    MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;

}


-(void)loadNewData {
    [[ReadRequestData shareRuqustData]getDataWithUrl:k10Url block:^(NSArray *array) {
        double time = 3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
        });
        
        [self.array insertObjects:array atIndexes:[[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(0, array.count)]];
        if (self.array.count > 50) {
            [self.array removeObjectsAtIndexes:[[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(40, 10)]];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
}
-(void)loadMoreData{
    [[ReadRequestData shareRuqustData]getDataWithUrl:k10Url block:^(NSArray *array) {
        double time = 3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
        });
        
        [self.array addObjectsFromArray:array];
        if (self.array.count > 50) {
            [self.array removeObjectsAtIndexes:[[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(0, 10)]];
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];

}


//正在刷新状态下的图片
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [[NSMutableArray alloc] init];

        //                循环添加图片
        for (NSUInteger i = 1; i<=8; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"xiala-%ld", (unsigned long)i]];
            [self.refreshImages addObject:image];
        }
    }
    return _refreshImages;
}
//分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}



//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *text = [self.array[indexPath.row]digest];
    CGFloat h = [ReadViewCell heithForLabelText:text];
    return h+30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadModel * model = self.array[indexPath.row];
    ReadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = model;
    
    //通过返回的rect设置label的高度
    //1.获取cell.label.frame
    CGRect labelFrame = cell.mostlylabel.frame;
    //2.修改获取到的frame
    labelFrame.size.height = [ReadViewCell heithForLabelText:cell.mostlylabel.text];
    //3.在将修改之后的frame赋值给label
    cell.mostlylabel.frame = labelFrame;
    
    return cell;
}

@end
