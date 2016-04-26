//
//  JZDPartyDetailTableViewCell.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDPartyDetailTableViewCell.h"

@implementation JZDPartyDetailTableViewCell
@synthesize item=_item;
- (void)awakeFromNib
{
    // Initialization code
}

-(JZDItem *)item
{
    return _item;
}

-(void)clear
{
    _publishTimeLable.text=@"";
    _publishContentLable.text=@"";
}

-(void)setItem:(JZDItem *)item
{
    if (_item!=item) {
        _item=item;
    }
    [_headImageButton setBackgroundImage:[UIImage circleImageWithName:_item.headImage borderWidth:0.1 borderColor:nil] forState:UIControlStateNormal];
    _publishContentLable.text=item.publishContentString;
    _publishTimeLable.text=item.publishTimeString;
    _nickNameLable.text=item.nickName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
