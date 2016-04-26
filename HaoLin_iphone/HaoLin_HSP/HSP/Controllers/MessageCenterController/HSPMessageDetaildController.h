//
//  HSPMessageDetaildController.h
//  HaoLin
//
//  Created by PING on 14-10-10.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYPInformationObject;

@interface HSPMessageDetaildController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *inforLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) ZYPInformationObject *infoObject;
@property (nonatomic, copy) NSString *inforText;

@end
