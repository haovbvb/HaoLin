//
//  MQLHanDanAudioRecordView.h
//  HaoLin
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MQLHanDanAudioRecordViewDelegate <NSObject>

/**
 *  切换到文字输入
 */
-(void)changeToCharacterInput;

/**
 *  录制完后显示“发送喊单视图”
 */
-(void)showSendHanDanViewAfterRecordFinish:(NSString*)wavFilePath;

@end

@interface MQLHanDanAudioRecordView : UIView

@property (nonatomic, weak) id<MQLHanDanAudioRecordViewDelegate> delegate;

@end
