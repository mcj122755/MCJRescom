//
//  NetRequest.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NetRequest.h"

@interface NetRequest ()
{
    NSMutableData *mutData;
}
@end

@implementation NetRequest
//请求乐图信息
-(void)getPictureWithFinishBlock:(void (^)(BOOL, NSData *, NSError *))finishBlock{
    
    _finishBlock = finishBlock;
    NSURL *url = [NSURL URLWithString:@"http://api.laifudao.com/open/tupian.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    //下面设置post请求参数
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    mutData=[NSMutableData new];
    [connection start];
}

//请求笑话信息
-(void)getJokeWithFinishBlock:(void (^)(BOOL, NSData *, NSError *))finishBlock{
    _finishBlock = finishBlock;
    NSURL *url = [NSURL URLWithString:@"http://api.laifudao.com/open/xiaohua.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //下面设置post请求参数
    
    //post请求参数设置完毕，开始请求
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    mutData=[NSMutableData new];
    [connection start];
}

//请求百思不得姐信息
-(void)getBSBDJWithFinishBlock:(void (^)(BOOL, NSData *, NSError *))finishBlock{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.budejie.com/api/api_open.php?a=list&appname=baisibudejie&asid=21C3F594-AE4B-4500-A4DD-CA0BC640ED01&c=video&client=iphone&device=iPhone%204S&from=ios&jbk=0&mac=02%3A00%3A00%3A00%3A00%3A00&market=&openudid=fc6b78904ed9c2cdfee6b087765917d3f65505d2&page=0&per=20&type=41&udid=&ver=3.0"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        finishBlock(!error,data,error);
    }];
    [postDataTask resume];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    _finishBlock(NO,nil,error);
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [mutData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    _finishBlock(YES,mutData,nil);
}
@end
