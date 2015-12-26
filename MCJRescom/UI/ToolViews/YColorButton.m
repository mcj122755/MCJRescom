//
//  YColorButton.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YColorButton.h"

@interface YColorButton ()
{
    NSUInteger _angle;
    BOOL _isAngle;
}
@end

@implementation YColorButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"color4.png"] forState:UIControlStateNormal] ;
        [self addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
        _angle = 0;
        _isAngle = YES;
    }
    return self;
}

/**
 *  改变主题颜色
 */
-(void)changeColor{
    
    
    CGPoint point = self.center;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI);//旋转180度
        self.frame =CGRectMake(0,0, 108, 108);
        self.center = point;
        self.alpha = 0.1;
        
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeRotation(2*M_PI);//旋转180度
            self.frame =CGRectMake(0,0, 27, 27);
            self.center = point;
            self.alpha = 1;
            
        }];
    }];
    [self reloadColor];
    
}

//发送广播通知全体UI换色
-(void)reloadColor{
    
    int red = arc4random() % 200;
    int green  = arc4random() % 200;
    int blue = arc4random() % 200;
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
    [u setInteger:red forKey:@"red"];
    [u setInteger:green forKey:@"green"];
    [u setInteger:blue forKey:@"blue"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YCHANGECOLOR" object:nil];
}



-(void) startAnimation{
    _isAngle = YES;
    [self continueAnimation];
}

-(void)continueAnimation{
    
    if ((!_isAngle)&&(_angle%360==0)) {
        return ;
    }
    [UIView animateWithDuration:0.1 animations:^{
        _angle+=40;
        self.transform = CGAffineTransformMakeRotation(_angle * (M_PI / 180.0f));
        
    } completion:^(BOOL finished) {
        [self continueAnimation];
    }];
}

-(void)endAnimation{
    _isAngle = NO;
}

@end
