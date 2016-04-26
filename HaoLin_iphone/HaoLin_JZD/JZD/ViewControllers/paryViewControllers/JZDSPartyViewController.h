//
//  JZDSPartyViewController.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDSPartyViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *navBarSegment;
- (IBAction)selectSegmen:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITableView *myPartyTableView;
@end
