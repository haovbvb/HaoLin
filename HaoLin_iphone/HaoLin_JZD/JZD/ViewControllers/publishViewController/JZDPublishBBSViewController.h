//
//  JZDPublishBBSViewController.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDPublishBBSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleBBs;
@property (weak, nonatomic) IBOutlet UITextView *describeBBs;
@property (weak, nonatomic) IBOutlet UIButton *addImage;
@property (weak, nonatomic) IBOutlet JZDCheckButton *speakVoice;
@property (weak, nonatomic) IBOutlet UIButton *commitBBs;
- (IBAction)commitBBs:(UIButton *)sender;
- (IBAction)addImage:(UIButton *)sender;

- (IBAction)recordOut:(JZDCheckButton *)sender;
- (IBAction)recordDown:(JZDCheckButton *)sender;
- (IBAction)recordUpInside:(JZDCheckButton *)sender;
- (IBAction)listenVoice:(UIButton *)sender;
@end



