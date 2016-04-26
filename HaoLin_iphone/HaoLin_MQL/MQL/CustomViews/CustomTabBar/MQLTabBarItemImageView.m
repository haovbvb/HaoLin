//
//  MQLTabBarItemImageView.m
//  customBarTest
//
//  Created by MQL on 14-9-3.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLTabBarItemImageView.h"

@interface MQLTabBarItemImageView ()

@property (nonatomic, strong)UIImage *yourNormalImage;
@property (nonatomic, strong)UIImage *yourHighlightedImage;
@property (nonatomic, copy) NSString *yourTitle;

@property (nonatomic, strong) UILabel *titleLab;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加单击手势
 */
-(void)addTapGesture;


@end

@implementation MQLTabBarItemImageView

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
                                  withTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.yourNormalImage = normalImage;
        self.yourHighlightedImage = highlightedImage;
        self.yourTitle = title;
        
        // 自定义初始化
        [self customInitialization];
        
        //添加单击手势
        [self addTapGesture];
    }
    return self;
}

/**
 *  设置标题颜色
 */
-(void)setTitleColor
{
    if (self.isHighlighted) {
        
        self.titleLab.textColor = [UIColor orangeColor];
    }else{
        
        self.titleLab.textColor = [UIColor blackColor];
    }
}

#pragma mark -- MQLTabBarItemImageView函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.userInteractionEnabled = YES;
    
    self.image = self.yourNormalImage;
    self.highlightedImage = self.yourHighlightedImage;
    
    //添加底部标题
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + 25)];
    self.titleLab.font = [UIFont systemFontOfSize:12];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.text = self.yourTitle;
    [self addSubview:self.titleLab];
    
}

/**
 *  添加单击手势
 */
-(void)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tap];
}

-(void)onTap:(UITapGestureRecognizer*)tap
{
    if ([self.delegate respondsToSelector:@selector(imageViewClicked:)]) {
        
        [self.delegate imageViewClicked:self];
    }
}


@end
