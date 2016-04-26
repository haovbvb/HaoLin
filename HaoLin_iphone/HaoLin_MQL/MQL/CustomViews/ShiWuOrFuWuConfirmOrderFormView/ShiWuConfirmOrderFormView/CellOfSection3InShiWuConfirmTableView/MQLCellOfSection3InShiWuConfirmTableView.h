//
//  MQLCellOfSection3InShiWuConfirmTableView.h
//  HaoLin
//
//  Created by MQL on 14-9-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQLPayModeDataManage, MQLPayModeItemInfo;

@protocol MQLCellOfSection3InShiWuConfirmTableViewDelegate <NSObject>

-(void)selectedByUser;

@end


@interface MQLCellOfSection3InShiWuConfirmTableView : UITableViewCell

@property (nonatomic, strong) MQLPayModeDataManage *payModeDataManage;
@property (nonatomic, strong) MQLPayModeItemInfo * payModeItemInfo;
@property (nonatomic, assign) BOOL isLastIndex;

@property (nonatomic, weak) id<MQLCellOfSection3InShiWuConfirmTableViewDelegate> delegate;

@end
