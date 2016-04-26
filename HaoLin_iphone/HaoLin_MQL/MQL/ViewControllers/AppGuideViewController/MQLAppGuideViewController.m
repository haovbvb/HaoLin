//
//  MQLAppGuideViewController.m
//  HaoLin
//
//  Created by MQL on 14-10-16.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLAppGuideViewController.h"

@interface MQLAppGuideViewController ()

@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，20），因为app start form ios7, 所以该引用备用
@property (nonatomic, strong) MQLAppGuideView *appGuideView;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加appGuideView
 */
-(void)addAppGuideView;


@end

@implementation MQLAppGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self customInitialization];
    [self addAppGuideView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- MQLAppGuideViewController函数扩展
/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = MQLBGColor;
}

/**
 *  添加appGuideView
 */
-(void)addAppGuideView
{
    self.appGuideView = [[[NSBundle mainBundle]loadNibNamed:@"MQLAppGuideView" owner:nil options:nil]lastObject];
    self.appGuideView.frame = self.adjustView.bounds;
    [self.adjustView addSubview:self.appGuideView];
}

@end
