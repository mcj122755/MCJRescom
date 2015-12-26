//
//  JokeModel.h
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JokeModel : NSObject
@property NSString *title;
@property NSString *content;
-(instancetype)initWithTitle:(NSString*)title content:(NSString*)content;
@end
