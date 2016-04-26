//
//  ZYPGoodsCategaryVC.h
//  HaoLin
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYPGoodsCategaryVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *namElABEL;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *overBtn;

@property (nonatomic, strong)NSString *str;
- (void)updataSource:(NSString *)text;
@end
