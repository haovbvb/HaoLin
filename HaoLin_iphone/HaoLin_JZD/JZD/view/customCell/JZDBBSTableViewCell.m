//
//  JZDBBSTableViewCell.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDBBSTableViewCell.h"

@implementation JZDBBSTableViewCell
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
    [_headImageButton setBackgroundImage:[UIImage circleImageWithName:_item.headImage borderWidth:0.1 borderColor:nil] forState:UIControlStateNormal];
    _nickNameLable.text=item.nickName;
    _userPublishLable.text=item.answerDes;
    _publishTimeLable.text=item.timeForStart;
    CGSize size=[_userPublishLable.text boundingRectWithSize:CGSizeMake(290, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    CGRect rect=_userPublishLable.frame;
    CGRect timeRect=_publishTimeLable.frame;
    if (size.height>_userPublishLable.frame.size.height) {
        rect.size.height=size.height;
        _userPublishLable.frame=rect;
        timeRect.origin.y=55+size.height;
        _publishTimeLable.frame=timeRect;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
