//
//  MQLCustomTabBar.h
//
//  Created by maqianli on 14-8-8.
//  Copyright (c) 2014年 maqianli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQLTabBarItemImageView;
@protocol MQLCustomTabBarDelegate <NSObject>

-(void)didSelectImageViewWithSelectedIndex:(NSUInteger)selectedIndex;

@end

@interface MQLCustomTabBar : UIView

@property (nonatomic, strong) NSArray *normalImageArray;
@property (nonatomic, strong) NSArray *selectedImageArray;
@property (nonatomic, strong) NSArray *titlesArray;

@property (nonatomic, weak) id<MQLCustomTabBarDelegate> delegate;

@property (nonatomic, weak) MQLTabBarItemImageView *selectedImageView;

/**
 *  自定义构造函数
 *
 *  @param frame
 *  @param normalImageArray
 *  @param selectedImageArray
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame normalImageArray:(NSArray*)normalImageArray selectedImageArray:(NSArray*)selectedImageArray titlesArray:(NSArray*)titlesArray;

/**
 *  添加按钮项
 */
-(void)addBtnItems;


@end
