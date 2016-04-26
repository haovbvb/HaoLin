//
//  HSPTextView.h
//  HaoLin
//
//  Created by PING on 14-9-15.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPTextView : UITextView

/**
 *  设置提示文字
 */
@property(copy,nonatomic)NSString * placeholder;

@property (nonatomic, strong) UIColor *placeholderColor;


@end
