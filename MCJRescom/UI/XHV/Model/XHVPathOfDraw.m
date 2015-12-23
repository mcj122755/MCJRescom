//
//  XHVPathOfDraw.m
//  MCJRescom
//
//  Created by MCJ on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XHVPathOfDraw.h"

@implementation XHVPathOfDraw
+ (id)drawPathWith:(CGPathRef)cgPath
             color:(UIColor *)color
         lineWidth:(CGFloat)lineWidth
{
    XHVPathOfDraw *pathOfDraw = [[XHVPathOfDraw alloc] init];
    pathOfDraw.path = [UIBezierPath bezierPathWithCGPath:cgPath];
    pathOfDraw.color = color;
    pathOfDraw.lineWidth = lineWidth;
    return pathOfDraw;
}

@end
