//
//  HSPPotosView.m
//  HaoLin
//
//  Created by PING on 14-8-15.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPPotosView.h"

@implementation HSPPotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)addImage:(UIImage *)image
{
    
    UIImageView *iv = [[UIImageView alloc] init];
    iv.image = image;
    [self addSubview:iv];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = self.subviews.count;
    int maxCount = 4;
    CGFloat imagePadding = 10;
    CGFloat imageWidth = (206 - (maxCount + 1) * imagePadding)/ maxCount;
    CGFloat imageHeight = imageWidth;
    
    for (int i = 0; i <count; i++) {

        int row = i / maxCount;
        CGFloat imageY = row * (imageHeight + imagePadding);
        
        int col = i % maxCount;
        
        CGFloat imageX = imagePadding + col * (imageWidth + imagePadding);
        
        UIImageView *imageView =  self.subviews[i];
        imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
    }
    
}

- (NSArray *)images
{
    // 创建数组保存所有的图片
    NSMutableArray *imagesArray = [NSMutableArray array];
    for (UIImageView *iv in self.subviews) {
        UIImage *image = iv.image;
        [imagesArray addObject:image];
    }
    return imagesArray;
}

@end
