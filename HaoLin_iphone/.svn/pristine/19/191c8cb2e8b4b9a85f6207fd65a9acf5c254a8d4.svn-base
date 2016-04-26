//
//  MQLCustomNavigationController.m
//  radarPad
//
//  Created by maqianli on 12-10-30.
//  Copyright (c) 2012年 uniwin. All rights reserved.
//

#import "MQLCustomNavigationController.h"

@interface MQLCustomNavigationController ()

@end

@implementation MQLCustomNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//(2_0, 6_0)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

//(6.0 and later)
- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}
//(6.0 and later)
- (NSUInteger)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

//(6.0 and later)
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
