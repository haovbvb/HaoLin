//
//  HSPPotosView.h
//  HaoLin
//
//  Created by PING on 14-8-15.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPPotosView : UIView

/**
 *  添加显示图片
 *
 *  @param image 图片地址
 */
- (void)addImage:(UIImage *)image;

/**
 *  保存所有图片
 *
 */
- (NSArray *)images;


@end
