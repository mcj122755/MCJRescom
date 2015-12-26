//
//  AppSetting.h
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppSetting : NSObject
+(UIColor*)bgColor;
+(CGSize)deviceSize;
+(UIColor*)menuColor;
+(UIColor*)menuColorWithAlpha:(float)alpha;
+(void)setDeviceSize:(CGSize) size;
@end
