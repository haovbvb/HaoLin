//
//  MQLAudioManage.h
//  Record&Play
//
//  Created by maqianli on 14-8-20.
//  Copyright (c) 2014年 maqianli. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface MQLAudioManage : NSObject


/**
 *  获取单实例
 *
 *  @return
 */
+(MQLAudioManage*)instance;

/**
 *  释放单实例
 */
+(void)freeInstance;

/**
 *  请求允许使用mic
 */
-(void)requestUserPermissionForAudioRecording;

/**
 *  启动录音
 *  wavFilePath:录制文件存放地址
 */
-(void)startRecordFromView:(UIView*)fromView withWavFilePath:(NSString*)wavFilePath;

/**
 *  停止录音
 */
-(void)stopRecord;

/**
 *  将wav转成amr
 *
 *  @param amrFilePath
 *  @param wavFilePath
 *
 *  @return
 */
-(NSString*)encodeToAmr:(NSString*)amrFilePath FromWav:(NSString*)wavFilePath;


/**
 *  将amr转成wav
 */
+(void)encodeToWav:(NSString*)wavFilePath fromAmr:(NSString*)amrFilePath;


@end
