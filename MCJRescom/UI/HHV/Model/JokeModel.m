//
//  JokeModel.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JokeModel.h"

@implementation JokeModel
-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content{
    if (self = [super init]) {
        _title = title;
        _content = content;
    }
    return self;
}
@end
