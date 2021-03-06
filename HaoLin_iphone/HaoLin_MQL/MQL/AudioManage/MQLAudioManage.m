//
//  MQLAudioManage.m
//  Record&Play
//
//  Created by maqianli on 14-8-20.
//  Copyright (c) 2014年 maqianli. All rights reserved.
//

#import "MQLAudioManage.h"
#import "MQLRecordOperation.h"

static MQLAudioManage *audioManage = nil;

@interface MQLAudioManage ()

@property (nonatomic, strong) MQLRecordingStatusView *recordingStatusView;
@property (nonatomic, strong) NSOperationQueue *operationQueue;



/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag;

@end

@implementation MQLAudioManage

-(id)init
{
    self = [super init];
    if (self) {
        
        [self requestUserPermissionForAudioRecording];
    }
    
    return self;
}

+(MQLAudioManage*)instance
{
    if (audioManage == nil) {
        
        audioManage = [[MQLAudioManage alloc]init];
    }
    
    return audioManage;
}

+(void)freeInstance
{
    audioManage = nil;
}

/**
 *  请求允许使用mic
 */
-(void)requestUserPermissionForAudioRecording
{
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted){
     
        if (granted) {
            
            
        }else{
            
            // 显示一个提示框告诉用户这个app没有得到允许？
            [self showAlertViewWithTitle:@"提示" msg:@"请到设置-隐私-麦克风允许使用。" tag:-1];
        }
        
    }];
}

/**
 *  启动录音
 *  wavFilePath:录制文件存放地址
 */
-(void)startRecordFromView:(UIView*)fromView withWavFilePath:(NSString*)wavFilePath
{
    if (self.recordingStatusView) {
        
        return;
    }
    
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            // 用户同意获取数据
            //获取fromView在UIWindow中的坐标
            UIWindow *window = [[UIApplication sharedApplication]keyWindow];
            CGRect frameInWindow = [fromView convertRect:fromView.bounds toView:window];
            
            //显示录音状态视图
            self.recordingStatusView = [[MQLRecordingStatusView alloc]initWithFrame:CGRectMake(
                                                                                               window.bounds.origin.x,
                                                                                               window.bounds.origin.y,
                                                                                               window.bounds.size.width,
                                                                                               frameInWindow.origin.y)];
            [window addSubview:self.recordingStatusView];
            
            //开启录音child thread
            MQLRecordOperation *recordOperation = [[MQLRecordOperation alloc]initWithWavFilePath:wavFilePath];
            self.operationQueue = [[NSOperationQueue alloc]init];
            [self.operationQueue addOperation:recordOperation];
            
        } else {
            
            // 显示一个提示框告诉用户这个app没有得到允许？
            [self showAlertViewWithTitle:@"提示" msg:@"请到设置-隐私-麦克风允许使用。" tag:-1];
        } 
    }];
    
}

/**
 *  停止录音
 */
-(void)stopRecord
{
    //移除录音状态视图
    [self.recordingStatusView removeFromSuperview];
    self.recordingStatusView = nil;
    
    //停止录音
    [self.operationQueue cancelAllOperations];
    self.operationQueue = nil;
}

/**
 *  将wav转成amr
 *
 *  @param amrFilePath
 *  @param wavFilePath
 *
 *  @return
 */
-(NSString*)encodeToAmr:(NSString*)amrFilePath FromWav:(NSString*)wavFilePath
{
    
    [VoiceConverter wavToAmr:wavFilePath amrSavePath:amrFilePath];
    
    return amrFilePath;
}

/**
 *  将amr转成wav
 */
+(void)encodeToWav:(NSString*)wavFilePath fromAmr:(NSString*)amrFilePath
{
    [VoiceConverter amrToWav:amrFilePath wavSavePath:wavFilePath];
}

/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
