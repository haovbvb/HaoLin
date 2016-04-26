//
//  ZYPScopeViewController.m
//  HaoLin
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPScopeViewController.h"
@interface ZYPScopeViewController ()
@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, strong)NSMutableArray *sourceArray;
@end

@implementation ZYPScopeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//  移除观察者
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"popToRootViewController" object:nil];
}
//  方法
- (void)backInto
{
    MQLPartyViewController *part = [[MQLPartyViewController alloc] initWithNibName:@"MQLPartyViewController" bundle:nil];
    [self.navigationController pushViewController:part animated:NO];
    
}

- (void)viewDidLoad
{
    //  添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backInto) name:@"popToRootViewController" object:nil];
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }

    self.array = [[NSMutableArray alloc] initWithCapacity:0];
    self.sourceArray = [[NSMutableArray alloc]initWithCapacity:0];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getSource];
}
//  数据源
- (void)getSource
{
    __weak ZYPScopeViewController *scopeC = self;
    //  显示加载图标
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    ZYPObjectManger *object = [ZYPObjectManger shareInstance];
    NSLog(@"%@",object.loginInObject.range_type);
    NSString *urlStr = [NSString stringWithFormat:@"%@cat_id=%@",goodsCategaryList,object.loginInObject.user_mark];
    NSLog(@"%@",urlStr);
    [manger connectWithUrlString:urlStr completion:^(id responedObject) {
        NSLog(@"%@",responedObject);
        NSDictionary *dic = responedObject;
        NSArray *array = [dic objectForKey:@"data"];
        for (NSDictionary *dic1 in array) {
            ZYPCategaryListObject *listObject = [[ZYPCategaryListObject alloc] initWithDictionry:dic1];
            [scopeC.sourceArray addObject:listObject];
        }
        NSLog(@"%@",scopeC.sourceArray);
        //  隐藏加载图标
        [MBProgressHUD hideAllHUDsForView:scopeC.view animated:YES];
        [scopeC.tableView reloadData];
    }];
}

- (void)selected:(UIButton *)sender tag:(NSInteger)tag
{
    if (self.array.count <= 3) {
        if (tag == 0)
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"ZYPcheck@2x.png"] forState:UIControlStateNormal];
            [self.array addObject:sender.titleLabel.text];
        }else if (tag == 1)
        {
            [self.array removeObject:sender.titleLabel.text];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
    NSLog(@"%@",self.array);
    if (self.array.count >= 4) {
        [self.array removeObject:sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"最多添加三项" message:@"您已完成添加" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [sender setBackgroundImage:nil forState:UIControlStateNormal];
        [alert show];
    }
}

#pragma mark - 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifier";
    ZYPSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPSelectedCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.scopeVC = self;
    ZYPCategaryListObject *object = [self.sourceArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = object.cat_name;
    cell.selectedBtn.titleLabel.text = object.cat_id;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:customView.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor orangeColor];
        label.text = @"最多选三项";
        label.font = [UIFont systemFontOfSize:19];
        [customView addSubview:label];
        return customView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *customeView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(60, 20, 200, 40);
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(commitInfor:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.textColor = [UIColor whiteColor];
        btn.backgroundColor = [UIColor orangeColor];
        [customeView1 addSubview:btn];
        return customeView1;
    }
    return nil;
}
- (void)commitInfor:(UIButton *)btn
{
    NSString *categar;
    if (self.array.count == 1) {
        categar = [self.array lastObject];
    }else if (self.array.count == 2)
    {
        categar = [NSString stringWithFormat:@"%@,%@",[self.array objectAtIndex:0],[self.array objectAtIndex:1]];
    }else if (self.array.count == 3)
    {
        categar = [NSString stringWithFormat:@"%@,%@,%@",[self.array objectAtIndex:0],[self.array objectAtIndex:1],[self.array objectAtIndex:2]];
    }else if (self.array.count == 0)
    {
        categar = nil;
    }

    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    ZYPObjectManger *object = [ZYPObjectManger shareInstance];
    NSString *urlStrintg = [NSString stringWithFormat:@"%@range_catstr=%@&user_id=%@",changeBusinessInfor,categar,object.loginInObject.user_id];
    [manger connectWithUrlStr:urlStrintg completion:^(id respondObject)
    {
        NSLog(@"%@",respondObject);
        NSDictionary *dic = respondObject;
        if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
            [self alertWithMessage:[dic objectForKey:@"message"]];
        }else
        {
            [self alertWithMessage:@"失败,请重新提交哦亲"];
        }
    }];
}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
// 回调函数
- (void)callback:(CallBack)callback
{
    callback(self.array);
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
