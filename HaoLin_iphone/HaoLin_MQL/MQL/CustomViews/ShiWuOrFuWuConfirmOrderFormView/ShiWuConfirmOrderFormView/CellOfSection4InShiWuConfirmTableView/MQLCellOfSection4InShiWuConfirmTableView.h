//
//  MQLCellOfSection4InShiWuConfirmTableView.h
//  HaoLin
//
//  Created by MQL on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQLCashCouponDataManage;
@interface MQLCellOfSection4InShiWuConfirmTableView : UITableViewCell

@property (nonatomic, strong) MQLCashCouponDataManage *cashCouponDataManage;
@property (nonatomic, weak) UIViewController *ownerViewController;  //所属控制器

@end
