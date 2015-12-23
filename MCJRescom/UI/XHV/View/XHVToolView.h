//
//  XHVToolView.h
//  MCJRescom
//
//  Created by MCJ on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kToolViewHeight  64

typedef enum
{
    kToolViewColor = 0,
    kToolViewLineWidth,
    kToolViewEarser,
    kToolViewUndo,
    kToolViewClear,
    kToolViewPhoto,
    kToolViewSave
} kToolViewFunction;

@protocol ToolViewDelegate <NSObject>

// 选择了颜色
- (void)toolViewSelectedColor:(UIColor *)color;

// 通知视图控制器，选择了某项功能
- (void)toolViewSelectedFunction:(kToolViewFunction)function;

@end

@interface XHVToolView : UIView
@property (weak, nonatomic) id <ToolViewDelegate> delegate;
@end
