//
//  JZDPartyDetailVoiceTableViewCell.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDPartyDetailVoiceTableViewCell.h"

@implementation JZDPartyDetailVoiceTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    _voiceInfo.buttonImageRect=CGRectMake(245, 10, 40, 40);
    _voiceInfo.buttonTitleRect=CGRectMake(10, 10, 100, 40);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
