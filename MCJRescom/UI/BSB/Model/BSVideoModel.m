//
//  BSVideoModel.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BSVideoModel.h"

@implementation BSVideoModel
-(void)setBSVideolInfoWithDic:(NSDictionary *)dic{
    
    self.height=[[dic objectForKey:@"height"] integerValue];
    self.width=[[dic objectForKey:@"width"] integerValue];
    self.image_small=[dic objectForKey:@"image_small"];
    self.videouri=dic [@"videouri"];
    self.text = dic[@"text"];
}
@end
