//
//  LFDViewController.m
//  MCJRescom
//
//  Created by MCJ on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LFDViewController.h"

@interface LFDViewController ()
{
    NSMutableArray *_pictureListArrayM;
}
@end

@implementation LFDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.title = @"很严肃的图片";
    // 实例化数据源
    _pictureListArrayM = [NSMutableArray array];
    
    // 添加视图
    [self buildView];
    
    // 获取数据
    [self requestData];
    
}

#pragma mark - 添加视图
- (void)buildView
{
    
}
#pragma mark - 获取数据
- (void)requestData
{
    
}
@end
