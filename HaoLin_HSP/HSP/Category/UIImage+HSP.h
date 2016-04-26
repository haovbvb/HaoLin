//
//  UIImage+HSP.h
//  HaoLin
//
//  Created by PING on 14-8-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HSP)

// 显示圆头像
+ (instancetype)circleImageWithName:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
