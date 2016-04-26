//
//  MDLSuccessfulView.m
//  HaoLin
//
//  Created by apple on 14-8-16.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//  抢单成功 View

#import "MDLSuccessfulView.h"

@implementation MDLSuccessfulView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)awakeFromNib
{
    self.jixuqiangdanbutton.backgroundColor=MDLBGColor;
    self.navbar.backgroundColor=MDLBGColor;
    
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(Telephone:)
                                                  name:@"Telephone"
                                                object:nil];

    self.btnimge.backgroundColor=BGColor;
    
}
-(void)Telephone:(NSNotification *)not
{
    NSDictionary *phonedic =[not userInfo];
    [self.DianhuahaoButton setTitle:[phonedic objectForKey:@"phone"] forState:UIControlStateNormal];
}

- (IBAction)CallPhone:(id)sender {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==  UIUserInterfaceIdiomPhone){
        
        NSString *phoneNum = self.DianhuahaoButton.titleLabel.text;
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
        if ( !_phoneWebView ) {
            _phoneWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
        }
        [_phoneWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        
    }else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"此设备暂不支持打电话" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    //    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",phoneNum];
    //
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
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
