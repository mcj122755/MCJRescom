//
//  BSVideoCellCollectionViewCell.h
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSVideoModel.h"

@interface BSVideoCellCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) BSVideoModel *model;
-(void)setCellDetailWithBSVideoModel:(BSVideoModel*)model itemWidth:(CGFloat)itemWidth ;
@end
