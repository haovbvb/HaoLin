//
//  ZYPInforDetailVC.h
//  HaoLin
//
//  Created by mac on 14-9-4.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ZYPInformationObject;
@interface ZYPInforDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *inforLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong)ZYPInformationObject *infoObject;
@property (nonatomic, strong)NSString *inforText;

@end
