//
//  ZYPImportCell.m
//  HaoLin
//
//  Created by mac on 14-8-29.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPImportCell.h"

@implementation ZYPImportCell

- (void)awakeFromNib
{
    // Initialization code
    self.btn.layer.borderWidth = 1;
    self.btn.layer.borderColor = [UIColor blackColor].CGColor;
    self.btn.titleLabel.text = self.nameLabel.text;
}

- (IBAction)selected:(id)sender
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
