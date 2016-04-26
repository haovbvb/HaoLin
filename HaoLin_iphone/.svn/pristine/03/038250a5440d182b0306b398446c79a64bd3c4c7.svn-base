//
//  MQLCellOfSection1InShiWuConfirmTableView.h
//  HaoLin
//
//  Created by MQL on 14-9-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQLGoodItemInfo;

@protocol MQLCellOfSection1InShiWuConfirmTableViewDelegate <NSObject>

-(void)goodItemInfoChanged;

@end

@interface MQLCellOfSection1InShiWuConfirmTableView : UITableViewCell

@property (nonatomic, strong) MQLGoodItemInfo *goodItemInfo;
@property (nonatomic, assign) BOOL isLastIndex;

@property (nonatomic, weak) id<MQLCellOfSection1InShiWuConfirmTableViewDelegate> delegate;

@end
