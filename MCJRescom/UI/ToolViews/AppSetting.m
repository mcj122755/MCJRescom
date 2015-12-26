//
//  AppSetting.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting
static CGSize _deviceSize;

+(void)setDeviceSize:(CGSize) size{
    _deviceSize = size;
}
+(CGSize)deviceSize{
    return _deviceSize;
};

static UIColor *_bgColor;
+(UIColor*)bgColor{
    if (!_bgColor) {
        _bgColor = [UIColor colorWithRed:0.98 green:0.98 blue:1 alpha:1];
    }
    return _bgColor;
}
+(UIColor*)menuColorWithAlpha:(float)alpha{
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
    float red = [u integerForKey:@"red"]/255.0;
    float green = [u integerForKey:@"green"]/255.0;
    float blue = [u integerForKey:@"blue"]/255.0;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}

+(UIColor*)menuColor{
    return [self menuColorWithAlpha:1];
}

@end
