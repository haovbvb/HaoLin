//
//  ZYPBusinessListVC.m
//  HaoLin
//
//  Created by mac on 14-9-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPBusinessListVC.h"

@interface ZYPBusinessListVC ()
{
    CLLocation *_location;
    NSInteger page;
    UIButton *btn;
}
@property (nonatomic, strong)NSMutableArray *sourceArray;
@end

@implementation ZYPBusinessListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)refreashTableView:(UIButton *)btn1
{
    btn.hidden = YES;
    self.tableView.hidden = NO;
    
    [self refreshes];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(110, 200, 100, 100);
    [btn setBackgroundImage:[UIImage imageNamed:@"MDLrefresh"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(refreashTableView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.hidden = YES;
    page = 1;
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.backgroundColor = ZYPBGColor;
    self.sourceArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self refreshes];
}
//  刷新
-(void)refreshes
{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新(一进入程序就下拉刷新).
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
//下拉刷新
-(void)headerRereshing
{
    page = 1;
    [self performSelector:@selector(getSource) withObject:nil afterDelay:2];
}
//上拉加载
-(void)footerRereshing
{
    page++;
    [self performSelector:@selector(getSource) withObject:nil afterDelay:2];
}
//  获取当前位置信息，单例
- (void)getCurrentLocation
{
    MQLBMKMapManage *manger = [MQLBMKMapManage instance];
    _location = [manger currentLocation];
}
//  获取数据
- (void)getSource
{
    if (page == 1)
    {
        [self.sourceArray removeAllObjects];
    }
    __weak ZYPBusinessListVC *businessVC = self;
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *accout = [HSPAccountTool account];
    NSString *urlString =[NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&axis=%@&range_type=%@&page=%@",businessListUrl,accout.user_id,accout.userTokenid,[NSString stringWithFormat:@"%f,%f",_location.coordinate.latitude,_location.coordinate.longitude],accout.range_type,[NSString stringWithFormat:@"%d",page]];
    [manger connectWithUrlString:urlString completion:^(id responedObject)
    {
        if ([responedObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responedObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"])
            {
                NSArray *array = [dic objectForKey:@"data"];
                for (NSDictionary *busDic in array)
                {
                    ZYPBusinessObject *buObject = [[ZYPBusinessObject alloc] initBusinessObjectWithDic:busDic];
                    [businessVC.sourceArray addObject:buObject];
                }
                //  结束刷新
                [businessVC.tableView headerEndRefreshing];
                [businessVC.tableView footerEndRefreshing];
                businessVC.tableView.hidden = NO;
                [businessVC.tableView reloadData];
            }else if ([dic objectForKey:@"1006"])
            {
                //  结束刷新
                [businessVC.tableView headerEndRefreshing];
                [businessVC.tableView footerEndRefreshing];
                // 弹出对话框
                [businessVC alertWithMessage:[dic objectForKey:@"message"]];
                btn.hidden = NO;
                businessVC.tableView.hidden = YES;
            }
        }else
        {
            //  结束刷新
            [businessVC.tableView headerEndRefreshing];
            [businessVC.tableView footerEndRefreshing];
            [businessVC alertWithMessage:@"加载失败，请检查网络连接"];
            [businessVC.tableView reloadData];
            btn.hidden = NO;
            businessVC.tableView.hidden = YES;
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifier";
    ZYPRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPRecommendCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    ZYPBusinessObject *object = [self.sourceArray objectAtIndex:indexPath.row];
    cell.object = object;
    [cell.businessImage setImageWithURL:[NSURL URLWithString:object.thumb] placeholderImage:[UIImage imageNamed:@"ZYPshop_default_avatar.png"]];
    if ([object.score intValue] != 0) {
        for (int i = 0; i < [object.score intValue]; i++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(108 + i*24 , 27, 24, 24)];
            imageview.image = [UIImage imageNamed:@"ZYPChengseStar@2x_01.png"];
            [cell.contentView addSubview:imageview];
        }
        for (int i = [object.score intValue]; i < 5 ; i ++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(108 + i*24 , 27, 24, 24)];
            imageview.image = [UIImage imageNamed:@"ZYPHuiseStar@2x_03.png"];
            [cell.contentView addSubview:imageview];
        }

    }else if([object.score intValue] == 0)
    {
        for (int i = 0; i < 5 ; i ++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(108 + i*24 , 27, 24, 24)];
            imageview.image = [UIImage imageNamed:@"ZYPHuiseStar@2x_03.png"];
            [cell.contentView addSubview:imageview];
        }
    }
    cell.businessNameLabel.text = object.merchant_name;
    cell.addressLabel.text = object.shop_address;
    cell.phoneImageView.image = [UIImage imageNamed:@"ZYPDianhua @2x.png"];
    cell.distanceLabel.text = object.distance;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYPBusinessObject *object = [self.sourceArray objectAtIndex:indexPath.row];
    ZYPBUDetalVC *detailV = [[ZYPBUDetalVC alloc] initWithNibName:@"ZYPBUDetalVC" bundle:nil];
    detailV.object = object;
    [self.navigationController pushViewController:detailV animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
