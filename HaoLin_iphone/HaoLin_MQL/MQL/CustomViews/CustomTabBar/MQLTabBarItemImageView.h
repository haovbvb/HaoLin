//
//  MQLTabBarItemImageView.h
//  customBarTest
//
//  Created by MQL on 14-9-3.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MQLTabBarItemImageViewDelegate <NSObject>

-(void)imageViewClicked:(id)sender;

@end

@interface MQLTabBarItemImageView : UIImageView

@property (nonatomic, weak)id<MQLTabBarItemImageViewDelegate> delegate;

/**
 *  自定义构造函数
 *
 *  @param frame
 *  @param normalImage
 *  @param highlightedImage
 *  @param title
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame withNormalImage:(UIImage*)normalImage
                                  withHighlightedImage:(UIImage*)highlightedImage
                                  withTitle:(NSString*)title;

/**
 *  设置标题颜色
 */
-(void)setTitleColor;


@end
