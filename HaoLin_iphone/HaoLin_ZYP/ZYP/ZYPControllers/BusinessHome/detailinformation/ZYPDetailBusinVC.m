//
//  ZYPDetailBusinVC.m
//  HaoLin
//
//  Created by mac on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPDetailBusinVC.h"

@interface ZYPDetailBusinVC ()
@property (nonatomic, strong)NSArray *array;
@property (nonatomic, strong)ZYPBusinessDetailObject *businedetailObject;
@property (nonatomic, strong)NSString *categaryString;
@end

@implementation ZYPDetailBusinVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self getSource];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    self.titleLabel.backgroundColor = ZYPBGColor;

    self.navigationController.navigationBar.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.imageObjectArray = [[NSMutableArray alloc] initWithCapacity:0];
    // Do any additional setup after loading the view from its nib.
    NSArray *arrayPlain = [NSArray  arrayWithObjects:@"名称",@"地址",@"电话",@"经营范围", nil];
    NSArray *arrayDesc = [NSArray arrayWithObjects:@"商户介绍",@"商品介绍",@"活动促销", nil];
    NSArray *arrayT = [NSArray arrayWithObjects:@"图片介绍", nil];
    self.array = [NSArray arrayWithObjects:arrayPlain,arrayDesc,arrayT, nil];
    self.tableView.backgroundColor = HSPBgColor;
}
- (void)getSource
{
    [self.imageObjectArray removeAllObjects];
    //  显示加载状态
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    HSPAccount *accout = [HSPAccountTool account];
    __weak ZYPDetailBusinVC *businessVC = self;
    NSString *urlString = [NSString stringWithFormat:@"%@merchant_id=%@&tokenid=%@&user_id=%@",businessDetailUrl,accout.user_id,accout.userTokenid,accout.user_id];
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    [manger connectWithUrlString:urlString completion:^(id responedObject) {
        
        if ([responedObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responedObject;
            NSLog(@"商家详情数据 %@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"])
            {
                NSDictionary *detailDic = [dic objectForKey:@"data"];
                businessVC.businedetailObject = [[ZYPBusinessDetailObject alloc] initBusinessDetailObjectWithDic:detailDic];
                NSArray *array = [detailDic objectForKey:@"photo"];
                for (NSDictionary *imageObjectDic in array)
                {
                    ZYPPictureDescObject *object1 = [[ZYPPictureDescObject alloc] initPictureDescObjectWithDic:imageObjectDic];
                    [businessVC.imageObjectArray addObject:object1];
                }
                //  隐藏加载状态
                [MBProgressHUD hideAllHUDsForView:businessVC.tableView animated:YES];
                //  调用获得经营范围的方法
                [businessVC getCategory];
            }else
            {
                //  隐藏加载状态
                [MBProgressHUD hideAllHUDsForView:businessVC.tableView animated:YES];
                // 弹出对话框
                [businessVC alertWithMessage:[dic objectForKey:@"message"]];
            }
        }else
        {
            //  隐藏加载状态
            [MBProgressHUD hideAllHUDsForView:businessVC.tableView animated:YES];
            [businessVC alertWithMessage:@"加载失败，请检查网络连接"];
        }
    }];
}
//  获得经营范围的方法
- (void)getCategory
{
    HSPAccount *accout = [HSPAccountTool account];

    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    __weak ZYPDetailBusinVC *businessVC = self;
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@",scopeCategary,accout.user_id,accout.userTokenid];
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         if ([respondObject isKindOfClass:[NSDictionary class]]) {
             NSDictionary *dic = respondObject;
             if ([[dic  objectForKey:@"code"] isEqualToString:@"0"]) {
                 NSArray *array = [dic objectForKey:@"data"];
                 //  创建动态数组，添加array
                 NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:0];
                 for (NSDictionary *dic1 in array)
                 {
                     [a addObject:[dic1 objectForKey:@"cat_name"]];
                 }
                 switch (a.count) {
                     case 1:
                         businessVC.categaryString = [a objectAtIndex:0];
                         break;
                     case 2:
                         businessVC.categaryString = [NSString stringWithFormat:@"%@,%@",[a objectAtIndex:0],[a objectAtIndex:1]];
                         break;
                     case 3:
                         businessVC.categaryString = [NSString stringWithFormat:@"%@,%@,%@",[a objectAtIndex:0],[a objectAtIndex:1],[a objectAtIndex:2]];
                         break;
                     default:
                         break;
             }
            [businessVC.tableView reloadData];
        }else
        {
            [self alertWithMessage:@"加载失败，请检查网络连接"];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.array objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifier";
    ZYPBUPlainCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPBUPlainCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.someLanel.textColor = [UIColor orangeColor];
    cell.someLanel.text = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.rightImageView.image = [UIImage imageNamed:@"ZYPLeft.png"];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.rightLabel.text = self.businedetailObject.merchant_name;
    }else if (indexPath.section == 0 && indexPath.row == 1)
    {
        cell.rightLabel.text = self.businedetailObject.shop_address;
    }else if (indexPath.section == 0 && indexPath.row == 2)
    {
        cell.rightLabel.text = self.businedetailObject.phone;
    }else if (indexPath.section == 0 && indexPath.row == 3)
    {
        cell.rightLabel.text = self.categaryString;
        [cell.rightImageView removeFromSuperview];
    }else if (indexPath.section == 1 && indexPath.row == 0)
    {
        cell.rightLabel.text = self.businedetailObject.mer_desc;
    }else if (indexPath.section == 1 && indexPath.row ==1)
    {
        cell.rightLabel.text = self.businedetailObject.product_desc;
    }else if (indexPath.section == 1 && indexPath.row ==2)
    {
        cell.rightLabel.text = self.businedetailObject.activ_desc;
    }else if (indexPath.section == 2 && indexPath.row ==0)
    {
        cell.rightLabel.text = @"点击进入";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sectionIndex = indexPath.section;
    NSInteger rowIndex = indexPath.row;
    if (sectionIndex == 0) {
        switch (rowIndex) {
            case 0:
            {
                ZYPShopNameVC *nameVC = [[ZYPShopNameVC alloc] initWithNibName:@"ZYPShopNameVC" bundle:nil];
                nameVC.nameText = self.businedetailObject.merchant_name;
                [self.navigationController pushViewController:nameVC animated:YES];
            }
                break;
            case 1:
            {
                ZYPShopAddressVC *addressVC = [[ZYPShopAddressVC alloc] initWithNibName:@"ZYPShopAddressVC" bundle:nil];
                addressVC.addressTEXT = self.businedetailObject.shop_address;
                [self.navigationController pushViewController:addressVC animated:YES];
            }
                break;
            case 2:
            {
                ZYPPhoneChangeVC *phoneVC = [[ZYPPhoneChangeVC alloc] initWithNibName:@"ZYPPhoneChangeVC" bundle:nil];
                phoneVC.phoneNumber = self.businedetailObject.phone;
                [self.navigationController pushViewController:phoneVC animated:YES];
            }
                break;
            case 3:
            {
                //                ZYPScopeViewController *phoneVC = [[ZYPScopeViewController alloc] initWithNibName:@"ZYPScopeViewController" bundle:nil];
                //                [self.navigationController pushViewController:phoneVC animated:YES];
            }
                break;
            default:
                break;
        }
    }else if (sectionIndex == 1)
    {
        switch (rowIndex) {
            case 0:
            {
                //  暂无接口关键字
                ZYPShopDescVC *shopDesc = [[ZYPShopDescVC alloc] initWithNibName:@"ZYPShopDescVC" bundle:nil];
                shopDesc.shopDescText = self.businedetailObject.mer_desc;
                [self.navigationController pushViewController:shopDesc animated:YES];
            }
                break;
            case 1:
            {
                ZYPProductDescVc *productVC = [[ZYPProductDescVc alloc] initWithNibName:@"ZYPProductDescVc" bundle:nil];
                productVC.produceText = self.businedetailObject.product_desc;
                [self.navigationController pushViewController:productVC animated:YES];
            }
                break;
            case 2:
            {
                ZYPActiveDescVC *activeVC = [[ZYPActiveDescVC alloc] initWithNibName:@"ZYPActiveDescVC" bundle:nil];
                activeVC.activeText = self.businedetailObject.activ_desc;
                [self.navigationController pushViewController:activeVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }else if (sectionIndex == 2)
    {
         // 测试
                ZYPBusinessListVC *listVC = [[ZYPBusinessListVC alloc] initWithNibName:@"ZYPBusinessListVC" bundle:nil];
                [self.navigationController pushViewController:listVC animated:YES];
       //  真实
//        ZYPPictureViewController *pictureVC = [[ZYPPictureViewController alloc] initWithNibName:@"ZYPPictureViewController" bundle:nil];
//        pictureVC.array = self.imageObjectArray;
//        [self.navigationController pushViewController:pictureVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
