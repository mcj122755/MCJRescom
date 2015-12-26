//
//  SJAvatarBrowser.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SJAvatarBrowser.h"
#import "MAlertView.h"
#import "ALAssetsLibrary+W.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "AppSetting.h"

static CGRect oldframe2;
static BOOL isHiden;

static CGFloat _width;
static CGFloat _height;

@implementation SJAvatarBrowser
+(void)showImage:(UIImageView *)avatarImageView2 pictureModel:(LFDPictureModel*)model{
    
    isOK = NO;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    _width =window .frame.size.width;
    _height = window.frame.size.height;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,_width, _height)];
    
    
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,_width, _height)];
    backgroundView .tag = 998;
    
    oldframe2=[avatarImageView2 convertRect:avatarImageView2.bounds toView:window];
    
    backgroundView.backgroundColor=[UIColor blackColor];
    
    backgroundView.alpha=0;
    //大图缩放比例
    float bl = _width/[model.width floatValue];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe2];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _height, _width, 50)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [AppSetting menuColorWithAlpha:0.8];
    titleLabel.text = model.title;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumburl] placeholderImage:avatarImageView2.image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        
        if (!isOK) {
            [UIView animateWithDuration:0.3 animations:^{
                
                
                imageView.frame =CGRectMake(0, 0, _width, [model.height floatValue]*bl);
                if (imageView.frame.size.height<=window.frame.size.height) {
                    imageView.center = window.center;
                }
            }];
        }else{
            imageView.frame =CGRectMake(0, 0, _width, [model.height floatValue]*bl);
            if (imageView.frame.size.height<=window.frame.size.height) {
                imageView.center = window.center;
            }
        }
        isOK = YES;
        
        
        
    }];
    
    sv.tag = 9997;
    imageView.tag=997;
    [window addSubview:backgroundView];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [sv addSubview:imageView];
    titleLabel.numberOfLines = 0;
    [window addSubview:sv];
    titleLabel.tag = 976;
    [window addSubview:titleLabel];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHiden:)];
    [tap setNumberOfTouchesRequired:1];
    [sv addGestureRecognizer:tap];
    
    
    //左上角返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backBtn.tag = 996;
    backBtn.alpha = 0;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [window addSubview:backBtn];
    [backBtn addTarget:self action:@selector(hideImage) forControlEvents:UIControlEventTouchUpInside];
    imageView.userInteractionEnabled = YES;
    //右上角保存按钮
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    saveBtn.tag = 1996;
    saveBtn.alpha = 0;
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [window addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(savePicture) forControlEvents:UIControlEventTouchUpInside];
    
    sv.contentSize = CGSizeMake( _width, [model.height floatValue]*bl);
    
    [self showMenu];
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha=1;
    }];
    
    //如果已经加载完大图，那么不再显示适配小图动画
    if (!isOK) {
        //缩略图放大比例
        float sltBL = _width/oldframe2.size.width;
        [UIView animateWithDuration:0.3 animations:^{
            isOK = YES;
            
            
            imageView.frame=CGRectMake(0,0, _width, oldframe2.size.height* sltBL);
            if (imageView.frame.size.height<=window.frame.size.height) {
                imageView.center = window.center;
            }
        }];
    }
    
    
    
}
static BOOL isOK;
+(void)changeHiden:(UITapGestureRecognizer *)tap{
    NSLog(@"changeHiden");
    isHiden = !isHiden;
    if (isHiden) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        [self hidenMenu];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        [self showMenu];
    }
}

+(void)showMenu{
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    UIButton *backBtn = (UIButton*)[window viewWithTag:996];
    UIButton *saveBtn = (UIButton*)[window viewWithTag:1996];
    UIView *title = [window viewWithTag:976];
    backBtn.alpha = 0.5;
    saveBtn.alpha = 0.5;
    saveBtn.frame = CGRectMake(_width, _height*0.8, _width*0.45,_width*0.45);
    isHiden = NO;
    [UIView
     animateWithDuration:0.3  animations:^{
         title.frame = CGRectMake(0, _height-40, _width, 40);
         backBtn.frame = CGRectMake(_width*0.045, _width*0.065, _width*0.099, _width*0.099);
         
         saveBtn.frame = CGRectMake(_width*0.854, _height*0.88, _width*0.099, _width*0.099);
         
     }];
}

+(void)hidenMenu{
    isHiden = YES;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIButton *backBtn = (UIButton*)[window viewWithTag:996];
    UIView *title = [window viewWithTag:976];
    UIButton *saveBtn = (UIButton*)[window viewWithTag:1996];
    [UIView
     animateWithDuration:0.3  animations:^{
         backBtn.frame = CGRectMake(-100, -100, _width*0.45,_width*0.45);
         backBtn.alpha = 0;
         title.frame =CGRectMake(0,_height, _width, 40);
         saveBtn.frame = CGRectMake(_width, _height*0.8, _width*0.45,_width*0.45);
         saveBtn.alpha = 0;
         
     }
     ];
    
}

+(void)savePicture{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIImageView *imageView=(UIImageView*)[window viewWithTag:997];
    [[ALAssetsLibrary new] saveImage:imageView.image toAlbum:@"快快乐图" withCompletionBlock:^(NSError *error) {
        [MAlertView showMessage:[NSString stringWithFormat:@"保存到相册%@",!error?@"成功":@"失败"]];
        
    }];
}

+(void)hideImage{
    [self hidenMenu];
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIButton *backBtn = (UIButton*)[window viewWithTag:996];
    UIView *title = [window viewWithTag:976];
    UIView *saveBtn = [window viewWithTag:1996];
    UIImageView *imageView=(UIImageView*)[window viewWithTag:997];
    UIView *backgroundView =(UIImageView*)[window viewWithTag:998];
    UIScrollView *sv = (UIScrollView*)[window viewWithTag:9997];
    [sv setContentOffset:CGPointMake(0, 0) animated:YES];
    [UIView
     animateWithDuration:0.5  animations:^{
         imageView.frame=oldframe2;
         backgroundView.alpha=0;
         
     } completion:^(BOOL finished) {
         
         [backBtn removeFromSuperview];
         [title removeFromSuperview];
         [imageView removeFromSuperview];
         imageView.image  = nil;
         [backgroundView removeFromSuperview];
         [sv removeFromSuperview];
         [saveBtn removeFromSuperview];
         
     }];
    
}

@end
