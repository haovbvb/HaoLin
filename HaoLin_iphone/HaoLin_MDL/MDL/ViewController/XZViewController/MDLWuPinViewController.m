//
//  MDLWuPinViewController.m
//  HAOLINAPP
//
//  Created by apple on 14-8-13.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//

#import "MDLWuPinViewController.h"

@interface MDLWuPinViewController ()
//<poprootzhubiewDelegate>


@end

@implementation MDLWuPinViewController

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
    //返回类型选择界面
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (poplaixingvc) name:@"popleixingvc" object:nil];
    [self inittableView];
    
}

-(void)inittableView
{
//    MDLWupinView *wupinview=[[[NSBundle mainBundle]loadNibNamed:@"MDLWupinView" owner:self options:nil]lastObject];
//    wupinview.MDLWuPinViewController=self;
//    wupinview.delegate=self;
//    [self.view addSubview:wupinview];

}
-(void)poplaixingvc
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)poprootzhu
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
