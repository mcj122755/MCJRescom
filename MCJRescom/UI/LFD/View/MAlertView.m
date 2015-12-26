//
//  MAlertView.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MAlertView.h"
#import "AppSetting.h"

@implementation MAlertView
static UIActivityIndicatorView *_actView;
+(void)showLoading{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (!_actView) {
        _actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _actView.hidesWhenStopped = YES;
        _actView.center = window.center;
        [window addSubview:_actView];
    }
    [_actView startAnimating];
    
}

//文本提示
+(void)showMessage:(NSString *)message{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [[window viewWithTag:9998] removeFromSuperview];
    
    UILabel *label = [[UILabel alloc]init];
    CGFloat width = window.frame.size.width;
    label.numberOfLines = 0;
    [window addSubview:label];
    label.tag = 9998;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:width*0.05];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(1, 1, width*0.45, width*0.27);
    label.center = window.center;
    label.text = message;
    label.layer.cornerRadius =width*0.01;
    label.layer.masksToBounds = YES;
    
    label.backgroundColor = [AppSetting menuColorWithAlpha:0.9];
    
    [UIView animateWithDuration:0.3 animations:^{
        label.alpha = 1;
        label.frame = CGRectMake(1, 1, width*0.5, width*0.3);
        label.center = window.center;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.7 animations:^{
            label.alpha = 0.99;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2 animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
    }];
    
    //
}


@end
