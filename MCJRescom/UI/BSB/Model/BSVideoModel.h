//
//  BSVideoModel.h
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSVideoModel : NSObject
//标题
@property (nonatomic,copy) NSString* text;

//图片
@property (nonatomic,copy) NSString* image_small;

//视频
@property (nonatomic,copy) NSString* videouri;

@property(nonatomic,assign)NSInteger height;
@property(nonatomic,assign)NSInteger width;
-(void)setBSVideolInfoWithDic:(NSDictionary*)dic;
@end
