//
//  ZYPbusinessDetailView.m
//  HaoLin
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPbusinessDetailView.h"

@implementation ZYPbusinessDetailView

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
    self.goodsDescTextView.layer.borderWidth = 1;
    self.goodsDescTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.businessActivityTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.businessActivityTV.layer.borderWidth = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
}
- (IBAction)saveInformation:(id)sender
{
    [self.detailVC saveInformatiom:self.goodsDescTextView.text activity:self.businessActivityTV.text];
}
#pragma mark - 
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.detailVC.scrollView.contentOffset = CGPointMake(0, 320);
    return YES;
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    [textView resignFirstResponder];
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    [self.goodsDescTextView resignFirstResponder];
    [self.businessActivityTV resignFirstResponder];
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
