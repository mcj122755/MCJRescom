//
//  ALAssetsLibrary+W.h
//  xiangpian
//
//  Created by MS on 15-9-11.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
typedef void(^SaveImageCompletion)(NSError* error);
@interface ALAssetsLibrary (W)
-(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;
-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;
@end
