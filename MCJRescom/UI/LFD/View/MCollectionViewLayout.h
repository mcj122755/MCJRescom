//
//  MCollectionViewLayout.h
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCollectionViewLayout;
@protocol MCollectionViewLayoutDelegete <UICollectionViewDelegate>
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MCollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface MCollectionViewLayout : UICollectionViewLayout
@property (nonatomic,assign) NSUInteger columnCount;

@property (nonatomic,assign) UIEdgeInsets sectionInset;

@property (nonatomic,weak)__weak id<MCollectionViewLayoutDelegete> delegate;

@property (nonatomic,assign) NSInteger itemCount;
@property (nonatomic,assign) CGFloat interitemSpacing;
@property (nonatomic,strong) NSMutableArray *columnHeights; // height for each column
@property (nonatomic,strong) NSMutableArray *itemAttributes; // attributes for each item

/**
 *  跟随列数初始化
 *
 *  @param columnCount 列数
 */
-(instancetype)initWithColumnCount:(NSUInteger)columnCount;
@end
