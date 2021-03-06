//
//  JZDPartyAddView.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDPartyAddView.h"
#define hunder 100

@interface JZDPartyAddView ()<JZDModuleHttpRequestDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *_data;
    NSMutableArray *_deatilArray;
    NSMutableArray *_groupIdArray;
    JZDModuleHttpRequest *request;
    NSMutableString *_currentUrlStr;
    NSMutableArray *_outOfdute;
    JZDDistance *distance;
    int _hotType;
    __block int page;
}

@end

@implementation JZDPartyAddView
-(void)dealloc
{
    _data=nil;
    _deatilArray=nil;
    _groupIdArray=nil;
    _outOfdute=nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hide" object:@"hide"];
}

-(void)awakeFromNib
{
    
    _partTableView.delegate=self;
    _partTableView.dataSource=self;
    distance = [[JZDDistance alloc] init];
    _data=[[NSMutableArray alloc] init];
    _deatilArray=[[NSMutableArray alloc] init];
    _groupIdArray = [[NSMutableArray alloc] init];
    _outOfdute=[[NSMutableArray alloc] init];

    _hotType = 0;
    request=[JZDModuleHttpRequest sharedInstace];
    
    // 添加数据
    [_partTableView headerBeginRefreshing];
    [self segClick:_partySelect];
    
}


- (void)setupData:(NSInteger)hotType
{
    _hotType = hotType;
    _currentUrlStr = nil;
    if (page == 0) {
        _currentUrlStr = [NSMutableString stringWithFormat:partyListUrl,hotType,1];
    }else{
        _currentUrlStr = [NSMutableString stringWithFormat:partyListUrl,hotType,page];
    }
    
    [_partTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新(一进入程序就下拉刷新)
    [_partTableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_partTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
// 下拉刷新
- (void)headerRereshing
{
    page = 1;
    __weak JZDPartyAddView *wself=self;
    [request connectionRequestUrl:_currentUrlStr withJSON:^(id responeJson) {
        [_data removeAllObjects];
        [_groupIdArray removeAllObjects];
        [_deatilArray removeAllObjects];
        [wself addData:responeJson];
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_partTableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_partTableView headerEndRefreshing];
    });
}
// 上拉刷新
- (void)footerRereshing
{
    
    page++;
    __weak JZDPartyAddView *wself=self;
    __weak JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    [request connectionRequestUrl:[NSString stringWithFormat:partyListUrl,_hotType,page] withJSON:^(id responeJson) {
//        YYLog(@"responeJson==%@",responeJson);
        if (![(NSArray *)[responeJson objectForKey:@"data"] count]) {
            [alert popAlert:@"已是最后一条数据"];
            return ;
        }
        [wself addData:responeJson];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_partTableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_partTableView footerEndRefreshing];
    });
    
    
}


-(void)addData:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSError class]]) {
        [_partTableView headerEndRefreshing];
        return;
    }
    //将数据添加到数组中
    if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]&&[(NSArray *)[responseObject objectForKey:@"data"] count]) {
        for(NSDictionary *dic in [responseObject objectForKey:@"data"]){
            //获取详情页的地址
            [_groupIdArray addObject:[dic objectForKey:@"group_id"]];
            
            NSString *str=[[[NSMutableString stringWithFormat:@"%@",[dic objectForKey:@"url"]] componentsSeparatedByString:@"&id"] objectAtIndex:0];
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:str forKey:@"urlParty"];
            [defaults synchronize];
            
            [_deatilArray addObject:[dic objectForKey:@"url"]];
            
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
                [_partTableView reloadData];
            }];
            item.disTance=[distance jingdu:[dic objectForKey:@"group_jingdu_coord"] withWeidu:[dic objectForKey:@"group_weidu_coord"]];
            item.timeForNow=[dic objectForKey:@"group_addtime"];
            item.timeForStart=[dic objectForKey:@"group_partytime"];
            item.numberOfPeople=[dic objectForKey:@"group_man_num"];
            item.partyDescribe=[dic objectForKey:@"group_content"];

            [_data addObject:item];
        }
    }
}

-(void)requestFinished:(id)responseObject
{
//    NSLog(@"%@",responseObject);
    
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
    cell.jumpButton.tag = indexPath.row + hunder;
    [cell.jumpButton addTarget:self action:@selector(goDetailParty:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell setItem:[_data objectAtIndex:indexPath.row]];
    return cell;
}
//根据button的不同tag读取不同的聚会详情
-(void)goDetailParty:(UIButton *)btn{
    JZDPartyDetailViewController *detail=[[JZDPartyDetailViewController alloc] initWithNibName:@"JZDPartyDetailViewController" bundle:nil];
    detail.farAwayString=[[_data objectAtIndex:btn.tag - hunder] disTance];
    detail.outOfDute=_outOfdute[btn.tag - hunder];
    detail.groupId = [_groupIdArray objectAtIndex:btn.tag - hunder];
    detail.thisUrl = [_deatilArray objectAtIndex:btn.tag - hunder];
    HSPNavigationController *nav=[[HSPNavigationController alloc] initWithRootViewController:detail];
    [_vc presentViewController:nav animated:YES completion:^{
        
    }];
    
}

- (IBAction)segClick:(UISegmentedControl *)sender {
    page = 0;

    [self setupData:sender.selectedSegmentIndex];
    
}
- (IBAction)leftButton:(UIButton *)sender {
    
    [_vc dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  UIAlertView 代理
 */

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        HSPLoginViewController *login=[[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
        HSPNavigationController *nav = [[HSPNavigationController alloc] initWithRootViewController:login];
        [_vc presentViewController:nav animated:YES completion:nil];
    }
}

//我发布的聚会/我参与的聚会
- (IBAction)rightButton:(UIButton *)sender {
    
    HSPAccount *user=[HSPAccountTool account];
    if (!user.userTokenid) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    JZDSPartyViewController *partyOfMe=[[JZDSPartyViewController alloc] initWithNibName:@"JZDSPartyViewController" bundle:nil];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:partyOfMe];
    [_vc presentViewController:nav animated:YES completion:nil];
}

//发布聚会
- (IBAction)publishPartyBtnClick:(UIButton *)sender {
    HSPAccount *user=[HSPAccountTool account];
    if (!user.userTokenid) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    
    JZDPublishViewController *publish=[[JZDPublishViewController alloc] initWithNibName:@"JZDPublishViewController" bundle:nil];
    publish.partyOrPets=YES;
    publish.typeString = @"2";
    HSPNavigationController *nav=[[HSPNavigationController alloc] initWithRootViewController:publish];
    [_vc presentViewController:nav animated:YES completion:^{
        
    }];
}

@end
