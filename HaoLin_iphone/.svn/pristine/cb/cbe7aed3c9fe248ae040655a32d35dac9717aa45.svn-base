//
//  JZDDecTableViewCell.m
//  HaoLin
//
//  Created by Zidon on 14-9-9.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDDecTableViewCell.h"

@implementation JZDDecTableViewCell
@synthesize item=_item;
- (void)awakeFromNib
{
    // Initialization code
}

//-(void)drawRect:(CGRect)rect
//{
//    _describeLable.font=[UIFont systemFontOfSize:17];
//    _describeLable.lineBreakMode=NSLineBreakByCharWrapping;
//    _describeLable.numberOfLines=0;
//    CGSize size=[_describeLable.text boundingRectWithSize:CGSizeMake(302, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
//    CGRect rect1=_describeLable.frame;
//    rect1.size.height=size.height;
//    _describeLable.frame=rect1;
//}

-(void)setDesStr:(NSString *)desStr
{
    _describeLable.text=desStr;
//    YYLog(@"##%@",desStr);
//    _describeLable.font=[UIFont systemFontOfSize:17];
//    _describeLable.lineBreakMode=NSLineBreakByCharWrapping;
//    _describeLable.numberOfLines=0;
    CGSize size=[_describeLable.text boundingRectWithSize:CGSizeMake(302, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGRect rect=_describeLable.frame;
    rect.size.height=size.height;
    _describeLable.frame=rect;
//    [self setNeedsDisplay];
}

@end
