//
//  HSPIncomeViewController.m
//  HaoLin
//
//  Created by PING on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPIncomeViewController.h"

@interface HSPIncomeViewController ()

@end

@implementation HSPIncomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的推广收益";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor,NSForegroundColorAttributeName, nil]];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *incomeId = @"incomeId";
    HSPIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:incomeId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HSPIncomeCell" owner:self options:nil] lastObject];
    }
    return cell;
}


@end
