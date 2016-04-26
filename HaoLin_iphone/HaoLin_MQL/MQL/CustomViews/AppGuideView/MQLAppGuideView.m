//
//  MQLAppGuideView.m
//  HaoLin
//
//  Created by MQL on 14-10-16.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLAppGuideView.h"

@interface MQLAppGuideView ()<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *guideScrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *guidePageControl;

/**
 *  自定义初始化
 */
-(void)customInitialization;

@end

@implementation MQLAppGuideView

-(void)awakeFromNib
{
    [self customInitialization];
}

#pragma mark-- MQLAppGuideView函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    int pageTotalNumber = 3;
    self.guideScrollView.contentSize = CGSizeMake(pageTotalNumber * CGRectGetWidth(self.guideScrollView.frame),
                                                  IS_IPHONE_5 ? CGRectGetHeight(self.guideScrollView.frame) : CGRectGetHeight(self.guideScrollView.frame) - 88);
    self.guideScrollView.pagingEnabled = YES;
    self.guideScrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < pageTotalNumber; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"MQLAppGuide_%d", i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.userInteractionEnabled = YES;
        imageView.autoresizingMask = 0xFF;
        
        CGRect rightRect = self.guideScrollView.bounds;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.guideScrollView.frame) * i, 0);
        imageView.frame = rightRect;
        
        [self.guideScrollView addSubview:imageView];
        
        if (i == pageTotalNumber - 1) {
            
            UIButton *useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [useBtn setTitle:@"立即使用" forState:UIControlStateNormal];
            [useBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            useBtn.frame = CGRectMake(110, 292, 100, 30);
            [useBtn addTarget:self action:@selector(onUseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:useBtn];
        }
    }
    
}

-(void)onUseBtnClicked:(UIButton*)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfIntoRootView object:nil];
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger number = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    self.guidePageControl.currentPage = number;
    
}


@end
