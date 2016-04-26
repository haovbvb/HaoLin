//
//  JZDBBSTableViewCell.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDBBSTableViewCell : UITableViewCell

@property (nonatomic,strong) JZDItem *item;
@property (weak, nonatomic) IBOutlet UIButton *headImageButton;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UILabel *userPublishLable;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLable;
@end
