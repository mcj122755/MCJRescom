//
//  XHVPathOfDraw.h
//  MCJRescom
//
//  Created by MCJ on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XHVPathOfDraw : NSObject
// 通常在自定义模型类时，为了简化模型类的创建，通常需要编写一个工厂方法
// 命名规则，使用类名其实，需要什么参数依次添加即可
+ (id)drawPathWith:(CGPathRef)cgPath
             color:(UIColor *)color
         lineWidth:(CGFloat)lineWidth;

// 绘图的路径
@property (strong, nonatomic) UIBezierPath *path;
// 路径的颜色
@property (strong, nonatomic) UIColor *color;
// 路径的线宽
@property (assign, nonatomic) CGFloat lineWidth;
// 用户选择的照片
@property (strong, nonatomic) UIImage *image;
@end
