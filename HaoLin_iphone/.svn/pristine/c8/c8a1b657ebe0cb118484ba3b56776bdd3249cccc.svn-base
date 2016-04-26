//
//  MQLCustomViewController.m
//  radarPad
//
//  Created by maqianli on 12-10-30.
//  Copyright (c) 2012年 uniwin. All rights reserved.
//

#import "MQLCustomViewController.h"

@interface MQLCustomViewController ()

@end

@implementation MQLCustomViewController


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
	// Do any additional setup after loading the view.
    
    if (IS_UpIOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;//iOS 7.0 and later
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//(2_0, 6_0)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//(6.0 and later)
-(BOOL)shouldAutorotate
{
    return YES;
}

//(6.0 and later)
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

//(6.0 and later)
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


@end
