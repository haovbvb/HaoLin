//
//  ZYPInformationCell.m
//  HaoLin
//
//  Created by mac on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPInformationCell.h"

@implementation ZYPInformationCell

- (void)awakeFromNib
{
    // Initialization code
    // 此属性设置后， 可以根据文本的大小来换行
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode=NSLineBreakByCharWrapping;
    self.imageView.layer.cornerRadius = 5;
}
//- (void)layoutSubviews
//{
//    CGFloat height = [self heightOfLabelFromString:self.contentLabel.text];
//    NSLog(@"%f",height);
//    if (height > 40) {
//        height = 40;
//    }
//    self.contentLabel.frame = CGRectMake(20, 2, 280, height);
//    self.timeLabel.frame = CGRectMake(193,2 + height + 16, 114, 21);
//}
////  获取字符串的高度
//- (CGFloat)heightOfLabelFromString:(NSString *)string
//{
//    CGFloat width = 280;
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
//  CGSize size1 = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//    NSLog(@"ssss  %f",size1.height);
//    return size1.height;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
