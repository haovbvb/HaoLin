//
//  ZYPAudioPlayManger.h
//  HaoLin
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPAudioPlayManger : NSObject
/**
 *  播放声音
 */
- (void)playAudioWithUrlString:(id)audioUrlString  button:(UIButton *)btn;
/**
 *  暂停
 */
- (void)stop;
@end
