//
//  HSPOrderAllViewController.m
//  HaoLin
//
//  Created by PING on 14-9-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPOrderAllViewController.h"
#define HSPNumber 123

@interface HSPOrderAllViewController () <HSPSegmentedControlDelegate>
{
    NSInteger orderSegmentIndex;
    NSInteger page;
    NSInteger pageNavSegmentIndex;
}

@property (strong, nonatomic) HSPSegmentedControl *HSPSegmentedControl;

@property (nonatomic, strong) HSPHttpRequest *request;
@property (nonatomic, strong) NSMutableArray *arrayM;
@property (nonatomic, strong) NSMutableArray *goodsM;
@property (nonatomic, copy) NSString *voiceUrl;
@property (nonatomic, copy) NSString *tempPath;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *wavFilePath;

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSOperationQueue *queue;



@end

@implementation HSPOrderAllViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    page = 1;
    // nav 菜单
    if (orderSegmentIndex == 1) {
        [self createServiceSegmentedControl];
    }else{
        [self createOrderSegmentedControl];
    }
    
    // 发送请求
    [self setupRefresh];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear: animated];
//    // 设置界面
//    [self uiConfig];
//    
//}
//
//- (void)uiConfig
//{
//    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.barTintColor = HSPBgColor;
//    _tableView.backgroundColor = HSPBgColor;
//}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [_segmentedControl removeFromSuperview];
//    self.navigationController.navigationBar.barTintColor = HSPBarBgColor;
//}

// 实物导航
- (void)createOrderSegmentedControl
{
    self.HSPSegmentedControl = [[HSPSegmentedControl alloc] initWithOriginY:64 Titles:@[@"全部订单", @"待付款", @"待收货", @"已完成"] delegate:self] ;
    [self.view addSubview:_HSPSegmentedControl];
}

// 服务导航
- (void)createServiceSegmentedControl
{
    self.HSPSegmentedControl = [[HSPSegmentedControl alloc] initWithOriginY:64 Titles:@[@"全部服务", @"待服务", @"已服务"] delegate:self] ;
    [self.view addSubview:_HSPSegmentedControl];
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
    page = 1;
    [self.arrayM removeAllObjects];
    [self sendRequest:orderSegmentIndex+1 pageIndex:1 status:pageNavSegmentIndex];
    [self.tableView headerEndRefreshing];
}

- (void)footerRereshing
{
    page++;
    [self sendRequest:orderSegmentIndex+1 pageIndex:page status:pageNavSegmentIndex];
    [self.tableView footerEndRefreshing];
}

/*
 *  SegmentedControlDelegate 代理
 *
 */
- (void)HSPSegmentedControlSelectAtIndex:(NSInteger)index
{
    [self.arrayM removeAllObjects];
    [self.tableView reloadData];
    if (orderSegmentIndex == 1) {
        switch (index) {
            case 1:
                pageNavSegmentIndex = 7;
                break;
            case 2:
                pageNavSegmentIndex = 8;
                break;
                
            default:
                pageNavSegmentIndex = 0;
                break;
        }
    }else{
        switch (index) {
            case 1:
                pageNavSegmentIndex = 2;
                break;
            case 2:
                pageNavSegmentIndex = 4;
                break;
            case 3:
                pageNavSegmentIndex = 5;
                break;
                
            default:
                pageNavSegmentIndex = 0;
                break;
        }
    }
//    [self setupRefresh];
    [self sendRequest:orderSegmentIndex+1 pageIndex:1 status:pageNavSegmentIndex];
}

/**
 *  发送请求
 */
- (void)sendRequest:(NSInteger)index pageIndex:(NSInteger)pageIndex status:(NSInteger)status
{
    HSPAccount *account = [HSPAccountTool account];
    NSString *url =[NSString stringWithFormat:userOrderUrl,account.user_id,account.userTokenid,index,status,pageIndex];
    __weak JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    [self.request connectionRequestUrl:url withJSON:^(id responeJson) {
        if ([responeJson isKindOfClass:[NSError class]]) {
            [_tableView headerEndRefreshing];
            [alert popAlert:@"获取数据失败"];
            return;
        }
        //        YYLog(@"responeJson==%@",responeJson);
        if ([[responeJson objectForKey:@"code"] isEqualToString:@"0"] ) {
            if ([(NSArray *)[responeJson objectForKey:@"data"] count]) {
                for (NSDictionary *dict in [responeJson objectForKey:@"data"]) {
                    HSPOrder *order = [[HSPOrder alloc] init];
                    order = [HSPOrder objectWithKeyValues:dict];
                    
                    order.goodsM = [NSMutableArray array];
                    if ([(NSArray *)[dict objectForKey:@"goodsinfo"] count]) {
                        for (NSDictionary *dic in [dict objectForKey:@"goodsinfo"]) {
                            HSPGoods *goods = [[HSPGoods alloc] init];
                            goods = [HSPGoods objectWithKeyValues:dic];
                            [order.goodsM addObject:goods];
                        }
                    }
                    
                    if ([order.order_type isEqualToString:@"1"]) {
                        order.cellH = 183 + order.goodsM.count * 25;
                    }else{
                        order.cellH = 140 + order.goodsM.count * 25;
                    }
                    
                    [self.arrayM addObject:order];
                }
                [self.tableView reloadData];
            }
            
        }else if ([[responeJson objectForKey:@"code"] isEqualToString:@"1006"]){
            if (self.arrayM.count) {
                [alert popAlert:@"没有更多数据"];
            }else{
                [self.tableView reloadData];
                [alert popAlert:@"没有订单信息"];
            }
        }
    }];
    
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.arrayM.count == section + 1) {
        if (!is4Inch) {
            return 100;
        }else{
            return 15;
        }
    }else{
        return 15;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.arrayM.count > 0) {
        HSPOrder *order = self.arrayM[indexPath.section];
        return order.cellH;
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *orderIdentifier = @"orderIdentifier";
    HSPOrderAllCell *cell = [tableView dequeueReusableCellWithIdentifier:orderIdentifier];
    if (!cell) {
        cell = [[HSPOrderAllCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderIdentifier];
    }
    
    // 防止cell重用
    if (self.arrayM.count) {
        [self clearCell:cell];
        cell.order = self.arrayM[indexPath.section];
    }
    
    cell.confirmBtn.tag = [cell.order.order_id intValue];
    [cell.confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.voiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.voiceBtn.tag = indexPath.section + HSPNumber;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSPOrder *order = self.arrayM[indexPath.section];
    HSPOrderWaitingReceiveController *ratingVc = [[HSPOrderWaitingReceiveController alloc] initWithNibName:@"HSPOrderWaitingReceiveController" bundle:nil];
    ratingVc.orderId = [order.order_id intValue];
    [self.navigationController pushViewController:ratingVc animated:YES];
}


/**
 *  播放声音声音
 *
 */
- (void)voiceBtnClick:(UIButton *)btn
{
    HSPOrder *order = self.arrayM[btn.tag - HSPNumber];
    if ([order.order_audio hasSuffix:@".amr" ]) {
        [self downloadFile:order.order_audio]; // http://localhost/voice.amr
    }else{
        JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
        [alert popAlert:@"没有声音信息"];
    }
    
}

/**
 *  文件下载
 *
 *  @param urlStr 文件地址
 */
- (void)downloadFile:(NSString *)urlStr
{
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            self.tempPath = NSTemporaryDirectory();
            self.filePath = [self.tempPath stringByAppendingPathComponent:response.suggestedFilename];
            NSURL *fileURL = [NSURL fileURLWithPath:self.filePath];
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:fileURL error:NULL];
            
            // amr转wav
            self.wavFilePath=[self.filePath stringByReplacingOccurrencesOfString:@"amr" withString:@"wav"];
            [MQLAudioManage encodeToWav:self.wavFilePath fromAmr:self.filePath];
            // 播放音频
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.wavFilePath] error:nil];
                [self.player play];
            }];
        }
        
    }] resume];
}

- (void)confirmBtnClick:(UIButton *)btn
{
    
    HSPAccount *account = [HSPAccountTool account];
    NSString *url = [NSString stringWithFormat:orderDetailUrl,account.user_id,account.userTokenid,btn.tag];
    [self.request connectionRequestUrl:url withJSON:^(id responeJson) {
        YYLog(@"==%@",responeJson);
        if ([[responeJson objectForKey:@"code"] isEqualToString:@"0"]) {
            NSInteger statusIndex = [[[responeJson objectForKey:@"data"] objectForKey:@"status"] intValue];
            
            // 实物类（2.待付款，4.待收货，5.已收货）服务类（7.待服务，8.已服务）
            // 跳转相应页面
            switch (statusIndex) {
                case 2:
                    [self orderWaitingController:btn.tag];
                    break;
                case 4:
                    [self orderWaitingController:btn.tag];
                    break;
                case 5:
                    [self orderRatingController:btn.tag];
                    break;
                case 7:
                    [self orderWaitingController:btn.tag];
                    break;
                case 8:
                    [self orderRatingController:btn.tag];
                    break;
                    
                default:
                    break;
            }
            
            return;
        }
        
    }];
}

- (void)orderPayViewController:(NSInteger)orderId
{
    HSPOrderPayViewController *payVc = [[HSPOrderPayViewController alloc] initWithNibName:@"HSPOrderPayViewController" bundle:nil];
    payVc.orderId = orderId;
    [self.navigationController pushViewController:payVc animated:YES];
}

- (void)orderWaitingController:(NSInteger)orderId
{
    HSPOrderWaitingReceiveController *waitVc = [[HSPOrderWaitingReceiveController alloc] initWithNibName:@"HSPOrderWaitingReceiveController" bundle:nil];
    waitVc.orderId = orderId;
    waitVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:waitVc animated:YES];
}

- (void)orderRatingController:(NSInteger)orderId
{
    HSPRatingViewController *ratingVc = [[HSPRatingViewController alloc] initWithNibName:@"HSPRatingViewController" bundle:nil];
    ratingVc.orderId = orderId;
    ratingVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ratingVc animated:YES];
}

/**
 *  防止cell重用, 清除之前Label
 */
- (void)clearCell:(HSPOrderAllCell *)cell
{
    for (HSPOrderCreatedTimeView *v in cell.totalView.subviews) {
        if ([v isKindOfClass:[HSPOrderCreatedTimeView class]]) {
            v.createdTimeLabel.text = @"";
            v.orderTitle.text = @"";
        }
    }
    
    for (HSPOrderGoodsView *v in cell.goodsView.subviews) {
        if ([v isKindOfClass:[HSPOrderGoodsView class]]) {
            v.goodsNameLabel.text = @"";
            v.goodsCountLabel.text = @"";
            v.goodsPriceLabel.text = @"";
            v.goodsCountTitle.text = @"";
        }
    }
    
    for (HSPServiceCountView *v in cell.goodsView.subviews) {
        if ([v isKindOfClass:[HSPServiceCountView class]]) {
            v.totalPrice.text = @"";
            v.servicePrice.text = @"";
            v.serviceTitle.text = @"";
            v.totalTitle.text = @"";
            [v.actionBtn removeFromSuperview];
        }
    }
    
    for (HSPOrderCountView *v in cell.totalView.subviews) {
        if ([v isKindOfClass:[HSPOrderCountView class]]) {
            v.totalPrice.text = @"";
            v.servicePrice.text = @"";
            v.serviceTitle.text = @"";
            v.totalTitle.text = @"";
            
        }
    }
    
    for (HSPOrderStatusView *v in cell.bottomView.subviews) {
        if ([v isKindOfClass:[HSPOrderStatusView class]]) {
            v.statusLabel.text = @"";
            v.statusTitle.text = @"";
            [v.statusBtn removeFromSuperview];
        }
    }
}

/**
 *  切换实物和服务页面
 *
 */
- (IBAction)segmentedControlClick:(UISegmentedControl *)sender {
    
    [self.arrayM removeAllObjects];
    [self.tableView reloadData];
    orderSegmentIndex = sender.selectedSegmentIndex;
    [self viewDidLoad];
    // 发送请求
    [self setupRefresh];
    
}

#pragma mark - 懒加载
- (HSPHttpRequest *)request
{
    if (!_request) {
        _request = [[HSPHttpRequest alloc] init];
    }
    return _request;
}

- (NSMutableArray *)arrayM
{
    if (!_arrayM) _arrayM = [NSMutableArray array];
    return _arrayM;
}

- (NSMutableArray *)goodsM
{
    if (!_goodsM) _goodsM = [NSMutableArray array];
    return _goodsM;
}

- (NSOperationQueue *)queue
{
    if (!_queue) _queue = [[NSOperationQueue alloc] init];
    return _queue;
}

@end
