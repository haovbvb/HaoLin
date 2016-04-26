//
//  ZYPGoodsCategaryVC.m
//  HaoLin
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPGoodsCategaryVC.h"

@interface ZYPGoodsCategaryVC ()
{
    BOOL state;
}
@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, strong)UIView *shadeView;
@end

@implementation ZYPGoodsCategaryVC

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
    self.overBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.overBtn.layer.borderWidth = 1;
    self.namElABEL.text = self.str;
    self.array = [NSMutableArray arrayWithObjects:@"日常用品", @"水果",@"饮料",nil];
}
- (IBAction)bak:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)over:(id)sender
{
    state = NO;
    [self.tableView reloadData];
}
- (void)updataSource:(NSString *)text
{
    if ([text length] == 0 || [self.array containsObject:text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"不能为空或者重复" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } else if ([text length] > 0)
    {
        NSInteger count = self.array.count ;
        [self.array  insertObject:text atIndex:count];
        [self.tableView reloadData];
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
    ZYPGoodsSheftCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPGoodsSheftCell" owner:self options:nil] lastObject];
    }
    cell.nameLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}
// 编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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
    ZYPAlertView *alertViw = [[[NSBundle mainBundle] loadNibNamed:@"ZYPAlertView" owner:self options:nil] lastObject];
    alertViw.delegateVC = self;
    alertViw.v = self.shadeView;
    alertViw.layer.borderWidth = 1;
    alertViw.layer.borderColor = [UIColor lightGrayColor].CGColor;
    alertViw.frame =CGRectMake(50, 180, 220, 150);
    [self.view addSubview:alertViw];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (state == YES) {
        return 44;
    }else if(state == NO)
    {
        return 0;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYPDetaiCategaryViewCV *detailVC = [[ZYPDetaiCategaryViewCV alloc] initWithNibName:@"ZYPDetaiCategaryViewCV" bundle:nil];
    detailVC.str = [self.array objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
