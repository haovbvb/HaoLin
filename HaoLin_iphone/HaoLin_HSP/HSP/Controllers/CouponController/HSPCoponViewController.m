//
//  HSPCoponViewController.m
//  HaoLin
//
//  Created by PING on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPCoponViewController.h"

@interface HSPCoponViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) HSPHttpRequest *request;
@property (nonatomic, strong) NSMutableArray *conponArray;
@property (nonatomic, assign) int page;


@end

@implementation HSPCoponViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupConfig];
    
    // 加载数据
    [self setupRefresh];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"HSP_back_nom" highlightedImage:@"HSP_back_down" target:self action:@selector(back)];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    _page = 1;
    [self setupData:_page];
    
    [self.tableView headerEndRefreshing];
}

- (void)footerRereshing
{
    _page++;
    [self setupData:_page];
    [self.tableView footerEndRefreshing]; 
}

- (void)setupData:(int)pageIndex
{
    HSPAccount *account = [HSPAccountTool account];
    NSString *url = [NSString stringWithFormat:conponListUrl,account.user_id,account.userTokenid,pageIndex];
    [self.request connectionRequestUrl:url withJSON:^(id responeJson) {
        if ([responeJson isKindOfClass:[NSError class]]) {
            [self.tableView headerEndRefreshing];
            return;
        }
        if ([[responeJson objectForKey:@"code"] isEqualToString:@"0"] && [(NSArray *)[responeJson objectForKey:@"data"] count]) {
            for (NSDictionary *dict in [responeJson objectForKey:@"data"]) {
                HSPConpon *conpon = [HSPConpon objectWithKeyValues:dict];
                [self.conponArray addObject:conpon];
            }
            [self.tableView reloadData];
        }else{
            [self.tableView footerEndRefreshing];
            JZDCustomAlertView *alert = [JZDCustomAlertView sharedInstace];
            [alert popAlert:@"已是最后一条数据"];
            return;
        }
    }];
}


- (void)setupConfig
{
    self.title = @"我的代金劵";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addConpon)];
    [rightItem setTintColor:HSPFontColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor,NSForegroundColorAttributeName, nil]];
    self.tableView.rowHeight = 110;
    self.tableView.backgroundColor = HSPBgColor;
    
}


/**
 *  添加代金劵
 */
- (void)addConpon
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"代金劵密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *textField = [alertView textFieldAtIndex:0].text;
    if (buttonIndex == 0) {
        if (textField.length) {
            [self requestConponActivate:textField];
        }
        
    }
}

- (void)requestConponActivate:(NSString *)TextField
{
    HSPAccount *account = [HSPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = account.user_id;
    params[@"tokenid"] = account.userTokenid;
    params[@"coupon_code"] = TextField;
    [self.request connectionREquesturl:conponActivateUrl withPostDatas:params withDelegate:nil withBackBlock:^(id backDictionary) {
        
        JZDCustomAlertView *alertView = [[JZDCustomAlertView alloc] init];
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"1020"]) {
            [alertView popAlert:@"激活失败"];
        }else if([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]){
            [alertView popAlert:@"激活成功"];
            [self.tableView reloadData];
        }
        
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conponArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *conponId = @"conponId";
    HSPConponCell *cell = [tableView dequeueReusableCellWithIdentifier:conponId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HSPConponCell" owner:self options:nil] lastObject];
    }
    cell.conpon = self.conponArray[indexPath.row];
    return cell;
}


#pragma mark - 懒加载
- (HSPHttpRequest *)request
{
    if (!_request) {
        _request = [HSPHttpRequest Instace];
    }
    return _request;
}

- (NSMutableArray *)conponArray
{
    if (!_conponArray) _conponArray = [NSMutableArray array];
    return _conponArray;
}
@end
