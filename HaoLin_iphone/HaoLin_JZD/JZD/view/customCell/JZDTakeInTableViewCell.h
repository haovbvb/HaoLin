//
//  JZDTakeInTableViewCell.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-13.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDTakeInTableViewCell : UITableViewCell
{
    NSString *state;
    NSString *group_id;
    NSString *request_id;
    JZDModuleHttpRequest *request;
}
@property (weak, nonatomic) IBOutlet UIButton *headImageButton;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *qqOrWeChat;
@property (weak, nonatomic) IBOutlet UILabel *describe;
//@property (weak, nonatomic) IBOutlet UILabel *publishTime;

@property (nonatomic,strong) JZDItem *item;

@property (weak, nonatomic) IBOutlet UIButton *agree;
@property (weak, nonatomic) IBOutlet UIButton *refuse;

- (IBAction)agree:(UIButton *)sender;
- (IBAction)refuse:(UIButton *)sender;
@end
