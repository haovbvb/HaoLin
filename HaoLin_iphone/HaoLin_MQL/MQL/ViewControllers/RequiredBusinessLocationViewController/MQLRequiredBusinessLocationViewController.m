//
//  MQLRequiredBusinessLocationViewController.m
//  HaoLin
//
//  Created by MQL on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLRequiredBusinessLocationViewController.h"

@interface MQLRequiredBusinessLocationViewController ()

@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，20），因为app start form ios7, 所以该引用备用

@property (nonatomic, strong) MQLRequiredBusinessLocationView *requiredBusinessLocationView;


/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加RequiredBusinessLocationView
 */
-(void)addRequiredBusinessLocationView;


@end

@implementation MQLRequiredBusinessLocationViewController

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
    
    // 自定义初始化
    [self customInitialization];
    
    //添加RequiredBusinessLocationView
    [self addRequiredBusinessLocationView];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.requiredBusinessLocationView viewWillAppear];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.requiredBusinessLocationView viewWillDisappear];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-- MQLRequiredBusinessLocationViewController函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = MQLBGColor;
    
}

/**
 *  添加RequiredBusinessLocationView
 */
-(void)addRequiredBusinessLocationView
{
    self.requiredBusinessLocationView = [[[NSBundle mainBundle]loadNibNamed:@"MQLRequiredBusinessLocationView" owner:nil options:nil]lastObject];
    self.requiredBusinessLocationView.ownerViewController = self;
    self.requiredBusinessLocationView.personalHanDanDataManage = self.personalHanDanDataManage;
    
    self.requiredBusinessLocationView.frame = self.adjustView.bounds;
    [self.adjustView addSubview:self.requiredBusinessLocationView];
}

@end
