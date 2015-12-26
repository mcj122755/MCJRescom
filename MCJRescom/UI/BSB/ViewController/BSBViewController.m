//
//  BSBViewController.m
//  MCJRescom
//
//  Created by MCJ on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#define CELL_IDENTIFIER @"CELL_IDENTIFIER"

#import "BSBViewController.h"
#import "MCollectionViewLayout.h"
#import "YColorButton.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppSetting.h"
#import "MLoadingView.h"
#import "BSVideoCellCollectionViewCell.h"
#import "UIScrollView+MJRefresh.h"
#import "MAlertView.h"
#import "NetRequest.h"

@interface BSBViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MCollectionViewLayoutDelegete>
{
    CGFloat _width;
    CGFloat _height;
    UICollectionView *_collectionView;
    NSMutableArray *_videoList;
    YColorButton *_colorBtn;
    MPMoviePlayerViewController *_moviePlayerViewController;
}
@end

@implementation BSBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
     _videoList = [NSMutableArray array];
    // 创建视图
    [self initViews];
    //请求数据
    [self getBSVideoArr:NO];
    
}


- (void)play:(NSString*)urlStr {
    _moviePlayerViewController=nil;//保证每次点击都重新创建视频播放控制器视图，避免再次点击时由于不播放的问题
    _moviePlayerViewController=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlStr]];
    [self presentMoviePlayerViewControllerAnimated:_moviePlayerViewController];
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
    
    [_collectionView registerClass:[BSVideoCellCollectionViewCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [AppSetting menuColor];
    
    
    [self.view addSubview:_collectionView];
    
    _collectionView.backgroundColor = [AppSetting bgColor];
    // 添加上拉加载更多
    //    [_collectionView addFooterWithTarget:self action:@selector(loadMoreJokes)];
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
    if (columnCount<2||columnCount>3) {
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
    [self getBSVideoArr:YES];
}
-(void)reloadJokes{
    [self getBSVideoArr:NO];
}






-(void)getBSVideoArr:(BOOL)isAppend{
    
    [_colorBtn startAnimation];
    [[NetRequest new] getBSBDJWithFinishBlock:^(BOOL isSeccess, NSData * data, NSError *error) {
        [_colorBtn endAnimation];
        [_collectionView footerEndRefreshing];
        [_collectionView headerEndRefreshing];
        if (isSeccess) {
            
            if (!isAppend) {
                _videoList = [NSMutableArray array];
                
            }
            NSArray *jokeArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil][@"list"];
            
            for (int i = 0; i<jokeArr.count; i++) {
                NSDictionary *dic = jokeArr[i];
                BSVideoModel *bsVideoModel = [BSVideoModel new];
                [bsVideoModel setBSVideolInfoWithDic:dic];
                [_videoList addObject:bsVideoModel];
                
            }
            [self performSelectorOnMainThread:@selector(onGetData) withObject:nil waitUntilDone:NO];
        }
        
    }];
}


-(void)onGetData{
    [_collectionView reloadData];
    _collectionView.frame = CGRectMake(0, 64, _width, _height-64-49);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(MCollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BSVideoModel * model = _videoList[indexPath.item];
    
    MCollectionViewLayout *layout =(MCollectionViewLayout*)collectionView.collectionViewLayout;
    NSInteger imgWidth =collectionView.frame.size.width/layout.columnCount;
    float bl = (imgWidth-5)/(float)model.width*1.0;
    float imgHeight = (float)model.height*bl;
    return imgHeight+imgWidth*0.18;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BSVideoCellCollectionViewCell *cell = (BSVideoCellCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    [self play:cell.model.videouri];
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _videoList.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BSVideoCellCollectionViewCell *cell = (BSVideoCellCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    MCollectionViewLayout *layout =(MCollectionViewLayout*)collectionView.collectionViewLayout;
    BSVideoModel *model = _videoList[indexPath.item];
    //    [cell setCellDetailWithJokeInfo:model itemWidth:(collectionView.frame.size.width/layout.columnCount)];
    [cell setCellDetailWithBSVideoModel:model itemWidth:(collectionView.frame.size.width/layout.columnCount)];
    
    return cell;
}

@end
