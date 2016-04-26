//
//  HSPMessageCenterViewController.m
//  HaoLin
//
//  Created by PING on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPMessageCenterViewController.h"

@interface HSPMessageCenterViewController ()

@property (strong, nonatomic) IBOutlet UISegmentedControl *navSegment;
@property (nonatomic, strong) HSPHttpRequest *request;
@property (nonatomic, strong) NSMutableArray *msgArray;
@property (nonatomic, assign) int page;

@end

@implementation HSPMessageCenterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
//    _navSegment.frame = CGRectMake(80.0f, 8.0f, 150.0f, 30.0f);
//    [self.navigationController.navigationBar addSubview:_navSegment];
//    self.navigationController.navigationBar.barTintColor = HSPBgColor;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navSegment removeFromSuperview];
//    self.navigationController.navigationBar.barTintColor = HSPBarBgColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"消息中心";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor,NSForegroundColorAttributeName, nil]];
    self.tableView.backgroundColor = HSPBgColor;
    self.tableView.rowHeight = 100;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"HSP_back_nom" highlightedImage:@"HSP_back_down" target:self action:@selector(back)];
    
    [self setupRefresh];
}

- (void)back
{
    if (self.navigationController.viewControllers.count > 1 ) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
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
    __weak JZDCustomAlertView *alert = [JZDCustomAlertView sharedInstace];
    HSPAccount *account = [HSPAccountTool account];
    NSString *url = [NSString stringWithFormat:messageListUrl,account.user_id,account.userTokenid,pageIndex];
    [self.request connectionRequestUrl:url withJSON:^(id responeJson) {
        if ([responeJson isKindOfClass:[NSError class]]) {
            [self.tableView headerEndRefreshing];
            [alert popAlert:@"获取数据失败"];
            return;
        }
        if ([[responeJson objectForKey:@"code"] isEqualToString:@"0"] && [(NSArray *)[responeJson objectForKey:@"data"] count]) {
            for (NSDictionary *dict in [responeJson objectForKey:@"data"]) {
                HSPMessage *message = [HSPMessage objectWithKeyValues:dict];
                [self.msgArray addObject:message];
            }
            [self.tableView reloadData];
        }else{
            [self.tableView footerEndRefreshing];
            if (self.msgArray.count) {
                [alert popAlert:@"没有更多数据"];
            }else{
                [alert popAlert:@"没有消息"];
            }
            return;
        }
    }];
}


#pragma mark - tabeViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.msgArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *messageId = @"messageId";
    HSPMessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:messageId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HSPMessageCenterCell" owner:self options:nil] lastObject];
    }
    
    cell.message = self.msgArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYPInformationObject *message = self.msgArray[indexPath.row];
    
    //  下个界面
    HSPMessageDetaildController *detailInfoVC = [[HSPMessageDetaildController alloc] initWithNibName:@"HSPMessageDetaildController" bundle:nil];
    //  传递信息给下个界面
    detailInfoVC.infoObject = message;
//    [self presentViewController:detailInfoVC animated:YES completion:nil];
    [self.navigationController pushViewController:detailInfoVC animated:YES];
    
    //  改变信息状态
    [self changeState:message.message_id];
}
//  改变信息状态，将未读标记为已读
- (void)changeState:(NSString *)messageID
{
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *accout = [HSPAccountTool account];
    NSString *urlStr = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&message_id=%@",markInformation,accout.user_id,accout.userTokenid,messageID];
    [manger connectWithUrlString:urlStr completion:^(id responedObject) {
        
    }];
}


#pragma mark - 懒加载
- (HSPHttpRequest *)request
{
    if (!_request) {
        _request = [HSPHttpRequest Instace];
    }
    return _request;
}

- (NSMutableArray *)msgArray
{
    if (!_msgArray) _msgArray = [NSMutableArray array];
    return _msgArray;
}

@end
