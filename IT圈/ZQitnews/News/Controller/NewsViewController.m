//
//  NewsViewController.m
//  IT圈
//
//  Created by 云志强 on 16/2/29.
//  Copyright © 2016年 云志强. All rights reserved.
//

#import "NewsViewController.h"
#import "NewViewController.h"
#import "PhoneViewController.h"
#import "IOSViewController.h"
#import "DigiViewController.h"
#import "WpViewController.h"
#import "AndroidViewController.h"
#import "WindowsViewController.h"

static CGFloat const titleH = 64;
static CGFloat const navBarH = 0;
static CGFloat const maxTitleScale = 1.4;

@interface NewsViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
// 选中按钮
@property (nonatomic, weak) UIButton *selTitleButton;
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@interface NewsViewController ()

@end

@implementation NewsViewController

- (NSMutableArray *)buttons{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupTitleScrollView];
    [self setupContentScrollView];
    [self addChildViewController];
    [self setupTitle];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * kScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
}


//状态栏白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}

#pragma mark - 设置头部标题栏
- (void)setupTitleScrollView
{
    // 判断是否存在导航控制器来判断y值
    CGFloat y = self.navigationController ? navBarH : 0;
    CGRect rect = CGRectMake(0, y, kScreenW, titleH);
    
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    titleScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleScrollView];
    self.titleScrollView = titleScrollView;
}

#pragma mark - 设置内容
- (void)setupContentScrollView
{
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect = CGRectMake(0, y, kScreenW, kScreenH - titleH);
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self.view addSubview:contentScrollView];
    
    self.contentScrollView = contentScrollView;
}

#pragma mark - 添加子控制器
- (void)addChildViewController
{
    NewViewController *vc = [NewViewController new];
    vc.title = @"最新";
    [self addChildViewController:vc];
    
    PhoneViewController *vc1 = [PhoneViewController new];
    vc1.title = @"手机";
    [self addChildViewController:vc1];
    
    IOSViewController *vc2 = [IOSViewController new];
    vc2.title = @"苹果";
    [self addChildViewController:vc2];
    
    WindowsViewController *vc3 = [WindowsViewController new];
    vc3.title = @"Windows";
    [self addChildViewController:vc3];

    WpViewController *vc4 = [WpViewController new];
    vc4.title = @"WP";
    [self addChildViewController:vc4];
    
    AndroidViewController *vc5 = [AndroidViewController new];
    vc5.title = @"安卓";
    [self addChildViewController:vc5];
    
    DigiViewController *vc6 = [DigiViewController new];
    vc6.title = @"数码";
    [self addChildViewController:vc6];
    

}

#pragma mark - 设置标题
- (void)setupTitle
{
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat x = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width/5;
    CGFloat h = titleH;
    
    for (int i = 0; i < count; i++)
    {
        UIViewController *vc = self.childViewControllers[i];
        
        x = i * w;
        CGRect rect = CGRectMake(x, 10, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        
        btn.tag = i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [btn addTarget:self action:@selector(chick:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
        [self.titleScrollView addSubview:btn];
        if (i == 0){
            [self chick:btn];
        }
    }
    
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.backgroundColor = [UIColor redColor];
    
}

// 按钮点击
- (void)chick:(UIButton *)btn
{
    [self selTitleBtn:btn];
    
    NSUInteger i = btn.tag;
    CGFloat x = i * kScreenW;
    
    [self setUpOneChildViewController:i];
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
}
// 选中按钮
- (void)selTitleBtn:(UIButton *)btn
{
    [self.selTitleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selTitleButton.transform = CGAffineTransformIdentity;
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(maxTitleScale, maxTitleScale);

    self.selTitleButton = btn;
    [self setupTitleCenter:btn];
}

- (void)setUpOneChildViewController:(NSUInteger)i
{
    CGFloat x = i * kScreenW;
    
    UIViewController *vc = self.childViewControllers[i];
    
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, kScreenW, kScreenH - self.contentScrollView.frame.origin.y-64);
    
    [self.contentScrollView addSubview:vc.view];
    
}

- (void)setupTitleCenter:(UIButton *)btn
{
    CGFloat offset = btn.center.x - kScreenW * 0.5;
    
    if (offset < 0)
    {
        offset = 0;
    }
    
    CGFloat maxOffset = self.titleScrollView.contentSize.width - kScreenW;
    if (offset > maxOffset)
    {
        offset = maxOffset;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger i = self.contentScrollView.contentOffset.x / kScreenW;
    [self selTitleBtn:self.buttons[i]];
    [self setUpOneChildViewController:i];
}

// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger leftIndex = offsetX / kScreenW;
    NSInteger rightIndex = leftIndex + 1;
    
    
    UIButton *leftButton = self.buttons[leftIndex];
    
    UIButton *rightButton = nil;
    if (rightIndex < self.buttons.count) {
        rightButton = self.buttons[rightIndex];
    }
    
    CGFloat scaleR = offsetX / kScreenW - leftIndex;
    
    CGFloat scaleL = 1 - scaleR;
    
    
    CGFloat transScale = maxTitleScale - 1;
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    UIColor *rightColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
    
}


@end
