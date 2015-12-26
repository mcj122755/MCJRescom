//
//  PictureCell.h
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFDPictureModel.h"

@interface PictureCell : UICollectionViewCell
@property UILabel *titleLab;
@property UIImageView *imgView;
@property LFDPictureModel *model;

-(void)setCellDetailWithJokeInfo:(LFDPictureModel*)info itemWidth:(CGFloat)itemWidth ;
@end
