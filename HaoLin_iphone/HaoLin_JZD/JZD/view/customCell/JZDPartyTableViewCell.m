//
//  JZDPartyTableViewCell.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDPartyTableViewCell.h"

@implementation JZDPartyTableViewCell
@synthesize item=_item;

-(void)dealloc
{
    _item=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)awakeFromNib
{
    // Initialization code
    self.refuseOrAgree.hidden=YES;
    _locationUser.delegate=self;
    _locationUser.buttonImageRect=CGRectMake(10, 12, 10, 10);
    _locationUser.buttonTitleRect=CGRectMake(25, 5, 80, 25);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide:) name:@"hide" object:nil];
}

-(void)hide:(NSNotification *)not
{
    if ([not.object isEqualToString:@"hide"]) {
        self.refuseOrAgree.hidden=YES;
    }else{
        self.refuseOrAgree.hidden=NO;
    }
}

-(JZDItem *)item
{
    return _item;
}

-(void)clear
{
    _headImageView.image=nil;
    _nickName.text=@"";
    [_locationUser setTitle:@"" forState:UIControlStateNormal];
    _timeForNow.text=@"";
    _location.text=@"";
    _details.text=@"";
    _numPeople.text=@"";
    _doSomeThing.text=@"";
}

-(void)setItem:(JZDItem *)item
{
    if (_item!=item) {
        _item=item;
    }
    _boyOrGirl=item.boyOrGirl;
    if ([_boyOrGirl isEqualToString:@"1"]) {
        _userSex.image=[UIImage imageNamed:@"JZD_male.png"];
    }else{
        _userSex.image=[UIImage imageNamed:@"JZD_female.png"];
    }
    _headImageView.image=[UIImage circleImageWithName:_item.headImage borderWidth:0.1 borderColor:nil];
    _nickName.text=_item.nickName;
    if (item.disTance==1.0) {
        [_locationUser setTitle:@"未知" forState:UIControlStateNormal];
    }else{
        NSString *distance=[NSString stringWithFormat:@"%.2fkm",item.disTance/1000.00];
        [_locationUser setTitle:distance forState:UIControlStateNormal];
    }
    _timeForNow.text=_item.timeForStart;
    _location.text=_item.location;
    NSString *str=(_item.partyDescribe.length>0)?_item.partyDescribe:@"这家伙很懒，什么也没留下";
    _details.text=str;
    NSString *j_s_t;
    if ([item.j_s_t isEqualToString:@"t"]) {
        j_s_t=@"已同意";
    }else if ([item.j_s_t isEqualToString:@"j"]){
        j_s_t=@"已拒绝";
    }else{
        j_s_t=@"审核中";
    }
    _refuseOrAgree.text=j_s_t;
    _numPeople.text=_item.numberOfPeople;
    _doSomeThing.text=_item.doSomeThing;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
