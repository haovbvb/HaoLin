//
//  ZYPServeOrderCell.m
//  HaoLin
//
//  Created by mac on 14-9-5.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPServeOrderCell.h"

@implementation ZYPServeOrderCell

- (void)awakeFromNib
{
    // Initialization code
    self.state = @"正常";
    self.desLabel.numberOfLines = 0;
    self.desLabel.lineBreakMode = NSLineBreakByCharWrapping;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)play:(id)sender
{
    AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.urlString] error:nil];
    audio.volume = 0.8;//  音量
    audio.numberOfLoops = 1;// 只播放一次
    [audio prepareToPlay];///分配播放所需的资源，并将其加入内部播放队列
    if ([self.state isEqualToString:@"正常"]) {
        [audio play];//  播放
        self.state = @"暂停";
    }else if ([self.state isEqualToString:@"暂停"])
    {
        [audio stop];
        self.state = @"正常";
    }
}

@end
