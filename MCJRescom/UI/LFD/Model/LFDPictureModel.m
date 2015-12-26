//
//  LFDPictureModel.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LFDPictureModel.h"

@implementation LFDPictureModel
-(void)setJokeModelInfoWithDic:(NSDictionary *)dic{
    self.height=[dic objectForKey:@"height"];
    self.width=[dic objectForKey:@"width"];
    self.thumburl=[dic objectForKey:@"thumburl"];
    self.title=dic [@"title"];
    self.sourceurl = dic[@"sourceurl"];
}
@end
