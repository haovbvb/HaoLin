//
//  JZDTakeInTableViewCell.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-13.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//  同意/拒绝操作

#import "JZDTakeInTableViewCell.h"
@implementation JZDTakeInTableViewCell
@synthesize item=_item;

-(void)dealloc
{
    
}

- (void)awakeFromNib
{
    // Initialization code
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    state=[defaults objectForKey:@"btnState"];
    group_id=[defaults objectForKey:@"group_id"];
    request_id=[defaults objectForKey:@"request_id"];
    request=[JZDModuleHttpRequest sharedInstace];
    [self uiconfig];
}

-(void)uiconfig
{
    if (![state isEqualToString:@""]) {
        if ([state isEqualToString:@"j"]) {
            [_refuse setTitle:@"已拒绝" forState:UIControlStateNormal];
            [self changeLeft];
        }else if ([state isEqualToString:@"t"]){
            [_refuse setTitle:@"已同意" forState:UIControlStateNormal];
            [self changeLeft];
        }
    }
}

-(void)changeLeft
{
    _agree.hidden=YES;
    _agree.userInteractionEnabled=NO;
    _refuse.userInteractionEnabled=NO;
}

-(JZDItem *)item
{
    return _item;
}

-(void)setItem:(JZDItem *)item
{
    _item=item;
    [_headImageButton setBackgroundImage:[UIImage circleImageWithName:_item.headImage borderWidth:0.1 borderColor:nil] forState:UIControlStateNormal];
    _nickName.text=item.nickName;
    _phoneNum.text=item.phoneNum;
    _qqOrWeChat.text=item.qqString;
    _describe.text=item.describeString;
//    _publishTime.text=item.sinceTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)agree:(UIButton *)sender {
    __weak JZDTakeInTableViewCell *wself=self;
    HSPAccount *user=[HSPAccountTool account];
    [request connectionRequestUrl:[NSString stringWithFormat:AgreeOrRefuse,user.user_id,group_id,request_id,@"t",user.userTokenid] withJSON:^(id responeJson) {
        if ([[responeJson objectForKey:@"code"] isEqualToString:@"0"]) {
            [wself changeLeft];
            [_refuse setTitle:@"已同意" forState:UIControlStateNormal];
        }else{
            JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
            [alert popAlert:[responeJson objectForKey:@"message"]];
        }
    }];
}

- (IBAction)refuse:(UIButton *)sender {
    __weak JZDTakeInTableViewCell *wself=self;
    HSPAccount *user=[HSPAccountTool account];
    [request connectionRequestUrl:[NSString stringWithFormat:AgreeOrRefuse,user.user_id,group_id,request_id,@"j",user.userTokenid] withJSON:^(id responeJson) {
        if ([[responeJson objectForKey:@"code"] isEqualToString:@"0"]) {
            [wself changeLeft];
            [_refuse setTitle:@"已拒绝" forState:UIControlStateNormal];
        }else{
            JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
            [alert popAlert:[responeJson objectForKey:@"message"]];
        }
    }];
}

@end
