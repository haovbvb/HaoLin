//
//  JZDLoop_ScrollView.m
//  HaoLin
//
//  Created by Zidon on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDLoop_ScrollView.h"

@implementation JZDLoop_ScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)imageArray:(NSArray *)imgArray
{
    self.contentSize=CGSizeMake(imgArray.count*320, CGRectGetHeight(self.frame));
    
    for(int i=0;i<imgArray.count;i++){
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIndex:)];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(i*320, 0, 320, CGRectGetHeight(self.frame))];
        imgView.userInteractionEnabled=YES;
        [imgView addGestureRecognizer:tap];
        imgView.image=imgArray[i];
        [self addSubview:imgView];
    }
}

-(void)tapIndex:(UITapGestureRecognizer *)tap
{
    YYLog(@"%@",tap.view);
}

@end
