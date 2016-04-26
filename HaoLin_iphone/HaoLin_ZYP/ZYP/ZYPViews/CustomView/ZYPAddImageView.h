//
//  ZYPAddImageView.h
//  HaoLin
//
//  Created by mac on 14-9-13.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ZYPPictureDescVC;
@interface ZYPAddImageView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleBTn;
@property (nonatomic, strong)ZYPPictureDescVC *owerViewController;
@end
