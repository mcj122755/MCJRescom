//
//  NetRequest.h
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequest : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property (nonatomic, copy) void (^finishBlock)(BOOL ,NSData* ,NSError *);

-(void)getPictureWithFinishBlock:(void(^)(BOOL ,NSData* ,NSError *))finishBlock;
-(void)getJokeWithFinishBlock:(void(^)(BOOL ,NSData* ,NSError *))finishBlock;
-(void)getBSBDJWithFinishBlock:(void(^)(BOOL,NSData *,NSError *)) finishBlock;
@end
