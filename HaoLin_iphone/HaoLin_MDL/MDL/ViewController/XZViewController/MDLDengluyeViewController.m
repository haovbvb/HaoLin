//
//  MDLDengluyeViewController.m
//  HaoLin
//
//  Created by apple on 14-8-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MDLDengluyeViewController.h"

@interface MDLDengluyeViewController ()

@end

@implementation MDLDengluyeViewController

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
    self.denglubtn.backgroundColor=MDLBGColor;
    self.Nvabarview.backgroundColor=MDLBGColor;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
