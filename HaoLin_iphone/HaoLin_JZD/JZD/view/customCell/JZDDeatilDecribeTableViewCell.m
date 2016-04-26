//
//  JZDDeatilDecribeTableViewCell.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDDeatilDecribeTableViewCell.h"

@implementation JZDDeatilDecribeTableViewCell
@synthesize item=_item;
-(void)drawRect:(CGRect)rect
{
    _detailLable.font=[UIFont systemFontOfSize:16];
    _detailLable.lineBreakMode=NSLineBreakByCharWrapping;
    _detailLable.numberOfLines=0;
    CGSize size=[_detailLable.text boundingRectWithSize:CGSizeMake(310, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    _detailLable.frame=CGRectMake(10, 30, size.width, size.height);
    _detailLable.backgroundColor=[UIColor grayColor];
}

-(JZDItem *)item
{
    return _item;
}

-(void)setItem:(JZDItem *)item
{
    _item=item;
    _detailLable.text=_item.describeString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
