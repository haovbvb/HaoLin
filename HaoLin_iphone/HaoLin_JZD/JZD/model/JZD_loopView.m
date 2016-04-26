//
//  JZD_loopView.m
//  LoopScrollViewDemo
//
//  Created by 姜泽东 on 14-8-22.
//  Copyright (c) 2014年 freewolf.me. All rights reserved.
//

#import "JZD_loopView.h"

@implementation JZD_loopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self uiconfig];
    }
    return self;
}

-(void)awakeFromNib
{
    [self uiconfig];
}

-(void)uiconfig
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.frame.size.height)];
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    [self addSubview:_scrollView];
    _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(260, CGRectGetHeight(self.frame)-10, 40, 10)];
    _pageControl.backgroundColor=[UIColor grayColor];
    _pageControl.currentPage=_currentPageIndex;
    _pageControl.backgroundColor=[UIColor clearColor];
//    [self addSubview:_pageControl];
}

-(void)setBlockNum:(NSInteger (^)(void))blockNum
{
    _totalPageCount=blockNum();
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
    if (_totalPageCount==2) {
        _scrollView.contentSize=CGSizeMake(2*CGRectGetWidth(self.frame), self.frame.size.height);
        for(int i=0;i<2;i++){
            UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapActionTwo:)];
            _blockView(i).userInteractionEnabled=YES;
            _blockView(i).frame=CGRectMake(i*320, 0, 320, CGRectGetHeight(self.frame));
            [_blockView(i) addGestureRecognizer:tapGesture2];
        }
        [_scrollView addSubview:_blockView(0)];
        [_scrollView addSubview:_blockView(1)];
    }else if(_totalPageCount==3){
        _scrollView.contentSize=CGSizeMake(3*CGRectGetWidth(self.frame), self.frame.size.height);
        [self configContentViews];
    }else{
        _scrollView.contentSize=CGSizeMake(CGRectGetWidth(self.frame), self.frame.size.height);
        _blockView(0).userInteractionEnabled=YES;
        [_blockView(0) addGestureRecognizer:tapGesture];
        [_scrollView addSubview:_blockView(0)];
    }
    _pageControl.numberOfPages=blockNum();
}

- (void)configContentViews
{
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    NSInteger counter = 0;
    for (UIView *contentView in _contenViewArray) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        rightRect.origin = CGPointMake(CGRectGetWidth(_scrollView.frame) * (counter ++), 0);
        contentView.frame = rightRect;
        [_scrollView addSubview:contentView];
    }
    if (_totalPageCount!=1) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];//显示中间位置
    }else if(_totalPageCount==1){
        [_scrollView setContentOffset:CGPointMake(2*_scrollView.frame.size.width, 0)];
    }
    [self bringSubviewToFront:_pageControl];
}

- (void)setScrollViewContentDataSource
{
    int prevPageIndex=[self getValidNextPageIndexWithPageIndex:_currentPageIndex-1];
    int nextPageIndex=[self getValidNextPageIndexWithPageIndex:_currentPageIndex+1];
    if (_contenViewArray==nil) {_contenViewArray=[@[] mutableCopy];}
    [_contenViewArray removeAllObjects];
    if (self.blockView) {
        [_contenViewArray addObject:_blockView(prevPageIndex)];
        [_contenViewArray addObject:_blockView(_currentPageIndex)];
        [_contenViewArray addObject:_blockView(nextPageIndex)];
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(int)currentPageIndex
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == _totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_totalPageCount!=2) {
        int contentOffsetX = scrollView.contentOffset.x;
        if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
            _currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
            [self configContentViews];
        }
        if(contentOffsetX <= 0) {
            _currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
            [self configContentViews];
        }
        _pageControl.currentPage=_currentPageIndex;
    }else{
        _pageControl.currentPage=scrollView.contentOffset.x/320;
    }
}

-(void)contentViewTapActionTwo:(UITapGestureRecognizer *)tap
{
    _tapCountIndex(_currentPageIndex);
}

-(void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    _tapCountIndex(_currentPageIndex);
}

@end
