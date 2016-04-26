//
//  ZYPSelectedCell.m
//  HaoLin
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPSelectedCell.h"

@implementation ZYPSelectedCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.selectedBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.selectedBtn.layer.borderWidth = 1;
//    self.selectedBtn.titleLabel.text = self.nameLabel.text;
    self.selectedBtn.tintColor = [UIColor clearColor];
    
}
- (IBAction)selected:(id)sender
{
    
    if (self.a == 0) {
        [self.scopeVC selected:sender tag:self.a];
        [self.scopevc caculuteCount:self.a but:sender];
        self.a = 1;
    }else if (self.a == 1)
    {
        [self.scopeVC selected:sender tag:self.a];
        [self.scopevc caculuteCount:self.a but:sender];
        self.a = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
