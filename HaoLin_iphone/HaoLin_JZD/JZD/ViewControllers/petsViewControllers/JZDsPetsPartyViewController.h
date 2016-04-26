//
//  JZDsPetsPartyViewController.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDsPetsPartyViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *navBarSegment;

- (IBAction)myPartySelect:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITableView *myPetsPartyTableView;
@end
