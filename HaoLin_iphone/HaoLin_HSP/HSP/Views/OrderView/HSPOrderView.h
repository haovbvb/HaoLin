//
//  HSPOrderView.h
//  HaoLin
//
//  Created by PING on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPOrderView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIViewController  *HSPOrderViewController;
@property (nonatomic, strong) HSPNavigationController *navigationController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)segmentedControlClick:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UIView *navBgView;

@end
