//
//  HSPTextView.m
//  HaoLin
//
//  Created by PING on 14-9-15.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPTextView.h"

@interface HSPTextView ()<UITextViewDelegate>
/**
 *  提示文本容器
 */
@property (nonatomic, weak) UILabel *label;
@end

@implementation HSPTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.创建label
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.textColor = [UIColor grayColor];
        label.font = self.font;
        [self addSubview:label];
        self.label = label;
        
        // 2.监听textView文本的改变
        //        self.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    // 取消监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)textChange
{
    // 判断当前文本输入框有没有文字
    if (self.text.length) {
        //        有文字 , 隐藏label
        self.label.hidden = YES;
    }else{
        //        没有文字 显示label
        self.label.hidden = NO;
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    // 1.设置提示文本
    self.label.text = _placeholder;

    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:28.0f],NSFontAttributeName,nil, nil];
    CGSize textSize = [_placeholder sizeWithAttributes:attribute];
    self.label.x = 5;
    self.label.y = 0;
    self.label.size = textSize;
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.label.textColor = placeholderColor;
}


- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.label.font = font;
    
    // 重新计算label的frame
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:28.0f],NSFontAttributeName,nil, nil];
    CGSize textSize = [_placeholder sizeWithAttributes:attribute];
    
    self.label.x = 5;
    self.label.y = 0;
    self.label.size = textSize;
    
}


@end
