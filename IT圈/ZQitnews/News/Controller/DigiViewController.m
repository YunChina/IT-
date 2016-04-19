//
//  DigiViewController.m
//  IT圈
//
//  Created by 云志强 on 16/3/1.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "DigiViewController.h"
#import "NewsModel.h"
#import "NewsRequestData.h"
#import "NewsViewCell.h"
#import <AFNetworking.h>
#import <SDCycleScrollView.h>
#import <MJRefresh.h>
#import "DataBase.h"
#import "WebViewController.h"
@interface DigiViewController ()
@property (nonatomic, strong) NSMutableArray * array;
@property (nonatomic,strong)SDCycleScrollView *shufflingFigure;
@property (nonatomic,strong) NSMutableArray *refreshImages;//刷新动画的图片数组
@end

@implementation DigiViewController

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[NewsViewCell class] forCellReuseIdentifier:@"cell"];
    //网络检测
    [self reachability];
    [self MJRefreshGifHeader];
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
                 [NewsRequestData getDataWithUrlStr:kDigi success:^(NSArray *array) {
                     [self.array addObjectsFromArray:array];
                     [self.tableView reloadData];
                 }];
                 [self shufflingFigureAction];
             }
                 // 回调处理
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:{
                 [NewsRequestData getDataWithUrlStr:kDigi success:^(NSArray *array) {
                     [self.array addObjectsFromArray:array];
                     [self.tableView reloadData];
                 }];
                 [self shufflingFigureAction];
             }
                 // 回调处理
                 break;
             default:
                 break;
         }
     }];
}
-(void)shufflingFigureAction{
    [NewsRequestData getPicDataWithUrlStr:kDigipic success:^(NSArray *picArr, NSArray *titleArr) {
        self.shufflingFigure = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW, kScreenW/2) imageURLStringsGroup:picArr];
        self.shufflingFigure.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        self.shufflingFigure.titlesGroup = titleArr;
        self.shufflingFigure.autoScrollTimeInterval = 3;
        if (picArr.count == 1) {
            self.shufflingFigure.autoScroll = NO;
        }
        if (picArr.count == 0) {
            return;
        }
        self.tableView.tableHeaderView = self.shufflingFigure;
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
-(void)loadNewData {
    double time = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    
    [NewsRequestData getDataWithUrlStr:kDigi success:^(NSArray *array) {
        [self.array addObjectsFromArray:array];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
    [self shufflingFigureAction];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel * model = self.array[indexPath.row];
    NewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击cell  松开后颜色恢复点击前的颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsModel * model = self.array[indexPath.row];
    WebViewController *webview = [WebViewController new];
    webview.model = model;
    UINavigationController * naVC = [[UINavigationController alloc]initWithRootViewController:webview];
    naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naVC animated:YES completion:nil];
    
}



@end
