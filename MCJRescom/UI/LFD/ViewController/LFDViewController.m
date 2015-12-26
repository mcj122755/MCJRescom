//
//  LFDViewController.m
//  MCJRescom
//
//  Created by MCJ on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#define CELL_IDENTIFIER @"WaterfallCell"
#import "LFDViewController.h"
#import "YColorButton.h"
#import "MCollectionViewLayout.h"
#import "AppSetting.h"
#import "MLoadingView.h"
#import "PictureCell.h"
#import "UIScrollView+MJRefresh.h"
#import "NetRequest.h"
#import "MAlertView.h"
#import "SJAvatarBrowser.h"

@interface LFDViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MCollectionViewLayoutDelegete>
{
    CGFloat _width;
    CGFloat _height;
    UICollectionView *_collectionView;
    NSMutableArray *_pictureList;
    YColorButton *_colorBtn;
}
@end

@implementation LFDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片";
    
    // 实例化数据源
    _pictureList = [NSMutableArray array];
    
    // 添加视图
    [self initViews];
    
    // 获取数据
    [self getPictureArr:NO];
}

/**
 *  初始化视图
 */
-(void)initViews{
    
    _width = self.view.frame.size.width;
    _height = self.view.frame.size.height;
    self.view.backgroundColor = [AppSetting bgColor];
    
    [MLoadingView addInCenter:self];
    //初始化瀑布流
    MCollectionViewLayout *myLayout = [[MCollectionViewLayout alloc] initWithColumnCount:2];
    
    myLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    myLayout.delegate = self;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:myLayout];
    
    [_collectionView registerClass:[PictureCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [AppSetting menuColor];
    
    
    [self.view addSubview:_collectionView];
    
    _collectionView.backgroundColor = [AppSetting bgColor];
    // 添加上拉加载更多
    [_collectionView addFooterWithTarget:self action:@selector(loadMoreJokes)];
    // 下拉刷新
    [_collectionView addHeaderWithTarget:self action:@selector(reloadJokes)];
    
    
    //右面的换色按钮
    _colorBtn = [[YColorButton alloc]initWithFrame: CGRectMake(_width-50, 10, 27, 27)];
    [self.navigationController.navigationBar addSubview:_colorBtn];
    
    [_collectionView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(onPinch:)]];
    
}

//手势
- (void)onPinch:(UIPinchGestureRecognizer*)gesture{
    CGFloat scale = gesture.scale;
    if (gesture.state == UIGestureRecognizerStateEnded){
        
        short columnCount =((MCollectionViewLayout*)(_collectionView.collectionViewLayout)).columnCount ;
        
        if (scale>1) {
            [self changeColumnCount:columnCount-1];
        }else if(scale<1){
            [self changeColumnCount:columnCount+1];
        }
        return;
    }
}

-(void)changeColumnCount:(short)columnCount{
    if (columnCount<2||columnCount>7) {
        [MAlertView showMessage:[NSString stringWithFormat:@"报告长官\n无法换%d列纵队!",columnCount]];
        return;
    }
    [MAlertView showMessage:[NSString stringWithFormat:@"向前看齐!\n变%d列纵队\n稍息，立正!",columnCount]];
    MCollectionViewLayout *myLayout = (MCollectionViewLayout *)_collectionView.collectionViewLayout;
    myLayout.columnCount = columnCount;
    myLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    myLayout.delegate = self;    [_collectionView reloadData];
    [_collectionView setCollectionViewLayout:myLayout];
    [_collectionView reloadData];
}

-(void)loadMoreJokes{
    [self getPictureArr:YES];
}
-(void)reloadJokes{
    [self getPictureArr:NO];
}

/**
 *  请求新的来福岛图片数据
 *
 *  @param isAppend 是否追加在现有的乐图列表后
 */
-(void)getPictureArr:(BOOL)isAppend{
    
    [_colorBtn startAnimation];
    [[NetRequest new] getPictureWithFinishBlock:^(BOOL isSeccess, NSData * data, NSError *error) {
        [_colorBtn endAnimation];
        [_collectionView footerEndRefreshing];
        [_collectionView headerEndRefreshing];
        if (isSeccess) {
            if (!isAppend) {
                _pictureList = [NSMutableArray array];
                
            }
            NSArray *jokeArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            for (int i = 0; i<jokeArr.count; i++) {
                NSDictionary *dic = jokeArr[i];
                LFDPictureModel *pictureModel = [LFDPictureModel new];
                [pictureModel setJokeModelInfoWithDic:dic];
                [_pictureList addObject:pictureModel];
            }
            [_collectionView reloadData];
            _collectionView.frame = CGRectMake(0, 64, _width, _height-64-49);
            
        }
        
    }];
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(MCollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LFDPictureModel * model = _pictureList[indexPath.item];
    
    MCollectionViewLayout *layout =(MCollectionViewLayout*)collectionView.collectionViewLayout;
    NSInteger imgWidth =collectionView.frame.size.width/layout.columnCount;
    float bl = (imgWidth-5)/[model.width floatValue];
    
    
    
    float imgHeight = [model.height integerValue]*bl;
    //宽高比例
    if (imgWidth/imgHeight<0.575) {
        imgHeight = imgWidth
        /0.575;
    }
    
    return imgHeight;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PictureCell *cell = (PictureCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    [SJAvatarBrowser showImage:cell.imgView pictureModel:(_pictureList[indexPath.row])];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _pictureList.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PictureCell *cell = (PictureCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    MCollectionViewLayout *layout =(MCollectionViewLayout*)collectionView.collectionViewLayout;
    LFDPictureModel *model = _pictureList[indexPath.item];
    [cell setCellDetailWithJokeInfo:model itemWidth:(collectionView.frame.size.width/layout.columnCount)];
    
    return cell;
}
@end
