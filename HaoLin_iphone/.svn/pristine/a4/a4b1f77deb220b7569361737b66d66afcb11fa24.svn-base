//
//  ZYPScopeViewController.h
//  HaoLin
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CallBack)(NSMutableArray *arr);

@interface ZYPScopeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (void)selected:(UIButton *)sender tag:(NSInteger)tag;
- (void)callback:(CallBack)callback;
@end
