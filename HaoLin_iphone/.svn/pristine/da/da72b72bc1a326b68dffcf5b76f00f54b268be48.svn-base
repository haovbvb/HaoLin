//
//  ZYPOrderLogoutView.m
//  HaoLin
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPOrderLogoutView.h"

@implementation ZYPOrderLogoutView

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
    self.titleLabel.backgroundColor = ZYPBGColor;
    if (IS_IPHONE_5) {
        self.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.frame = CGRectMake(0, 0, 320, 480);
    }
    
}
- (IBAction)login:(id)sender
{
    HSPLoginViewController *loginVC = [[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"A" object:nil];
    [self.petVC presentViewController:loginVC animated:YES completion:nil];
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
