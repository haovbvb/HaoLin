//
//  ZYPDetaiCategaryViewCV.m
//  HaoLin
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPDetaiCategaryViewCV.h"

@interface ZYPDetaiCategaryViewCV ()
{
    ZYPAddDetailView *alertView ;
    BOOL state;
}
@property (nonatomic, strong)UIView *shadeView;
@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, strong)NSMutableArray *array1;

@end

@implementation ZYPDetaiCategaryViewCV

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    state = YES;
    self.titleLabel.text = self.str;
    self.array = [NSMutableArray arrayWithObjects:@"牙膏", @"被子",@"杯子",nil];
    self.array1 = [NSMutableArray arrayWithObjects:@"5元", @"10元",@"6元",nil];
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)over:(id)sender
{
    state = NO;
    [self.tableView reloadData];
}

- (void)updataSourceA:(NSString *)goodsName price:(NSString *)priceName
{
    if ([goodsName length] == 0 || [priceName length] == 0) {
        UIAlertView * leart = [[UIAlertView alloc] initWithTitle:@"商品名和价格都不能为空" message:@"请您重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [leart show];
        [self.shadeView removeFromSuperview];
        [alertView removeFromSuperview];
    }else{
    NSString *price = [NSString stringWithFormat:@"%@元",priceName];
    [self.array addObject:goodsName];
    [self.array1 addObject:price];
    [self.tableView reloadData];
    [UIView animateWithDuration:1 animations:^{
        [self.shadeView removeFromSuperview];
        [alertView removeFromSuperview];
    }];
    }
}

#pragma mark - 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
    ZYPDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPDetailCell" owner:self options:nil] lastObject];
    }
    cell.nameLabel.text = [self.array objectAtIndex:indexPath.row];
    cell.priceLabel.text = [self.array1 objectAtIndex:indexPath.row];
    return cell;

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
    customView.backgroundColor = [UIColor clearColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10.0, 5, 50, 40.0);
    //  识别button
    btn.tag = section;
    [btn setBackgroundImage:[UIImage imageNamed:@"添加常态@2x.jpg"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addRows:) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:btn];
    return customView;
}
- (void)addRows:(UIButton *)button
{
    self.shadeView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.shadeView.backgroundColor = [UIColor grayColor];
    self.shadeView.alpha = 0.6;
    [self.view addSubview:self.shadeView];
    alertView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPAddDetailView" owner:self options:nil] lastObject];
    alertView.addView = self.shadeView;
    alertView.frame =CGRectMake(40, 140, 240, 200);
    [self.view addSubview:alertView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (state == YES) {
        return 44;
    }else if (state == NO){
        return 0;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.array1 removeObjectAtIndex:indexPath.row];
        [self.array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
