//
//  MDLJingyingViewController.m
//  HAOLINAPP
//
//  Created by apple on 14-8-13.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//

#import "MDLJingyingViewController.h"


@interface MDLJingyingViewController ()

@end

@implementation MDLJingyingViewController

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
    
    [self initview];
}

//初始化出VIew
-(void)initview
{
    MDLXZoneView *zsoneView=[[[NSBundle mainBundle ]loadNibNamed:@"MDLXZoneView" owner:self options:nil]lastObject];
    zsoneView.MDLJingyingViewController=self;
    [self.view addSubview:zsoneView];

}


#pragma mark UITableViewDelegate End -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
