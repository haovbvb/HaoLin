//
//  MQLShiWuFinishOrderFormViewController.m
//  HaoLin
//
//  Created by MQL on 14-9-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLShiWuFinishOrderFormViewController.h"

@interface MQLShiWuFinishOrderFormViewController ()

@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，20），因为app start form ios7, 所以该引用备用
@property (nonatomic, strong) MQLShiWuFinishOrderFormView *shiWuFinishOrderFormView;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加ShiWuFinishOrderFormView
 */
-(void)addShiWuFinishOrderFormView;


@end

@implementation MQLShiWuFinishOrderFormViewController

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
    
    [self customInitialization];
    
    [self addShiWuFinishOrderFormView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --MQLShiWuFinishOrderFormViewController函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = MQLBGColor;
}

/**
 *  添加ShiWuFinishOrderFormView
 */
-(void)addShiWuFinishOrderFormView
{
    self.shiWuFinishOrderFormView = [[[NSBundle mainBundle]loadNibNamed:@"MQLShiWuFinishOrderFormView" owner:nil options:nil]lastObject];
    self.shiWuFinishOrderFormView.ownerViewController = self;
    self.shiWuFinishOrderFormView.submitResponseData = self.submitResponseData;
    self.shiWuFinishOrderFormView.frame = self.adjustView.bounds;
    [self.adjustView addSubview:self.shiWuFinishOrderFormView];
    
}

@end
