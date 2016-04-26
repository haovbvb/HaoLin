//
//  MQLSendAddressInputView.m
//  HaoLin
//
//  Created by MQL on 14-9-30.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLSendAddressInputView.h"

@interface MQLSendAddressInputView ()<UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *inputTV;


/*
 *自定义初始化
 */
-(void)customInitialization;

/**
 *  调整自身及textView的frame
 */
-(void)adjustSelfAndTextViewFrame;

/**
 * 获取textView实际高度
 *
 *  @return
 */
-(float)getTextViewHeight;


@end

@implementation MQLSendAddressInputView

-(void)awakeFromNib
{
    [self customInitialization];
}

-(void)setPersonalHanDanDataManage:(MQLPersonalHanDanDataManage *)personalHanDanDataManage
{
    _personalHanDanDataManage = personalHanDanDataManage;
    [self.inputTV becomeFirstResponder];
    
    self.inputTV.text = personalHanDanDataManage.sendAddress;
    [self adjustSelfAndTextViewFrame];
    
}

-(void)setDelegate:(id<MQLSendAddressInputViewDelegate>)delegate
{
    _delegate = delegate;
}

#pragma mark -- MQLSendAddressInputView

/*
 *自定义初始化
 */
-(void)customInitialization
{
    self.inputTV.layer.borderColor = [[UIColor orangeColor]CGColor];
    self.inputTV.layer.borderWidth = 1.0;
    self.inputTV.contentInset = UIEdgeInsetsMake(-4,0,-4,0);
    
    
}

/**
 *  调整自身及textView的frame
 */
-(void)adjustSelfAndTextViewFrame
{
    //获取textView实际高度
    float fHeight = [self getTextViewHeight];
    float offset = fHeight - self.inputTV.frame.size.height;
    
    if (fHeight > 29.473999 * 2) {//只有2行的高度
        return;
    }
    
    //设置self frame
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y - offset,
                            self.frame.size.width,
                            self.frame.size.height + offset);
    
    //设置textView frame
    self.inputTV.frame = CGRectMake(self.inputTV.frame.origin.x,
                                   (self.frame.size.height - fHeight) / 2.0,
                                    self.inputTV.bounds.size.width,
                                    fHeight);
    
    
    
}

/**
 * 获取textView实际高度
 *
 *  @return
 */
-(float)getTextViewHeight
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(self.inputTV.contentSize.width - fPadding, CGFLOAT_MAX);
    CGSize size = [self boundingRectWithSize:constraint withFont:self.inputTV.font withText:self.inputTV.text];
    float fHeight = size.height + fPadding / 2.0;
    return fHeight;
}

/**
 *  注销第一响应
 */
-(void)resignInputTVFirstResponder
{
    if ([self.inputTV isFirstResponder]) {
        
        [self.inputTV resignFirstResponder];
    }
}

#pragma mark --UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        self.personalHanDanDataManage.sendAddress = textView.text;
        [self.delegate sendAddressInputFinish];
        
        return NO;
        
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    // 调整自身及textView的frame
    [self adjustSelfAndTextViewFrame];
    
}

- (CGSize)boundingRectWithSize:(CGSize)size withFont:(UIFont*)font withText:(NSString*)text
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}


@end
