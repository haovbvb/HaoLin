//
//  MyJoinTableViewCell.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MyJoinTableViewCell.h"

@implementation MyJoinTableViewCell
@synthesize item=_item;
- (void)awakeFromNib
{
    // Initialization code
}

-(JZDItem *)item
{
    return _item;
}

-(void)setItem:(JZDItem *)item
{
    _item=item;
    [_headImageButton setBackgroundImage:item.headImage forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
