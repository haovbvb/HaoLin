//
//  JZDsPetsPartyViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDsPetsPartyViewController.h"
#define HunderPet 100
@interface JZDsPetsPartyViewController ()<UITableViewDelegate,UITableViewDataSource,JZDModuleHttpRequestDelegate>
{
    JZDModuleHttpRequest *request;
    NSMutableArray *_deatilArray;
    NSMutableArray *_data;
    __block int page;
    double farWary;
    JZDDistance *distance;
}
@end

@implementation JZDsPetsPartyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    return self;
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    page=1;
    _deatilArray=[[NSMutableArray alloc] init];
    _data=[[NSMutableArray alloc] init];
    distance=[[JZDDistance alloc] init];
//    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:255.0 green:75.0 blue:0 alpha:1];
    [self uiconfig];
    [self sendRequest];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.navBarSegment.selectedSegmentIndex==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hide" object:@"hide"];
    }
}

-(void)sendRequest
{
    request=[JZDModuleHttpRequest sharedInstace];
}

-(void)requestFinished:(id)responseObject
{
    [self addData:responseObject];
}

-(void)addData:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSError class]]) {
        return;
    }
    if ([[responseObject objectForKey:@"code"] isEqualToString:@"-4"]) {
        JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
        [alert popAlert:@"可能您的帐号重复登录,请重新登录"];
        return;
    }
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]&&[(NSArray *)[responseObject objectForKey:@"data"] count]) {
        for(NSDictionary *dic in [responseObject objectForKey:@"data"]){
            //获取详情页的group_id
            [_deatilArray addObject:[dic objectForKey:@"group_id"]];
            JZDItem *item=[[JZDItem alloc] init];
            item.doSomeThing=[dic objectForKey:@"group_subject"];
            item.location=[dic objectForKey:@"group_address"];
            item.farAway=[dic objectForKey:@"group_coord"];
            item.nickName=[dic objectForKey:@"nickname"];
            item.j_s_t=[dic objectForKey:@"request_relation"];
//            //请求图片
            __weak JZDItem *myItem=item;
            [request getImageUrl:[dic objectForKey:@"headurl"] withImage:^(UIImage *img) {
                myItem.headImage=img;
                [_myPetsPartyTableView reloadData];
            }];
            item.disTance=[distance jingdu:[dic objectForKey:@"group_jingdu_coord"] withWeidu:[dic objectForKey:@"group_weidu_coord"]];
            item.boyOrGirl=[dic objectForKey:@"gender"];
            item.timeForNow=[dic objectForKey:@"group_addtime"];
            item.timeForStart=[dic objectForKey:@"group_partytime"];
            item.numberOfPeople=[dic objectForKey:@"group_man_num"];
            item.partyDescribe=[dic objectForKey:@"group_content"];
            [_data addObject:item];
        }
        [_myPetsPartyTableView reloadData];
    }
}

-(void)requestFailed:(NSError *)error
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor=nil;
    _navBarSegment.frame=CGRectMake(70, 5, 180, 30);
    [self.navigationController.navigationBar addSubview:_navBarSegment];
}

-(void)uiconfig
{
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    [_myPetsPartyTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新(一进入程序就下拉刷新)
    [_myPetsPartyTableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_myPetsPartyTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(void)headerRereshing
{
    HSPAccount *user=[HSPAccountTool account];
    __weak JZDsPetsPartyViewController *wself=self;
    if (_navBarSegment.selectedSegmentIndex==0) {
        [request connectionRequestUrl:[NSString stringWithFormat:PetsOfMain,user.user_id,1,user.userTokenid] withJSON:^(id responeJson) {
            [_data removeAllObjects];
            [wself addData:responeJson];
        }];
    }else{
        [request connectionRequestUrl:[NSString stringWithFormat:PetsOfMeApply,user.user_id,1,user.userTokenid] withJSON:^(id responeJson) {
            [_data removeAllObjects];
            [wself addData:responeJson];
        }];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_myPetsPartyTableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_myPetsPartyTableView headerEndRefreshing];
    });
}

-(void)footerRereshing
{
    HSPAccount *user=[HSPAccountTool account];
    page++;
    __weak JZDsPetsPartyViewController *wself=self;
    if (_navBarSegment.selectedSegmentIndex==0) {
        [request connectionRequestUrl:[NSString stringWithFormat:PetsOfMain,user.user_id,page,user.userTokenid] withJSON:^(id responeJson) {
            if (responeJson) {
                [wself addData:responeJson];
            }else{
                [wself popAlert:responeJson];
            }
        }];
    }else{
        [request connectionRequestUrl:[NSString stringWithFormat:PetsOfMeApply,user.user_id,page,user.userTokenid] withJSON:^(id responeJson) {
            if (responeJson) {
                [wself addData:responeJson];
            }else{
                [wself popAlert:responeJson];
            }
        }];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_myPetsPartyTableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_myPetsPartyTableView footerEndRefreshing];
    });
}

-(void)popAlert:(id)responeJson
{
    __weak JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    if ([(NSArray *)[responeJson objectForKey:@"data"] count]) {
        [alert popAlert:@"没有更多内容"];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"cell";
    JZDPartyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"JZDPartyTableViewCell" owner:self options:nil] lastObject];
    }
    cell.jumpButton.tag=indexPath.row+HunderPet;
    [cell.jumpButton addTarget:self action:@selector(pushTakeInPetsParty:) forControlEvents:UIControlEventTouchUpInside];
    [cell setItem:[_data objectAtIndex:indexPath.row]];
    return cell;
}

-(void)pushTakeInPetsParty:(UIButton *)btn
{
    if (_navBarSegment.selectedSegmentIndex==0) {
        JZDTakeInViewController *takeInPetsParty=[[JZDTakeInViewController alloc] initWithNibName:@"JZDTakeInViewController" bundle:nil];
        JZDNavgationViewController *nav=[[JZDNavgationViewController alloc] initWithNavigationBarClass:[JZDNavgationBar class] toolbarClass:nil];
        nav.viewControllers=@[takeInPetsParty];
        takeInPetsParty.thisUrl=[_deatilArray objectAtIndex:(btn.tag-HunderPet)];
//        [self.navigationController pushViewController:takeInPetsParty animated:YES];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        PetsDetailViewController *pet=[[PetsDetailViewController alloc] initWithNibName:NSStringFromClass([PetsDetailViewController class]) bundle:nil];
        /*
         detail.farAwayString=[(JZDItem *)[_data objectAtIndex:btn.tag-Hunder] disTance];
         detail.groupId=[_groupIdArray objectAtIndex:btn.tag-Hunder];
         detail.thisUrl=[_deatilArray objectAtIndex:btn.tag-Hunder];
         */
        pet.farAwayString=[(JZDItem *)[_data objectAtIndex:btn.tag-HunderPet] disTance];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *detailUrl=[defaults objectForKey:@"url"];
        pet.groupId=[_deatilArray objectAtIndex:btn.tag-HunderPet];
        pet.thisUrl=[NSString stringWithFormat:@"%@&id=%@",detailUrl,[_deatilArray objectAtIndex:(btn.tag-HunderPet)]];
        JZDNavgationViewController *nav=[[JZDNavgationViewController alloc] initWithNavigationBarClass:[JZDNavgationBar class] toolbarClass:nil];
        nav.viewControllers=@[pet];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (IBAction)myPartySelect:(UISegmentedControl *)sender {
    [_deatilArray removeAllObjects];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HSPAccount *user=[HSPAccountTool account];
    __weak JZDsPetsPartyViewController *wself=self;
    if (sender.selectedSegmentIndex==1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hide" object:@"hhhh"];
        [request connectionRequestUrl:[NSString stringWithFormat:PetsOfMeApply,user.user_id,1,user.userTokenid] withJSON:^(id responeJson) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [_data removeAllObjects];
            [_myPetsPartyTableView reloadData];
            [wself addData:responeJson];
        }];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hide" object:@"hide"];
        [request connectionRequestUrl:[NSString stringWithFormat:PetsOfMain,user.user_id,1,user.userTokenid] withJSON:^(id responeJson) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [_data removeAllObjects];
            [wself addData:responeJson];
        }];
    }
}

@end
