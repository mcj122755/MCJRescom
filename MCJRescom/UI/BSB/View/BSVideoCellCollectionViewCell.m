//
//  BSVideoCellCollectionViewCell.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BSVideoCellCollectionViewCell.h"
#import "AppSetting.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface BSVideoCellCollectionViewCell ()
{
    UIImageView *_borderView;
    UILabel * _holderLabel;
    UIView *_labelBG;
    UIImageView *_playImageView;
}
@end

@implementation BSVideoCellCollectionViewCell
- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}


static UITapGestureRecognizer *_tap;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _borderView = [UIImageView new];
        _borderView.layer.borderColor = [AppSetting bgColor].CGColor;
        _borderView.layer.borderWidth = 1;
        _borderView.layer.masksToBounds = YES;
        _holderLabel = [[UILabel alloc] initWithFrame:_imgView.frame];
        _holderLabel.text = @"加载中……";
        _holderLabel.numberOfLines = 0;
        _holderLabel.textColor = [UIColor whiteColor];
        _holderLabel.alpha = 0.2;
        _holderLabel.textAlignment = NSTextAlignmentCenter;
        _holderLabel.backgroundColor = [AppSetting menuColor];
        
        _imgView=[UIImageView new];
        self.backgroundColor = [AppSetting bgColor];
        _titleLab=[UILabel new];
        _labelBG = [UIView new];
        _titleLab.font = [UIFont systemFontOfSize:15];
        _titleLab.textColor = [UIColor whiteColor];
        _labelBG.backgroundColor = [AppSetting menuColor];
        _labelBG.alpha = 0.6;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.numberOfLines = 0;
    
        //播放按钮
        _playImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play"]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChange) name:@"YCHANGECOLOR" object:nil];
        [self addSubview:_holderLabel];
        [self addSubview:_imgView];
        [self addSubview:_labelBG];
        [self addSubview:_titleLab];
        [self addSubview:_borderView];
        [self addSubview:_playImageView];
    }
    return self;
}

-(void)onChange{
    [UIView animateWithDuration:1 animations:^{
        if (_holderLabel&&_labelBG) {
            _holderLabel.backgroundColor=[AppSetting menuColor];
            _labelBG.backgroundColor = [AppSetting menuColor];
        }
    }];
    
}


//显示信息
-(void)setCellDetailWithBSVideoModel:(BSVideoModel *)model itemWidth:(CGFloat)itemWidth{
    _model = model;
    itemWidth -=6;
    _holderLabel.font = [UIFont systemFontOfSize:itemWidth*0.06];
    _model = model;
    //压缩比例
    float bl = itemWidth/(float)_model.width;
    NSInteger imgHeight = (float)_model.height *bl;
    
    //宽高比例
    if (itemWidth/imgHeight<0.575) {
        imgHeight = itemWidth/0.575;
    }
    
    _imgView . frame = CGRectMake(0, 0, itemWidth, imgHeight);
    _holderLabel.frame = _imgView.frame;
    
    _titleLab.font= [UIFont systemFontOfSize:itemWidth*0.06];
    
    _labelBG. frame = CGRectMake(1, imgHeight, itemWidth-2, itemWidth*0.18);
    _titleLab. frame = CGRectMake(4, imgHeight, itemWidth-4, itemWidth*0.18);
    
    _borderView.frame = _imgView.frame;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.image_small] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
    }];
    
    _playImageView .frame = CGRectMake(0, 0, itemWidth*0.3, itemWidth*0.3);
    _playImageView.center =_imgView.center;
    
    self.titleLab.text=model.text;
}

@end
