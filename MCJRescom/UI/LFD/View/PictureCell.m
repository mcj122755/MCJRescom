//
//  PictureCell.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PictureCell.h"
#import "AppSetting.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface PictureCell ()
{
    UIImageView *_borderView;
    UILabel * _holderLabel;
    UIView *_labelBG;
}
@end


@implementation PictureCell
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChange) name:@"YCHANGECOLOR" object:nil];
        
        [self addSubview:_holderLabel];
        [self addSubview:_imgView];
        [self addSubview:_labelBG];
        [self addSubview:_titleLab];
        [self addSubview:_borderView];
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

LFDPictureModel *_info;
//显示信息
-(void)setCellDetailWithJokeInfo:(LFDPictureModel *)info itemWidth:(CGFloat)itemWidth{
    _model = info;
    itemWidth -=6;
    _holderLabel.font = [UIFont systemFontOfSize:itemWidth*0.06];
    _info = info;
    //压缩比例
    float bl = itemWidth/[info.width floatValue];
    NSInteger imgHeight = [info.height integerValue]*bl;
    
    //宽高比例
    if (itemWidth/imgHeight<0.575) {
        imgHeight = itemWidth/0.575;
    }
    
    _imgView . frame = CGRectMake(0, 0, itemWidth, imgHeight);
    _holderLabel.frame = _imgView.frame;
    
    _titleLab.font= [UIFont systemFontOfSize:itemWidth*0.06];
    
    _labelBG. frame = CGRectMake(1, imgHeight-itemWidth*0.18, itemWidth-2, itemWidth*0.18);
    _titleLab. frame = CGRectMake(4, imgHeight-itemWidth*0.18, itemWidth-4, itemWidth*0.18);
    
    _borderView.frame = _imgView.frame;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:info.sourceurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
    }];

    self.titleLab.text=info.title;
}

@end
