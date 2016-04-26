//
//  MQLShiWuConfirmOrderFormView.h
//  HaoLin
//
//  Created by MQL on 14-9-17.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQLShiWuOrFuWuConfirmOrderFormDataManage;
@interface MQLShiWuConfirmOrderFormView : UIView


@property (nonatomic, strong) MQLShiWuOrFuWuConfirmOrderFormDataManage *confirmOrderFormDataManage;
@property (nonatomic, weak) UIViewController *ownerViewController;  //所属控制器

@end
