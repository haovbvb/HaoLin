//
//  Photo_album.m
//  testLayerImage
//
//  Created by 姜泽东 on 14-8-26.
//  Copyright (c) 2014年 lcc. All rights reserved.
//

#import "JZDPhoto_album.h"

@implementation JZDPhoto_album

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setTotalPageCount:(int (^)(void))totalPageCount
{
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    _totalPageCount=totalPageCount;
    CGSize contentSize = myScrollView.contentSize;
    contentSize.height = win.bounds.size.height;
    contentSize.width = 320 * totalPageCount();
    myScrollView.contentSize = contentSize;
    for (int i = 0; i < totalPageCount(); i ++){
        JZDImageView *tmpView = (JZDImageView *)_blockView(i);
        tmpView.frame=CGRectMake(5+105*i, 0, 70, 70);
        tmpView.delegate = self;
        tmpView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        tmpView.tag = 10 + i;
        [self addSubview:tmpView];
    }
}

-(void)awakeFromNib
{
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    scrollPanel = [[UIView alloc] initWithFrame:win.bounds];
    scrollPanel.backgroundColor = [UIColor clearColor];
    [self addSubview:scrollPanel];
    markView = [[UIView alloc] initWithFrame:scrollPanel.bounds];
    markView.backgroundColor = [UIColor blackColor];
    markView.alpha=0;
    [scrollPanel addSubview:markView];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:win.bounds];
    [scrollPanel addSubview:myScrollView];
    myScrollView.pagingEnabled = YES;
    myScrollView.delegate = self;
}

//添加图片
- (void) addSubImgView
{
    for (UIView *tmpView in myScrollView.subviews){
        [tmpView removeFromSuperview];
    }
    for (int i = 0; i < _totalPageCount(); i ++){
        if (i == currentIndex){
            continue;
        }
        JZDImageView *tmpView = (JZDImageView *)[self viewWithTag:10 + i];
        //转换后的rect
        CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self];
        JZDImgScrollView *tmpImgScrollView = [[JZDImgScrollView alloc] initWithFrame:(CGRect){i*myScrollView.bounds.size.width,0,myScrollView.bounds.size}];
        [tmpImgScrollView setContentWithFrame:convertRect];
        [tmpImgScrollView setImage:tmpView.image];
        [myScrollView addSubview:tmpImgScrollView];
        tmpImgScrollView.i_delegate = self;
        [tmpImgScrollView setAnimationRect];
    }
}

- (void) setOriginFrame:(JZDImgScrollView *) sender
{
    [UIView animateWithDuration:0.4 animations:^{
        [sender setAnimationRect];
        markView.alpha = 1.0;
    }];
}

//代理方法--展开
- (void) imageSingelClick:(JZDImageView *)sender
{
    [self bringSubviewToFront:scrollPanel];
    scrollPanel.alpha = 1.0;
    JZDImageView *tmpView = sender;
    currentIndex = tmpView.tag - 10;
    //转换后的rect
    CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self];
    CGPoint contentOffset = myScrollView.contentOffset;
    contentOffset.x = currentIndex*320;
    myScrollView.contentOffset = contentOffset;
    //添加
    [self addSubImgView];
    JZDImgScrollView *tmpImgScrollView = [[JZDImgScrollView alloc] initWithFrame:(CGRect){contentOffset,myScrollView.bounds.size}];
    [tmpImgScrollView setContentWithFrame:convertRect];
    [tmpImgScrollView setImage:tmpView.image];
    [myScrollView addSubview:tmpImgScrollView];
    tmpImgScrollView.i_delegate = self;
    [self performSelector:@selector(setOriginFrame:) withObject:tmpImgScrollView afterDelay:0.1];
}
//代理方法--收回
- (void) tapImageViewTappedWithObject:(id)sender
{
    JZDImgScrollView *tmpImgView = sender;
    [UIView animateWithDuration:0.5 animations:^{
        markView.alpha = 0;
        [tmpImgView rechangeInitRdct];
    } completion:^(BOOL finished) {
        scrollPanel.alpha = 0;
    }];
}

#pragma mark - scroll delegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    currentIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

@end
