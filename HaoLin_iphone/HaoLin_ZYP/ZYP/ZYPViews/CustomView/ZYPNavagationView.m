//
//  ZYPNavagationView.m
//  HaoLin
//
//  Created by mac on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPNavagationView.h"

@implementation ZYPNavagationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib
{

}
- (IBAction)back:(id)sender
{
    [self.checkVC.navigationController popViewControllerAnimated:YES];
    [self.writeVC.navigationController popViewControllerAnimated:YES];
//    [self.writeVC dismissViewControllerAnimated:YES completion:nil];
    [self.scopeVC.navigationController popViewControllerAnimated:YES];

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
