//
//  ZYPPlainCell.h
//  HaoLin
//
//  Created by mac on 14-9-5.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYPPlainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;//  状态label
@property (weak, nonatomic) IBOutlet UILabel *nextLabel;//  挨着的label
@property (weak, nonatomic) IBOutlet UILabel *righetLabel;//  右边的label
@end
