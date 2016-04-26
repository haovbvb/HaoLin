//
//  ZYPMyRemainVC.m
//  HaoLin
//
//  Created by mac on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPMyRemainVC.h"

@interface ZYPMyRemainVC ()<UIAlertViewDelegate>

@end

@implementation ZYPMyRemainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //  添加观察者
    // Do any additional setup after loading the view from its nib.
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    self.titleLabel.backgroundColor = ZYPBGColor;

    [self getMyRemainMoney];
}
- (void)getMyRemainMoney
{
//    ZYPObjectManger *object = [ZYPObjectManger shareInstance];
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
//    //  真实数据
//    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&take_type=%@",myRemainM,object.loginInObject.user_id,object.loginInObject.tokenid,@"2"];
     NSString *urlString1 = @"http://t9.wxwork.cn/youlin/index.php?m=home&c=amount&a=acquireMemberMoneyInfo&user_id=14&tokenid=CABS918K1J14KJFS&take_type=2";
    [manger connectWithUrlString:urlString1 completion:^(id responedObject) {
        NSLog(@"%@",responedObject);
        if ([responedObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responedObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                NSDictionary *mDic = [dic objectForKey:@"data"];
                NSString *money = [mDic objectForKey:@"amount"];
                self.cashLabel.text = money;
                if ([self.cashLabel.text length] == 0)
                {
//  真实
//                    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"您的账户暂无余额，请充值" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alert show];
                }
            }
        }
    }];
}
#pragma mark - 代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//  返回
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//  进入下一步
- (IBAction)commit:(id)sender
{
    ZYPCommitCashVC *commit = [[ZYPCommitCashVC alloc] initWithNibName:@"ZYPCommitCashVC" bundle:nil];
    [self.navigationController pushViewController:commit animated:YES];
    [self commitM];
}
- (void)commitM
{
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    
    //    ZYPObjectManger *object = [ZYPObjectManger shareInstance];
    //    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&take_type=%@",cashM,object.loginInObject.user_id,object.loginInObject.tokenid,@"2"];
    NSString *urlString = @"http://t9.wxwork.cn/youlin/index.php?m=home&c=amount&a=checkMemberIsMoney&user_id=14&tokenid=CABS918K1J14KJFS&take_type=2";
    [manger connectWithUrlString:urlString completion:^(id responedObject) {
        if ([responedObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = responedObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"])
            {
                NSDictionary *dic1 = [dic objectForKey:@"data"];
                NSString *minM = [dic1 objectForKey:@"take_min"];
                // NSString *maxM = [dic1 objectForKey:@"take_max"];
                if ([self.cashLabel.text intValue] > [minM intValue])
                {
                    ZYPCommitCashVC *commit = [[ZYPCommitCashVC alloc] initWithNibName:@"ZYPCommitCashVC" bundle:nil];
                    [self.navigationController pushViewController:commit animated:YES];
                }
            }else
            {
                if ([[dic objectForKey:@"code"] isEqualToString:@"-2"])
                {
                    [self alertWithMessage:[dic objectForKey:@"message"]];
                }else if ([[dic objectForKey:@"code"] isEqualToString:@"1138"])
                {
                    [self alertWithMessage:[dic objectForKey:@"message"]];
                }else if ([[dic objectForKey:@"code"] isEqualToString:@"1139"])
                {
                    [self alertWithMessage:[dic objectForKey:@"message"]];
                }else if ([[dic objectForKey:@"code"] isEqualToString:@"1140"])
                {
                    [self alertWithMessage:[dic objectForKey:@"message"]];
                }else if ([[dic objectForKey:@"code"] isEqualToString:@"1141"])
                {
                    [self alertWithMessage:[dic objectForKey:@"message"]];
                }
            }
        }
     }];
 }
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
