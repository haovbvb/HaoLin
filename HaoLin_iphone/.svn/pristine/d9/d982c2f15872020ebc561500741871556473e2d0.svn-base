//
//  MDLAudioFile.m
//  HaoLin
//
//  Created by apple on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MDLAudioFile.h"

@implementation MDLAudioFile

- (NSOperationQueue *)_operationqueue
{
    if (!_operationqueue) _operationqueue = [[NSOperationQueue alloc] init];
    return _operationqueue;
}

-(void)PlayFile:(NSString *)audiopath
{
//    [self PlayAudioFile:audiopath];
//    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
//    [player prepareToPlay];
//    [player play];
    
    [self downloadFile:audiopath];
}
-(void)stopFile:(NSString *)audiopath
{
    [self PlayAudioFile:audiopath];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [player stop];
}
-(void)removefile:(UIButton *)tag
{
    [[NSFileManager defaultManager] removeItemAtPath:self.File error:nil];

}
///**
// *  播放音频方法
// *
// *  @param btn  =btn.tag
// */
-(void)PlayAudioFile:(NSString *)playADurl
{
////    [self DownLoadAudioFile:playADurl];
//    if (![self.File isEqualToString:@""]) {
//        NSBlockOperation *downloadfileop = [NSBlockOperation blockOperationWithBlock:^{
//            [self DownLoadAudioFile:playADurl];
//        }];
//    
//    NSBlockOperation *playVoiceOp = [NSBlockOperation blockOperationWithBlock:^{
//        if ([self.File hasSuffix:@".amr"]) {
//            NSString *wavfile=[self.File stringByReplacingOccurrencesOfString:@"amr" withString:@"wav"];
//            [MQLAudioManage encodeToWav:wavfile fromAmr:self.File];
//            fileURL = [NSURL fileURLWithPath:wavfile];
//        }
//        
//    }];
//        [playVoiceOp addDependency:downloadfileop];
//        [self.operationqueue addOperation:playVoiceOp];
//        [self.operationqueue addOperation:downloadfileop];
//    }
//}
//
///**
// *  下载音频文件到本地
// *
// *  @param url 传入的路径
// */
//-(void)DownLoadAudioFile:(NSString *)audiourl
//{
//
//    NSString *urlStr = [audiourl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        self.path = NSTemporaryDirectory();
//        self.File = [self.path stringByAppendingPathComponent:response.suggestedFilename];
//        fileURL = [NSURL fileURLWithPath:self.File];
//        [[NSFileManager defaultManager] copyItemAtURL:location toURL:fileURL error:NULL];
//    }] resume];
//
}



/**
 *  文件下载
 *
 *  @param urlStr 文件地址
 */
- (void)downloadFile:(NSString *)urlStr
{
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        self.path = NSTemporaryDirectory();
        self.File = [self.path stringByAppendingPathComponent:response.suggestedFilename];
        fileURL = [NSURL fileURLWithPath:self.File];
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:fileURL error:NULL];
        
        // amr转wav
        NSString *wavFilePath=[self.File stringByReplacingOccurrencesOfString:@"amr" withString:@"wav"];
        [MQLAudioManage encodeToWav:wavFilePath fromAmr:self.File];
        // 播放音频
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:wavFilePath] error:nil];
            [player play];
        }];
    }] resume];
}
@end
