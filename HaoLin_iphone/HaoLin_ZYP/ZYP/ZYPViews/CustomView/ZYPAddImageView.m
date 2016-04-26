//
//  ZYPAddImageView.m
//  HaoLin
//
//  Created by mac on 14-9-13.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPAddImageView.h"

@implementation ZYPAddImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)delete:(id)sender
{
    [self removeFromSuperview];
    [self.owerViewController deleteImage:self.tag];
}
- (void)awakeFromNib
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage:)];
    self.deleBTn.hidden = YES;
    self.addImageView.userInteractionEnabled = YES;
    tap.numberOfTapsRequired = 1;
    [self.addImageView addGestureRecognizer:tap];
}
///  循环添加不同的imagView
- (void)addImage:( UITapGestureRecognizer *)tap1
{
    [self.owerViewController addImage];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
