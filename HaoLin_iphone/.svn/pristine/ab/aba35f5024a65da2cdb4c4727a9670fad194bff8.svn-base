//
//  MQLCellOfSection6InShiWuConfirmTableView.h
//  HaoLin
//
//  Created by MQL on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  MQLShiWuOrFuWuConfirmOrderFormDataManage;

@protocol MQLCellOfSection6InShiWuConfirmTableViewDelegate <NSObject>

/**
 *  提交实物确认订单
 */
-(void)shiWuConfirmOrderFormSubmit;


@end

@interface MQLCellOfSection6InShiWuConfirmTableView : UITableViewCell

@property (nonatomic, strong) MQLShiWuOrFuWuConfirmOrderFormDataManage *confirmOrderFormDataManage;
@property (nonatomic, weak) UIViewController *ownerViewController;  //所属控制器

@property (nonatomic, weak) id<MQLCellOfSection6InShiWuConfirmTableViewDelegate> delegate;


@end
