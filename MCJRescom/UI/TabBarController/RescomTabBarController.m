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
#import "IntroduceView.h"

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
    UITabBarItem *imItem = [[UITabBarItem alloc]initWithTitle:@"图片" image:[UIImage imageNamed:@"tab_btn1_nor.png"] selectedImage:[UIImage imageNamed:@"tab_btn1_sel.png"]];
    bsbNav.tabBarItem = imItem;
    UITabBarItem *bbsItem = [[UITabBarItem alloc]initWithTitle:@"笑话" image:[UIImage imageNamed:@"tab_btn2_nor.png"] selectedImage:[UIImage imageNamed:@"tab_btn2_sel.png"]];
    hhNav.tabBarItem = bbsItem;
    UITabBarItem *dcItem = [[UITabBarItem alloc]initWithTitle:@"视频" image:[UIImage imageNamed:@"tab_btn3_nor.png"] selectedImage:[UIImage imageNamed:@"tab_btn3_sel.png"]];
    lfdNav.tabBarItem = dcItem;
    UITabBarItem *mallItem = [[UITabBarItem alloc]initWithTitle:@"绘画" image:[UIImage imageNamed:@"tab_btn4_nor.png"] selectedImage:[UIImage imageNamed:@"tab_btn4_sel.png"]];
    xhvNav.tabBarItem = mallItem;
    
}

- (void)introduceWithView
{
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"firstLogin"] isEqualToString:@"YES"]) {
        IntroduceView *introView = [[IntroduceView alloc] init];
        [self.view addSubview:introView];
    }
}
@end
