//
//  HSPPhoneBooksViewController.m
//  HaoLin
//
//  Created by PING on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPPhoneBooksViewController.h"

@interface HSPPhoneBooksViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *navSegmented;

@end

@implementation HSPPhoneBooksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupConfig];
    self.navigationController.navigationBar.barTintColor = HSPBgColor;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navSegmented removeFromSuperview];
    self.navigationController.navigationBar.barTintColor = HSPBarBgColor;
}

- (void)setupConfig
{
    self.navSegmented.frame = CGRectMake(80.0f, 8.0f, 150.0f, 30.0f);
    [self.navigationController.navigationBar addSubview:self.navSegmented];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *phoneBook = @"phoneBook";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:phoneBook];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:phoneBook];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"手机通讯录";
    }else{
        cell.textLabel.text = @"QQ通讯录";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0 ) {
        YYLog(@"00");
    }else{
        YYLog(@"11");
    }
}
- (IBAction)navSegmented:(id)sender {
}

@end
