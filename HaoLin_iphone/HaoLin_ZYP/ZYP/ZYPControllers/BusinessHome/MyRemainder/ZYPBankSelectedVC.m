 //
//  ZYPBankSelectedVC.m
//  HaoLin
//
//  Created by mac on 14-9-10.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPBankSelectedVC.h"

@interface ZYPBankSelectedVC ()
{
    NSInteger index;
    NSString *bankName;
}
@property (nonatomic, strong)NSMutableArray *sourceArray;
@end

@implementation ZYPBankSelectedVC

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
   
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    self.titleLabel.backgroundColor = ZYPBGColor;

    // Do any additional setup after loading the view from its nib.
    self.sourceArray = [NSMutableArray arrayWithObjects:@"中国工商银行",@"中国建设一行",@"中国银行",@"交通银行",@"中国农业银行",@"招商银行",@"邮政储储蓄银行",@"民生银行",@"中信银行", nil];
    
}
#pragma mark - tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.sourceArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    index = indexPath.row;
    bankName = [self.sourceArray objectAtIndex:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}
//  回调block
- (void)callBack:(CallBackBank)block
{
    block(bankName,index + 1);
}
//  返回
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
