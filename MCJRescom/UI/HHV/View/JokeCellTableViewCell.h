//
//  JokeCellTableViewCell.h
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JokeModel.h"

@interface JokeCellTableViewCell : UITableViewCell
-(void)setInfo:(JokeModel*)model isMenuColor:(BOOL)isMenuColor;
@end
