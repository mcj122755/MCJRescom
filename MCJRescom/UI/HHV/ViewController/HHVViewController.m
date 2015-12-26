//
//  HHVViewController.m
//  MCJRescom
//
//  Created by MCJ on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HHVViewController.h"
#import "YColorButton.h"
#import "AppSetting.h"
#import "MLoadingView.h"
#import "UIScrollView+MJRefresh.h"
#import "NetRequest.h"
#import "JokeModel.h"
#import "JokeCellTableViewCell.h"

@interface HHVViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _width;
    CGFloat _height;
    NSMutableArray *_jokeArr;
    UITableView *_jokeTV;
    YColorButton *_colorBtn;
}
@end

@implementation HHVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    [self getJokeArr:NO];
}

-(void)initViews{
    _width = self.view.frame.size.width;
    _height = self.view.frame.size.height;
    
    self.view.backgroundColor = [AppSetting bgColor];
    self.title = @"笑话";
    [MLoadingView addInCenter:self];
    
    //右面的换色按钮
    _colorBtn = [[YColorButton alloc]initWithFrame: CGRectMake(_width-50, 10, 27, 27)];
    [self.navigationController.navigationBar addSubview:_colorBtn];
    
    
    _jokeTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _jokeTV.backgroundColor = [AppSetting bgColor];
    
    // 添加上拉加载更多
    [_jokeTV addFooterWithTarget:self action:@selector(loadMoreJokes)];
    // 下拉刷新
    [_jokeTV addHeaderWithTarget:self action:@selector(reloadJokes)];
    _jokeTV.delegate = self;
    _jokeTV.dataSource = self;
    [self.view addSubview:_jokeTV];
}

-(void)loadMoreJokes{
    [self getJokeArr:YES];
}
-(void)reloadJokes{
    [self getJokeArr:NO];
}

/**
 *  请求新的笑话数据
 *
 *  @return isAppend 是否追加在现有的笑话列表后
 */

-(void)getJokeArr:(BOOL)isAppend{
    if (!_jokeArr) {
        _jokeArr = [NSMutableArray array];
    }
    [_colorBtn startAnimation];
    [[NetRequest new] getJokeWithFinishBlock:^(BOOL isSeccess,NSData *data ,NSError *error){
        [_colorBtn endAnimation];
        if (isSeccess) {
            NSArray *jokeDicArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (!isAppend) {
                [_jokeArr removeAllObjects];
            }
            for (NSDictionary* jokeDic in jokeDicArr) {
                JokeModel *model = [[JokeModel alloc] initWithTitle:jokeDic[@"title"] content:jokeDic[@"content"]];
                [_jokeArr addObject:model];
            }
            
            _jokeTV.frame = CGRectMake(0, 64, _width, _height-64-49);
            
            [_jokeTV reloadData];
            
        }
        [_jokeTV footerEndRefreshing];
        [_jokeTV headerEndRefreshing];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JokeModel *model = _jokeArr[indexPath.row];
    NSString *str = [model.content stringByReplacingOccurrencesOfString:@"<br/><br/>" withString:@"\n"];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16.5] constrainedToSize:CGSizeMake(_width, 10000) lineBreakMode:NSLineBreakByCharWrapping];
    
    
    return size.height+75;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"cellName";
    JokeCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[JokeCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    JokeModel *model = _jokeArr[indexPath.row];
    [cell setInfo:model isMenuColor:(indexPath.row%2)];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _jokeArr.count;
}

@end
