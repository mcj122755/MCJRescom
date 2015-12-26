//
//  MLoadingView.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MLoadingView.h"

@implementation MLoadingView
+(void)addInCenter:(UIViewController*)vc{
    CGFloat width = vc.view.frame.size.width;
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width*0.2, width*0.2)];
    bgIV.center = vc.view.center;
    [bgIV setImage:[UIImage sd_animatedGIFNamed:@"sun"]];
    [vc.view addSubview:bgIV];
}
@end
