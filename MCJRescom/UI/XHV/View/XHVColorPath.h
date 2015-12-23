//
//  XHVColorPath.h
//  MCJRescom
//
//  Created by MCJ on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorViewDelegate <NSObject>

- (void)colorViewSelectedColor:(UIColor *)color;

@end

@interface XHVColorPath : UIView
@property (weak, nonatomic) id <ColorViewDelegate> delegate;
@end
