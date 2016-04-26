//
//  JZDImageDownLoad.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-13.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JZDImageDownLoadDelegate <NSObject>

-(void)imageFinsihDownLoad:(UIImage *)image;

-(void)imageFinsihDownLoaded:(NSMutableArray *)imaArray;

@end

@interface JZDImageDownLoad : NSObject

-(void)setImageFromUrl:(NSMutableArray *)array;
-(void)setImageFromUrl:(NSString *)urlString completion:(void(^)(void))completion;

@property (nonatomic,weak) __weak id<JZDImageDownLoadDelegate> delegate;

@end
