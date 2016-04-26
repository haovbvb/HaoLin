//
//  MQLRecordOperation.m
//  Record&Play
//
//  Created by maqianli on 14-9-6.
//  Copyright (c) 2014年 maqianli. All rights reserved.
//

#import "MQLRecordOperation.h"

@interface MQLRecordOperation ()

@property (nonatomic, copy) NSString *wavFilePath;
@property (nonatomic,strong) AVAudioRecorder *recorder;

/**
 *  启动录音
 */
-(void)startRecord;

/**
 *  停止录音
 */
-(void)stopRecord;

@end

@implementation MQLRecordOperation

-(void)dealloc
{
    
}

/**
 *  自定义初始化构造函数
 *
 *  @param wavFilePath
 *
 *  @return
 */
-(id)initWithWavFilePath:(NSString*)wavFilePath
{
    self = [super init];
    if (self) {
        
        self.wavFilePath = wavFilePath;
    }
    
    return self;
}

-(void)main
{
    while (self.isCancelled == NO) {
        
        
        if ([self.recorder isRecording] == NO) {
            
            [self startRecord];
        }
        
    }
    
    [self stopRecord];
}

/**
 *  启动录音
 */
-(void)startRecord
{
    NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:8000],AVSampleRateKey,
                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                            nil];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];


    NSURL *fileUrl=[NSURL fileURLWithPath:self.wavFilePath];
    NSError *error;
    self.recorder=[[AVAudioRecorder alloc]initWithURL:fileUrl settings:settings error:&error];
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder peakPowerForChannel:0];
    [self.recorder record];

}

/**
 *  停止录音
 */
-(void)stopRecord
{
    //停止录音
    [self.recorder stop];
    self.recorder=nil;
    
}

@end
