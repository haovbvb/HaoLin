//
//  MQLCustomTabBar.m
//
//  Created by maqianli on 14-8-8.
//  Copyright (c) 2014年 maqianli. All rights reserved.
//

#import "MQLCustomTabBar.h"
#import "MQLTabBarItemImageView.h"

@interface MQLCustomTabBar ()<MQLTabBarItemImageViewDelegate>

@property (nonatomic, strong) UIImageView *bottomLine;

@end

@implementation MQLCustomTabBar

/**
 *  自定义构造函数
 *
 *  @param frame
 *  @param normalImageArray
 *  @param selectedImageArray
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame normalImageArray:(NSArray*)normalImageArray selectedImageArray:(NSArray*)selectedImageArray titlesArray:(NSArray*)titlesArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.normalImageArray = normalImageArray;
        self.selectedImageArray = selectedImageArray;
        self.titlesArray = titlesArray;
        
        [self addBtnItems];
    }
    
    return self;
}

/**
 *  添加按钮项
 */
-(void)addBtnItems
{
    int count = [self.normalImageArray count];
    CGFloat itemWidth = 80;
    CGFloat itemHeight = 49;
    
    for (int i = 0; i < count; i++) {

        //添加按钮
        CGRect frame = CGRectMake(itemWidth * i, 0, itemWidth, itemHeight);
        UIImage *normalImage = [UIImage imageNamed:[self.normalImageArray objectAtIndex:i]];
        UIImage *highlightedImage = [UIImage imageNamed:[self.selectedImageArray objectAtIndex:i]];
        NSString *title = [self.titlesArray objectAtIndex:i];
        
        MQLTabBarItemImageView *imageView = [[MQLTabBarItemImageView alloc]initWithFrame:frame withNormalImage:normalImage withHighlightedImage:highlightedImage withTitle:title];
        imageView.delegate = self;
        imageView.tag = i;
        
        if (i == 0) {
            imageView.highlighted = YES;
            [imageView setTitleColor];
            
            self.selectedImageView = imageView;
            
            //初始化bottomLine
            self.bottomLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MQLTabBarItemBottomLine"]];
            self.bottomLine.frame = CGRectMake(self.selectedImageView.frame.origin.x,
                                               47,
                                               80,
                                               2);
            [self addSubview:self.bottomLine];
            
        }
        
        
        [self addSubview:imageView];
        
    }
}


#pragma mark -- MQLTabBarItemImageViewDelegate
-(void)imageViewClicked:(id)sender
{
    MQLTabBarItemImageView *imageView = (MQLTabBarItemImageView*)sender;
    
    if (imageView != self.selectedImageView) {
        
        //先去掉高亮
        self.selectedImageView.highlighted = NO;
        [self.selectedImageView setTitleColor];
        
        //再添加高亮
        imageView.highlighted = YES;
        [imageView setTitleColor];
        self.selectedImageView = imageView;
        
        //移动bottomLine
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:0.1];
        
        self.bottomLine.frame = CGRectMake(self.selectedImageView.frame.origin.x,
                                           47,
                                           80,
                                           2);
        
        [UIView commitAnimations];
        
        
        if ([self.delegate respondsToSelector:@selector(didSelectImageViewWithSelectedIndex:)]) {
            
            [self.delegate didSelectImageViewWithSelectedIndex:imageView.tag];
        }
        
    }
}



@end