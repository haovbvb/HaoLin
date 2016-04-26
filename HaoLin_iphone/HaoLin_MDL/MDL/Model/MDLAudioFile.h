//
//  MDLAudioFile.h
//  HaoLin
//
//  Created by apple on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDLAudioFile : NSObject
{
    NSURL *fileURL;
}

/**
 * path 本地路径
 * File 语音
 */
@property (nonatomic ,copy) NSString *path;
@property (nonatomic ,copy) NSString *File;
@property (nonatomic, strong) NSOperationQueue *operationqueue;

-(void)PlayAudioFile:(NSString *)playADurl;
-(void)DownLoadAudioFile:(NSString *)url;
-(void)PlayFile:(NSString *)audiopath;
-(void)stopFile:(NSString *)audiopath;
-(void)removefile:(UIButton *)tag;

@end
