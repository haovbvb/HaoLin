//
//  JZDPetsActivityViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDPetsActivityViewController.h"
#define Hunder 100
@interface JZDPetsActivityViewController ()<UITableViewDelegate,UITableViewDataSource,JZDModuleHttpRequestDelegate>
{
    NSMutableArray *_data;
    NSMutableArray *_deatilArray;
    NSMutableArray *_groupIdArray;
    NSMutableArray *_outOfdute;
    JZDModuleHttpRequest *request;
    JZDDistance *distance;
    __block int page;
}
@end

@implementation JZDPetsActivityViewController
-(void)dealloc
{
    _data=nil;
    _deatilArray=nil;
    _groupIdArray=nil;
    _outOfdute=nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    page=1;
    distance=[[JZDDistance alloc] init];
    _data=[[NSMutableArray alloc] init];
    _deatilArray=[[NSMutableArray alloc] init];
    _groupIdArray=[[NSMutableArray alloc] init];
    _outOfdute=[[NSMutableArray alloc] init];
    request=[JZDModuleHttpRequest sharedInstace];
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [MBProgressHUD showHUDAddedTo:win animated:YES];
    [self uiconfig];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hide" object:@"hide"];
}

-(void)uiconfig
{
    [_activityTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新(一进入程序就下拉刷新)
    [_activityTableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_activityTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(void)headerRereshing
{
    page=1;
    __weak JZDPetsActivityViewController *wself=self;
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    [request connectionRequestUrl:[NSString stringWithFormat:PetsPartyListUrl,1] withJSON:^(id responeJson) {
        [_deatilArray removeAllObjects];
        [_data removeAllObjects];
        [wself addData:responeJson];
        [MBProgressHUD hideAllHUDsForView:win animated:YES];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_activityTableView reloadData];
    });
}

-(void)footerRereshing
{
    page++;
    __weak JZDPetsActivityViewController *wself=self;
    __weak JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    [request connectionRequestUrl:[NSString stringWithFormat:PetsPartyListUrl,page] withJSON:^(id responeJson) {
        if (![(NSArray *)[responeJson objectForKey:@"data"] count]) {
            [alert popAlert:@"已经是最后一条数据"];
        }
        [wself addData:responeJson];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_activityTableView reloadData];
    });
}

-(void)addData:(id)responseObject
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (![responseObject isKindOfClass:[NSError class]]) {
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]&&[(NSArray *)[responseObject objectForKey:@"data"] count]) {
            for(NSDictionary *dic in [responseObject objectForKey:@"data"]){
                [_groupIdArray addObject:[dic objectForKey:@"group_id"]];
                [_deatilArray addObject:[dic objectForKey:@"url"]];
                NSString *str=[[[NSMutableString stringWithFormat:@"%@",[dic objectForKey:@"url"]] componentsSeparatedByString:@"&id"] objectAtIndex:0];
                
                [_outOfdute addObject:[dic objectForKey:@"group_overdue"]];
                JZDItem *item=[[JZDItem alloc] init];
                item.doSomeThing=[dic objectForKey:@"group_subject"];
                item.location=[dic objectForKey:@"group_address"];
                item.farAway=[dic objectForKey:@"group_coord"];
                item.nickName=[dic objectForKey:@"nickname"];
                item.boyOrGirl=[dic objectForKey:@"gender"];
                __weak JZDItem *myItem=item;
                [request getImageUrl:[dic objectForKey:@"headurl"] withImage:^(UIImage *img) {
                    myItem.headImage=img;
                    [_activityTableView reloadData];
                }];
#pragma mark --计算--
//                if ([[dic objectForKey:@"group_jingdu_coord"] isEqualToString:NoWay]) {
//                    item.disTance=1.0;
//                }else{
                item.disTance=[distance jingdu:[dic objectForKey:@"group_jingdu_coord"] withWeidu:[dic objectForKey:@"group_weidu_coord"]];
//                }
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                [defaults setObject:str forKey:@"url"];
                [defaults synchronize];
                item.timeForNow=[dic objectForKey:@"group_addtime"];
                item.timeForStart=[dic objectForKey:@"group_partytime"];
                item.numberOfPeople=[dic objectForKey:@"group_man_num"];
                item.partyDescribe=[dic objectForKey:@"group_content"];
                [_data addObject:item];
            }
            [defaults setObject:_groupIdArray forKey:@"group_id"];
            [defaults synchronize];
        }
    }
    [_activityTableView headerEndRefreshing];
    [_activityTableView footerEndRefreshing];
}

-(void)requestFinished:(id)responseObject
{
}

-(void)requestFailed:(NSError *)error
{
    //请求超时的时候会打印error
    JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    [alert popAlert:[error localizedDescription]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"cell";
    JZDPartyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"JZDPartyTableViewCell" owner:self options:nil] lastObject];
    }
    cell.jumpButton.tag=indexPath.row+Hunder;
    [cell.jumpButton addTarget:self action:@selector(jumpDetail:) forControlEvents:UIControlEventTouchUpInside];
    [cell setItem:[_data objectAtIndex:indexPath.row]];
    return cell;
}
#pragma mark --跳转--
-(void)jumpDetail:(UIButton *)btn
{
    PetsDetailViewController *detail=[[PetsDetailViewController alloc] initWithNibName:@"PetsDetailViewController" bundle:nil];
    detail.outOfDute=_outOfdute[btn.tag-Hunder];
    detail.farAwayString=[(JZDItem *)[_data objectAtIndex:btn.tag-Hunder] disTance];
    detail.groupId=[_groupIdArray objectAtIndex:btn.tag-Hunder];
    detail.thisUrl=[_deatilArray objectAtIndex:btn.tag-Hunder];
    JZDNavgationViewController *nav=[[JZDNavgationViewController alloc] initWithNavigationBarClass:[JZDNavgationBar class] toolbarClass:nil];
    nav.viewControllers=@[detail];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
//    [self.navigationController pushViewController:detail animated:YES];
}

@end
