//
//  HSPConponCell.h
//  HaoLin
//
//  Created by PING on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSPConpon;

@interface HSPConponCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *conponPrice;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *conponCode;
@property (weak, nonatomic) IBOutlet UILabel *LimitedTime;
@property (weak, nonatomic) IBOutlet UILabel *conponCodeTitle;
@property (weak, nonatomic) IBOutlet UILabel *limitedTimeTitle;
@property (weak, nonatomic) IBOutlet UILabel *conponPriceTitle;

/**
 *  模型
 */
@property (nonatomic, strong) HSPConpon *conpon;

@end
