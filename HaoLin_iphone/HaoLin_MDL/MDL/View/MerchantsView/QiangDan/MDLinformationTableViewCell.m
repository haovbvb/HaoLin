//
//  MDLinformationTableViewCell.m
//  HAOLINAPP
//
//  Created by apple on 14-8-11.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//

#import "MDLinformationTableViewCell.h"

@implementation MDLinformationTableViewCell

- (void)awakeFromNib
{
    self.addressLable.lineBreakMode = NSLineBreakByWordWrapping;
    self.addressLable.numberOfLines = 0;
    self.contentLale.lineBreakMode=NSLineBreakByCharWrapping;
    self.contentLale.numberOfLines = 0;
     
}
    //赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.addressLable.text = text;
    //设置label的最大行数
    self.addressLable.numberOfLines =3;
//    CGSize size = CGSizeMake(300, 1000);
    
//    CGSize labelSize = [self.addressLable.text sizeWithFont:self.addressLable.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//    self.addressLable.frame = CGRectMake(self.addressLable.frame.origin.x, self.addressLable.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
//    frame.size.height = labelSize.height+100;
    
//    CGSize lableSizi =[self.addressLable.text sizeWithAttributes:]
    
    self.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
