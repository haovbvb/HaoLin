//
//  JZDDecTableViewCell.h
//  HaoLin
//
//  Created by Zidon on 14-9-9.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDDecTableViewCell : UITableViewCell


@property (nonatomic,strong) JZDItem *item;
@property (weak, nonatomic) IBOutlet UILabel *describeLable;
@property (nonatomic,copy) NSString *desStr;
@end