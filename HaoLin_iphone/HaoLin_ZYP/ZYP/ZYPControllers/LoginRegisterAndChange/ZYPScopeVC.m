//
//  ZYPScopeVC.m
//  HaoLin
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPScopeVC.h"

@interface ZYPScopeVC ()
{
    CGFloat latt;
    CGFloat longt;
}
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSMutableArray *sourceArray;
@property (nonatomic, strong)UIButton *btn;
@end

@implementation ZYPScopeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)refreshTableView:(UIButton *)btn1
{
    self.btn.hidden = YES;
    [self getSource];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    if (self.result != nil)
    {
        latt = self.result.coordinate.latitude;
        longt = self.result.coordinate.longitude;
    }else
    {
        latt = self.coord.location.latitude;
        longt = self.coord.location.longitude;
    }
    // Do any additional setup after loading the view from its nib.
    self.array = [[NSMutableArray alloc] initWithCapacity:0];
    self.sourceArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
        self.tableView.frame = CGRectMake(0, 64, 320, 504);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.tableView.frame = CGRectMake(0, 64, 320, 416);
    }
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.btn.frame = CGRectMake(110, 200, 100, 100);
    [self.view addSubview:self.btn];
    self.btn.hidden = YES;
    
    
    
    
    ZYPNavagationView *naView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPNavagationView" owner:self options:nil] lastObject];
    naView.backgroundColor = ZYPBGColor;
    naView.scopeVC = self;
    naView.titleLabel.text = @"经营范围";
    naView.frame = CGRectMake(0, 0, 320, 64);
    [self.view addSubview:naView];
    [self getSource];

}
//  数据源
- (void)getSource
{
    //  显示加载图标
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    __weak ZYPScopeVC *scopeVC = self;
    NSString *urlStr = [NSString stringWithFormat:@"%@cat_id=%@",goodsCategaryList,self.categary];
    [manger connectWithUrlString:urlStr completion:^(id responedObject) {
        if ([responedObject isKindOfClass:[NSDictionary class]])
        {
            //  隐藏加载图标
            [MBProgressHUD hideAllHUDsForView:scopeVC.view animated:YES];
            NSDictionary *dic = responedObject;
            if ([[dic objectForKey:@"code"] intValue] == 0)
            {
                NSArray *array = [dic objectForKey:@"data"];
                for (NSDictionary *dic1 in array)
                {
                    ZYPCategaryListObject *listObject = [[ZYPCategaryListObject alloc] initWithDictionry:dic1];
                    [scopeVC.array addObject:listObject];
                }
                [scopeVC.tableView reloadData];
            }else
            {
                scopeVC.btn.hidden = NO;
                [scopeVC alertWithMessage:[dic objectForKey:@"message"]];
            }
        }else
        {
            //  隐藏加载图标
            [MBProgressHUD hideAllHUDsForView:scopeVC.view animated:YES];
            scopeVC.btn.hidden = NO;
            [scopeVC.tableView reloadData];
            [scopeVC alertWithMessage:@"加载失败，请检查网络连接"];
        }
        
    }];
}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

//  选择经营范围
- (void)caculuteCount:(NSInteger)count but:(UIButton*)btn
{
    NSLog(@"%@",btn.titleLabel.text);
    if (self.sourceArray.count <= 3) {
        if (count == 0)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"ZYPcheck@2x.png"] forState:UIControlStateNormal];
            [self.sourceArray addObject:btn.titleLabel.text];
        }else if (count == 1)
        {
            [self.sourceArray removeObject:btn.titleLabel.text];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
    NSLog(@"array %@",self.array);
    if (self.sourceArray.count >= 4) {
        [self.sourceArray removeObject:btn.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"最多添加三项" message:@"您已完成添加" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
        [alert show];
    }
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifier";
    ZYPSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPSelectedCell" owner:self options:nil] lastObject];
    }
    cell.scopevc = self;
    ZYPCategaryListObject *object = [self.array objectAtIndex:indexPath.row];
    cell.nameLabel.text = object.cat_name;
    cell.selectedBtn.titleLabel.text = object.cat_id ;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    //  添加下一步按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(80, 20, 160, 40);
    addBtn.titleLabel.textColor = [UIColor whiteColor];
    addBtn.backgroundColor = [UIColor orangeColor];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    addBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addBtn setTitle:@"提交" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:addBtn];
    return customView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    label.text = @"   最多添加三项哦";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor orangeColor];
    [customView addSubview:label];
    return customView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
/**
 *  提交审核信息
 */
- (void)nextStep:(UIButton *)btn
{
    NSLog(@"%f",latt);
    NSLog(@"%f",longt);
    NSLog(@"%@",self.shopAddress);
    NSLog(@"%@",self.shopName);
    NSLog(@"%@",self.categary);
    NSLog(@"%@",self.userid);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *categar;
    if (self.sourceArray.count == 1)
    {
        categar = [self.sourceArray lastObject];
    }else if (self.sourceArray.count == 2)
    {
        categar = [NSString stringWithFormat:@"%@,%@",[self.sourceArray objectAtIndex:0],[self.sourceArray objectAtIndex:1]];
    }else if (self.sourceArray.count == 3)
    {
         categar = [NSString stringWithFormat:@"%@,%@,%@",[self.sourceArray objectAtIndex:0],[self.sourceArray objectAtIndex:1],[self.sourceArray objectAtIndex:2]];
    }else if (self.sourceArray.count == 0)
    {
        categar = nil;
    }
    //  请求类
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    NSArray *array;
    NSDictionary *dicReal;
    if (self.imagesArr.count == 3)
    {
       array = [NSArray arrayWithObjects:@"identity_img_z",@"identity_img_f",@"trade_img", nil];
        //  参数字典
       dicReal = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f,%f",longt,latt],@"axis",self.shopAddress,@"shop_address",[array objectAtIndex:0],@"identity_img_z",[array objectAtIndex:1],@"identity_img_f",[array objectAtIndex:2],@"trade_img",categar,@"range_catstr",self.userid,@"user_id",self.shopName,@"merchant_name",self.categary,@"range_type", nil];
    }else if (self.imagesArr.count == 4)
    {
        array = [NSArray arrayWithObjects:@"identity_img_z",@"identity_img_f",@"trade_img",@"health_img", nil];
        //  参数字典
        dicReal = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f,%f",longt,latt],@"axis",self.shopAddress,@"shop_address",[array objectAtIndex:0],@"identity_img_z",[array objectAtIndex:1],@"identity_img_f",[array objectAtIndex:2],@"trade_img",[array objectAtIndex:3],@"health_img",categar,@"range_catstr",self.userid,@"user_id",self.shopName,@"merchant_name",self.categary,@"range_type", nil];
    }
    //  调用请求方法
    [manger businessUPload:self.imagesArr filedLetter:array urlString:businessUploadUrl para:dicReal completion:^(id responedObject) {
        //  隐藏加载图标
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([responedObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responedObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                ZYPOverViewController *overVC = [[ZYPOverViewController alloc] initWithNibName:@"ZYPOverViewController" bundle:nil];
                [self.navigationController pushViewController:overVC animated:YES];
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[dic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提交失败,请检查所填信息" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
