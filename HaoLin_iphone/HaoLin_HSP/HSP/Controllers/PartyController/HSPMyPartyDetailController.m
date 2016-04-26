//
//  HSPMyPartyDetailController.m
//  HaoLin
//
//  Created by PING on 14-8-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPMyPartyDetailController.h"

@interface HSPMyPartyDetailController () <UITableViewDataSource,UITableViewDelegate, JZDModuleHttpRequestDelegate>
{
    NSMutableArray *_data;
    JZDModuleHttpRequest *request;
    NSMutableArray *_btnStateArray;
    HSPAccount *account;
}
@end

@implementation HSPMyPartyDetailController

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
    for(UISegmentedControl *seg in self.navigationController.navigationBar.subviews){
        if ([seg isKindOfClass:[UISegmentedControl class]]) {
            [seg removeFromSuperview];
        }
    }
    _data=[[NSMutableArray alloc] init];
    _btnStateArray=[[NSMutableArray alloc] init];
    account = [HSPAccountTool account];
    [self sendRequest];
    
    self.title = @"报名详情";
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor, NSForegroundColorAttributeName, nil]];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"HSP_back_nom" highlightedImage:@"HSP_back_down" target:self action:@selector(back)];;
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)sendRequest
{
    request=[JZDModuleHttpRequest sharedInstace];
    [request connectionRequestUrl:[NSString stringWithFormat:CheckAgreeParty,account.user_id,_thisUrlGroupId,@"1",account.userTokenid] withDelegate:self];
}

-(void)requestFinished:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSError class]]) {
        return;
    }
    [self addData:responseObject];
}

-(void)addData:(id)responseObject
{
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
                    myItem.headImage=img;
                    [_myPartyDetailTableView reloadData];
                }];
                item.nickName=[dic objectForKey:@"nickname"];
                item.phoneNum=[NSString stringWithFormat:@"电话号:%@",[dic objectForKey:@"request_tel"]];
                item.describeString=[dic objectForKey:@"request_des"];
                item.sinceTime=[dic objectForKey:@"request_addtime"];
                item.qqString=[NSString stringWithFormat:@"QQ号:%@",[dic objectForKey:@"request_qq"]];
                [_data addObject:item];
            }
            [_myPartyDetailTableView reloadData];
        }else{
            [defaults setObject:@"" forKey:@"btnState"];
            JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
            [alert popAlert:@"还没有人报名哦"];
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
    return 147;
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