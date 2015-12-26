//
//  LFDPictureModel.h
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFDPictureModel : NSObject
@property(nonatomic,copy)NSString* height;

//小图
@property NSString * sourceurl;

@property(nonatomic,copy)NSString *thumburl;

@property(nonatomic,copy)NSString* width;

@property(nonatomic,copy)NSString *title;

-(void)setJokeModelInfoWithDic:(NSDictionary*)dic;
@end
