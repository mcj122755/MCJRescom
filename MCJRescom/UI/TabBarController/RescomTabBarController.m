//
//  RescomTabBarController.m
//  MCJRescom
//
//  Created by MCJ on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RescomTabBarController.h"
#import "BSBViewController.h"
#import "HHVViewController.h"
#import "LFDViewController.h"
#import "XHVViewController.h"

@interface RescomTabBarController ()

@end

@implementation RescomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 创建视图
    [self creatViewControllers];
    
    // 引导页
    [self introduceWithView];
}


- (void)creatViewControllers
{
    // 实例化模块视图
    BSBViewController *bsbVC = [[BSBViewController alloc] init];
    HHVViewController *hhVC = [[HHVViewController alloc] init];
    LFDViewController *lfdVC = [[LFDViewController alloc] init];
    XHVViewController *xhvVC = [[XHVViewController alloc] init];
    
    // 给模块视图包装一层UINavgation
    UINavigationController *bsbNav = [[UINavigationController alloc] initWithRootViewController:bsbVC];
    UINavigationController *hhNav = [[UINavigationController alloc] initWithRootViewController:hhVC];
    UINavigationController *lfdNav = [[UINavigationController alloc] initWithRootViewController:lfdVC];
    UINavigationController *xhvNav = [[UINavigationController alloc] initWithRootViewController:xhvVC];
    
    // 把视图模块添加到UITabBar上
    self.viewControllers = @[bsbNav,hhNav,lfdNav,xhvNav];
    
    // 设置模块图片
    
}

- (void)introduceWithView
{
    
}
@end
