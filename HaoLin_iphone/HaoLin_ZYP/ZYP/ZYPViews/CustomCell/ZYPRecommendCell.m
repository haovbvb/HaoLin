//
//  ZYPRecommendCell.m
//  HaoLin
//
//  Created by mac on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPRecommendCell.h"

@implementation ZYPRecommendCell

- (void)awakeFromNib
{
    // Initialization code
    self.businessImage.layer.cornerRadius = 5;
    self.businessImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.businessImage.layer.borderWidth = 1;
    self.phoneImageView.layer.cornerRadius = 12;
    self.phoneImageView.layer.masksToBounds = YES;
    //  afnetworking加载图片
//    [self.businessImage setImageWithURL:[NSURL URLWithString:self.object.thumb] placeholderImage:[UIImage imageNamed:@"ZYPshop_default_avatar.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
