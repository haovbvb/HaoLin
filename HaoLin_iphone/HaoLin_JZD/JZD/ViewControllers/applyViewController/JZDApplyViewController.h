//
//  JZDApplyViewController.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDApplyViewController : UIViewController

@property (nonatomic,copy) NSString *group_Id;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *qqOrWeChatField;
@property (weak, nonatomic) IBOutlet UITextView *describeTextView;
- (IBAction)applyCommit:(UIButton *)sender;
@end
