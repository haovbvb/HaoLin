//
//  HSPOrderAllViewController.h
//  HaoLin
//
//  Created by PING on 14-9-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPOrderAllViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)segmentedControlClick:(UISegmentedControl *)sender;

@end
