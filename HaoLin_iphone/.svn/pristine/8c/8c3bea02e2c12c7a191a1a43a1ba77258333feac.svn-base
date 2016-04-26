//
//  ZYPAudioPlayManger.m
//  HaoLin
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPAudioPlayManger.h"



@interface ZYPAudioPlayManger ()
{
//    AVAudioPlayer *  audioPlay;
}
@property (nonatomic, strong)NSString *str;
@property (nonatomic, strong)UIButton *btn;

/**
 *  私有方法，缓存音频文件
 */
- (NSString *)getCatchesPath:(NSURL *)url;


/**
 *  下载音频文件
 *
 *  @param url 下载url
 */
- (void)load:(NSURL *)url;


/**
 *  转换格式后播放本地文件
 */
- (void)getChangeFormat:(NSString *)path;


@end
@implementation ZYPAudioPlayManger
/**
 *  播放声音
 */
- (void)playAudioWithUrlString:(id)audioUrlString  button:(UIButton *)btn
{
       self.btn = btn;
    NSURL *url = nil;
    if ([audioUrlString isKindOfClass:[NSString class]])
    {
        url = [NSURL URLWithString:audioUrlString];
    }
    NSString *path = [self getCatchesPath:url];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if ([fileManger fileExistsAtPath:path])
    {
        [self getChangeFormat:path];
    }else
    {
        [self load:url];
    }
}
/**
 *  获取temp临时目录
 */
- (NSString *)getCatchesPath:(NSURL *)url
{
    NSString *path = NSTemporaryDirectory();
    NSString *pathName = [path stringByAppendingPathComponent:[url absoluteString]];
    return pathName;
}
/**
 *  下载音频文件
 *
 *  @param url 下载url
 */

- (void)load:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    __weak ZYPAudioPlayManger *playManger = self;
    NSURLSession *session = [NSURLSession sharedSession];
    /**
     *  下载音频临时文件
     */
    NSURLSessionDownloadTask *downSession = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
        {
            NSLog(@"location === %@",location);
            NSLog(@"response.suggestedFilename ======= %@",response.suggestedFilename);
            NSLog(@"error ==== %@",error);

            /**
             *  将临时文件存储到本地
             */
        NSLog(@"%@",[NSData dataWithContentsOfURL:location]);
        NSString *path = NSTemporaryDirectory();
        NSString *pathString = [path stringByAppendingString:response.suggestedFilename];
        NSURL *newFileLocation =[NSURL fileURLWithPath:pathString];
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:newFileLocation error:nil];
            
//        NSLog(@"%@",[NSData dataWithContentsOfFile:pathString]);
//        NSLog(@"%@",[NSData dataWithContentsOfURL:newFileLocation]);

        [self getChangeFormat:pathString];
            
            
            
            
            
//            /**
//             *  本地文件存在，就从本地读取
//             */
//            if ([playManger.str hasSuffix:@".amr"])
//            {
//                /**
//                 *  将amr文件转化成wav格式
//                 */
//                NSString *wavpath = [playManger.str stringByReplacingOccurrencesOfString:@".amr" withString:@".wav"];
//                [MQLAudioManage encodeToWav:wavpath fromAmr:playManger.str];
//                NSLog(@"%@",[NSData dataWithContentsOfFile:wavpath]);
//                /**
//                 *  播放本地音频
//                 */
//                [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
//                [[AVAudioSession sharedInstance] setActive: YES error: nil];
//                AVAudioPlayer *audioPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:wavpath] error:nil];
//                [audioPlay prepareToPlay];
//                [audioPlay setVolume:15];
//                [audioPlay play];
//            }
    }];
    [downSession resume];
}
/**
 *  转换格式后播放本地文件
 */
- (void)getChangeFormat:(NSString *)path
{
    
    /**
     *  本地文件存在，就从本地读取
     */
    if ([path hasSuffix:@".amr"])
    {
        /**
         *  将amr文件转化成wav格式
         */
        NSString *wavpath = [path stringByReplacingOccurrencesOfString:@".amr" withString:@".wav"];
        [MQLAudioManage encodeToWav:wavpath fromAmr:path];
        NSLog(@"%@",[NSData dataWithContentsOfFile:wavpath]);
        /**
         *  播放本地音频
         */
       
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        NSURL*url = [NSURL fileURLWithPath:wavpath];
        AVAudioPlayer *  audioPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:url  error:nil];
        [audioPlay play];
    }
}

/**
 *  停止播放
 */
- (void)stop
{
//    [audioPlay stop];
}
@end
