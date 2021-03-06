//
//  ZYPHomeView.m
//  HaoLin
//
//  Created by mac on 14-9-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPHomeView.h"





@interface ZYPHomeView ()
/**
 视图将要出现的时候
 */
- (void)viewWillAppear;
@end
@implementation ZYPHomeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib
{
    self.titleLabel.backgroundColor = ZYPBGColor;
    [self load];
    [self viewWillAppear];
}
- (void)load
{
    //  屏幕大小适配
    if (IS_IPHONE_5) {
        self.frame = CGRectMake(0, 0, 320, 519);
        self.tableView.frame = CGRectMake(0, 174, 320, 345);
    }else
    {
        self.frame = CGRectMake(0, 0, 320, 431);
        self.tableView.frame = CGRectMake(0, 174, 320, 257);
        
    }
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //  获取数据源
    [self source];
}


- (void)viewWillAppear
{
    HSPAccount *account = [HSPAccountTool account];
    if ([account.user_id length] > 0)
    {
        self.loginBtn.hidden = YES;
        [view removeFromSuperview];
        [self creatBottomView];
        [self creatLoginView];
    }else if ([account.user_id length]== 0)
    {
        self.loginBtn.hidden = NO;
        self.imageview.hidden = NO;
        [bottomView removeFromSuperview];
        [loginView1 removeFromSuperview];
        [self shefView];
    }
}
//  创建LoginView
- (void)creatLoginView
{
    HSPAccount *account = [HSPAccountTool account];
    loginView1 = [[[NSBundle mainBundle] loadNibNamed:@"ZYPLoginView" owner:self options:nil] lastObject];
    loginView1.frame = CGRectMake(0, 64, 320, 110);
    loginView1.backImageView.image = [UIImage imageNamed:@"HSP_bg_top@2x.PNG"];
    
    [loginView1.headerImageView setImageWithURL:[NSURL URLWithString:account.headimg] placeholderImage:[UIImage imageNamed:@"ZYPshop_default_avatar.png"]];
    loginView1.nameLabel.text = account.nickname;
    [self addSubview:loginView1];
    
}
//  创建bottomView
- (void)creatBottomView
{
    bottomView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPHomeBottomView" owner:self options:nil] lastObject];
    bottomView.homeView = self;
    self.tableView.tableFooterView =  bottomView;
}
//  未登录时的遮罩View
- (void)shefView
{
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.4;
    [self.tableView addSubview:view];
}
//  数据源
- (void)source
{
    NSArray *array2 = [NSArray arrayWithObjects:@"商户详情", nil];
    NSArray *array3 = [NSArray arrayWithObjects:@"我的货架",@"销售订单", nil];
    NSArray *array4 = [NSArray arrayWithObjects:@"系统消息", nil];
    self.allArray = [NSMutableArray arrayWithObjects:array2,array3,array4, nil];
    
}
//  跳入登陆界面
- (IBAction)loginIn:(id)sender
{
    HSPLoginViewController *loginVC = [[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"A" object:nil];
    [self.partVC presentViewController:loginVC animated:YES completion:nil];
}
//  退出登录
- (void)logoutInfo
{
    [self logout];
}
//  退出登陆方法
- (void)logout
{
    
    __weak ZYPHomeView *homeView = self;
    HSPAccount *account = [HSPAccountTool account];
    /**
     *  退出登录时，发送一个通知，告诉我的和订单界面已退出登录，在商家界面有观察者进行操作
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"A" object:nil];
    /**
     *  直接退出登录，不管请求数据没
     */
    [self shefView];
    [bottomView removeFromSuperview];
    // 清除用户信息
    [HSPAccountTool clearAccount:account];
    
    self.loginBtn.hidden = NO;
    self.imageview.hidden = NO;
    [bottomView removeFromSuperview];
    [loginView1 removeFromSuperview];
    //  标记退出状态
    [ZYPObjectManger shareInstance].state = 0;
    /**
     *  退出登录时，发送一个通知，告诉商家界面我已退出登录，在商家界面有观察者进行操作
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil userInfo:nil];
    
    [self alertWithMessage:@"退出成功"];
    
    //  退出登录后返回登陆界面
    HSPLoginViewController *loginVC = [[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
    [homeView.partVC presentViewController:loginVC animated:YES completion:nil];
    
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@",cancelLoginUrl,account.user_id,account.userTokenid];
    [manger connectWithUrlStr:urlString completion:^(id respondObject) {
        if ([respondObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = respondObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"])
            {
//                //  隐藏加载状态
//                [MBProgressHUD hideAllHUDsForView:homeView animated:YES];
//                [homeView shefView];
//                [bottomView removeFromSuperview];
//                [homeView alertWithMessage:[dic objectForKey:@"message"]];
//                //  退出登录后返回登陆界面
//                HSPLoginViewController *loginVC = [[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
//                [homeView.partVC presentViewController:loginVC animated:YES completion:nil];
//                
//                
//                // 清除用户信息
//                HSPAccount *account = [HSPAccountTool account];
//                [HSPAccountTool clearAccount:account];
//                
//                self.loginBtn.hidden = NO;
//                self.imageview.hidden = NO;
//                [bottomView removeFromSuperview];
//                [loginView1 removeFromSuperview];
//                [self shefView];
//                
//                //  标记退出状态
//                [ZYPObjectManger shareInstance].state = 0;
//                /**
//                 *  发送通知，商家界面
//                 */
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil userInfo:nil];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"log" object:nil userInfo:nil];
            }else
            {
                //  隐藏加载状态
                [MBProgressHUD hideAllHUDsForView:self animated:YES];
//                [self alertWithMessage:[dic objectForKey:@"message"]];
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
#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)[self.allArray objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifier";
    ZYPHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPHomeTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.font = [UIFont systemFontOfSize:17];
    cell.nameLabel.text = [[self.allArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section== 0)
    {
        return 10;
    }
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSPAccount *account = [HSPAccountTool account];
    if (account)
    {
        NSInteger sectionIndex = indexPath.section;
        NSInteger rowIndex = indexPath.row;
        //        if (sectionIndex == 0)
        //        {
        //            NSLog(@"0区0行");
        //            ZYPCompleteinfoVC *completionVC = [[ZYPCompleteinfoVC alloc] initWithNibName:@"ZYPCompleteinfoVC" bundle:nil];
        //            [self.navigationController pushViewController:completionVC animated:YES];
        //        }
        if (sectionIndex == 0)
        {
            NSLog(@"0区0行");
            //            ZYPBusinessDetailVC *detailVc = [[ZYPBusinessDetailVC alloc] initWithNibName:@"ZYPBusinessDetailVC" bundle:nil];
            //            [self.navigationController pushViewController:detailVc animated:YES];
            ZYPDetailBusinVC *detailVC = [[ZYPDetailBusinVC alloc] initWithNibName:@"ZYPDetailBusinVC" bundle:nil];
            [self.partVC.navigationController pushViewController:detailVC animated:YES];
        }else if (sectionIndex == 1)
        {
            switch (rowIndex) {
                case 0:
                {
                    NSLog(@"1区0行");
                    ZYPGoodsSheftViewController *goodsSheftVC = [[ZYPGoodsSheftViewController alloc] initWithNibName:@"ZYPGoodsSheftViewController" bundle:nil];
                    [self.partVC.navigationController pushViewController:goodsSheftVC animated:YES];
                }
                    break;
//                case 1:
//                {
//                    NSLog(@"1区1行");
//                    ZYPMyRemainVC *remainVC = [[ZYPMyRemainVC alloc] initWithNibName:@"ZYPMyRemainVC" bundle:nil];
//                    [self.partVC.navigationController pushViewController:remainVC animated:YES];
//                }
//                    break;
                case 1:
                {
                    NSLog(@"1区2行");
                    ZYPObjectManger *manger = [ZYPObjectManger shareInstance];
                    manger.barTitle = @"1";
                    if ([account.range_type intValue] == 1) {
                        ZYPBusinrssOrderViewController *order = [[ZYPBusinrssOrderViewController alloc] initWithNibName:@"ZYPBusinrssOrderViewController" bundle:nil];
                        [self.partVC.navigationController pushViewController:order animated:YES];
                    }else if ([account.range_type intValue] == 2)
                    {
                        ZYPServerViewController *serveVC = [[ZYPServerViewController alloc] initWithNibName:@"ZYPServerViewController" bundle:nil];
                        [self.partVC.navigationController pushViewController:serveVC animated:YES];
                    }
                }
                    break;
                default:
                    break;
            }
        }else if (sectionIndex == 2)
        {
            NSLog(@"3区0行");
            ZYPInformationViewCC *informationvc = [[ZYPInformationViewCC alloc] initWithNibName:@"ZYPInformationViewCC" bundle:nil];
            [self.partVC.navigationController pushViewController:informationvc animated:YES];
        }
    }
}

@end
