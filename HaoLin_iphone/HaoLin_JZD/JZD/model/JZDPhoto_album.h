//
//  Photo_album.h
//  testLayerImage
//
//  Created by 姜泽东 on 14-8-26.
//  Copyright (c) 2014年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZDImgScrollView.h"
#import "JZDImageView.h"
@interface JZDPhoto_album : UIView<JZDImageViewDelegate,JZDImgScrollViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    NSInteger currentIndex;
    UIView *markView;
    UIView *scrollPanel;
}

@property (nonatomic,strong) UIView *(^blockView)(int index);

@property (nonatomic,strong) int (^totalPageCount)(void);

@end
