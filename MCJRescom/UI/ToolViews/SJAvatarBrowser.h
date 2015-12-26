//
//  SJAvatarBrowser.h
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFDPictureModel.h"
#import <UIKit/UIKit.h>

@interface SJAvatarBrowser : NSObject
+(void)showImage:(UIImageView*)avatarImageView pictureModel:(LFDPictureModel*)model;
@end
