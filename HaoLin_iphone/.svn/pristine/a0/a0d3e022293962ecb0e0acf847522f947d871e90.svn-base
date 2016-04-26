//
//  JZDTakeInViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-13.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//  参与发布的聚会同意列表

#import "JZDTakeInViewController.h"

@interface JZDTakeInViewController ()<UITableViewDataSource,UITableViewDelegate,JZDModuleHttpRequestDelegate>
{
    NSMutableArray *_data;
    JZDModuleHttpRequest *request;
    NSMutableArray *_btnStateArray;
}
@end

@implementation JZDTakeInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    for(UISegmentedControl *seg in self.navigationController.navigationBar.subviews){
        if ([seg isKindOfClass:[UISegmentedControl class]]) {
            [seg removeFromSuperview];
        }
    }
    self.title=@"详情";
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor=[UIColor orangeColor];
//    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"JZDletter_up@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.leftBarButtonItem=leftItem;
    self.navigationController.navigationBar.barTintColor=[UIColor redColor];
    _data=[[NSMutableArray alloc] init];
    _btnStateArray=[[NSMutableArray alloc] init];
    [self sendRequest];
}

-(void)back
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendRequest
{
    request=[JZDModuleHttpRequest sharedInstace];
    HSPAccount *user=[HSPAccountTool account];
    [request connectionRequestUrl:[NSString stringWithFormat:CheckAgreePetsParty,user.user_id,_thisUrl,@"1",user.userTokenid] withDelegate:self];
}

-(void)requestFinished:(id)responseObject
{
    [self addData:responseObject];
}

-(void)addData:(id)responseObject
{
//    YYLog(@"%@",responseObject);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
        if ([(NSArray *)[responseObject objectForKey:@"data"] count]) {
            for(NSDictionary *dic in [responseObject objectForKey:@"data"]){
                [defaults setObject:[dic objectForKey:@"request_relation"] forKey:@"btnState"];
                [defaults setObject:[dic objectForKey:@"request_id"] forKey:@"request_id"];
                [defaults setObject:[dic objectForKey:@"group_id"] forKey:@"group_id"];
                JZDItem *item=[[JZDItem alloc] init];
                __weak JZDItem *myItem=item;
                [request getImageUrl:[dic objectForKey:@"headurl"] withImage:^(UIImage *img) {
//                    myItem.headImage=img;
                    [_joinedInPetsTableView reloadData];
                }];
                item.nickName=[dic objectForKey:@"nickname"];
                item.phoneNum=[NSString stringWithFormat:@"%@",[dic objectForKey:@"request_tel"]];
                item.describeString=[NSString stringWithFormat:@"%@",[dic objectForKey:@"request_des"]];
                item.sinceTime=[dic objectForKey:@"request_addtime"];
                item.qqString=[NSString stringWithFormat:@"%@",[dic objectForKey:@"request_qq"]];
                [_data addObject:item];
            }
            [_joinedInPetsTableView reloadData];
        }else{
            [defaults setObject:@"" forKey:@"btnState"];
        }        
        [defaults synchronize];
    }else{
        JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
        [alert popAlert:[responseObject objectForKey:@"message"]];
        return;
    }
}

-(void)requestFailed:(NSError *)error
{
    JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    [alert popAlert:[error localizedDescription]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"cell";
    JZDTakeInTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"JZDTakeInTableViewCell" owner:self options:nil] lastObject];
    }
    [cell setItem:[_data objectAtIndex:indexPath.row]];
    return cell;
}

@end
