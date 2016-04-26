//
//  MQLHanDanCharacterInputView.m
//  HaoLin
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLHanDanCharacterInputView.h"

@interface MQLHanDanCharacterInputView ()<UITextViewDelegate>

@property (nonatomic ,weak) IBOutlet UITextView *characterInputTV;
@property (nonatomic, weak) IBOutlet UIButton *changeToAudioRecordBtn;

-(IBAction)changeToAudioRecordBtnClicked:(id)sender;

/**
 *  自定义初始化
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

@implementation MQLHanDanCharacterInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    //自定义初始化
    [self customInitialization];
}

-(void)setDelegate:(id<MQLHanDanCharacterInputViewDelegate>)delegate
{
    _delegate = delegate;
    
    [self.characterInputTV becomeFirstResponder];
}

#pragma mark --MQLHanDanCharacterInputView函数扩展

-(IBAction)changeToAudioRecordBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(changeToAudioRecord)]) {
        
        [self.delegate changeToAudioRecord];
    }
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.characterInputTV.layer.borderColor = [[UIColor orangeColor]CGColor];
    self.characterInputTV.layer.borderWidth = 1.0;
    self.characterInputTV.contentInset = UIEdgeInsetsMake(-4,0,-4,0);
    
    [self.changeToAudioRecordBtn setImage:[UIImage imageNamed:@"MQLChangeToAudioNormalBtn"] forState:UIControlStateNormal];
    [self.changeToAudioRecordBtn setImage:[UIImage imageNamed:@"MQLChangeToAudioSelectedBtn"] forState:UIControlStateHighlighted];
    
}

/**
 *  调整自身及textView的frame
 */
-(void)adjustSelfAndTextViewFrame
{
    //获取textView实际高度
    float fHeight = [self getTextViewHeight];
    float offset = fHeight - self.characterInputTV.frame.size.height;
    
    if (fHeight > 29.473999 * 2) {//只有2行的高度
        return;
    }
    
    //设置self frame
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y - offset,
                            self.frame.size.width,
                            self.frame.size.height + offset);
    
    //设置textView frame
    self.characterInputTV.frame = CGRectMake(self.characterInputTV.frame.origin.x,
                                (self.frame.size.height - fHeight) / 2.0,
                                self.characterInputTV.bounds.size.width,
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
    CGSize constraint = CGSizeMake(self.characterInputTV.contentSize.width - fPadding, CGFLOAT_MAX);
    CGSize size = [self boundingRectWithSize:constraint withFont:self.characterInputTV.font withText:self.characterInputTV.text];
    float fHeight = size.height + fPadding / 2.0;
    return fHeight;
}

#pragma mark --UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        if (textView.text.length == 0) {
            
            [self showAlertViewWithTitle:@"提示" msg:@"请输入喊单信息" tag:-1];
            return NO;
        }
        
        [textView resignFirstResponder];
        
        if ([self.delegate respondsToSelector:@selector(showSendHanDanViewAfterInputFinish:)]) {
            
            [self.delegate showSendHanDanViewAfterInputFinish:self.characterInputTV.text];
            self.characterInputTV.text = @"";
            
            //此处清空text后，可能是多行的高度,所以后重新调整其高度
            [self adjustSelfAndTextViewFrame];
        }
        
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

/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}



@end
