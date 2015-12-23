//
//  XHVLineView.m
//  MCJRescom
//
//  Created by MCJ on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XHVLineView.h"

@implementation XHVLineView

- (void)drawRect:(CGRect)rect
{
    // 1. 设置颜色
    [[UIColor redColor] set];
    // 2. 绘制矩形
    UIRectFill(rect);
}

@end
