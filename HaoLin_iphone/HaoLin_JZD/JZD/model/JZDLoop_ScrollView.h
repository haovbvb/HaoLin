//
//  JZDLoop_ScrollView.h
//  HaoLin
//
//  Created by Zidon on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDLoop_ScrollView : UIScrollView

-(void)imageArray:(NSArray *)imgArray;
@property (nonatomic,strong) void(^imgTap)(int tapIndex);
@end
