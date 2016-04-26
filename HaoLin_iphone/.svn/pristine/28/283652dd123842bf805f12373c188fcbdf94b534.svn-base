//
//  MQLLoginViewController.m
//  HaoLin
//
//  Created by mac on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLLoginViewController.h"

@interface MQLLoginViewController ()

@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，69），因为app start form ios7, 所以该引用备用


/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加LoginView
 */
-(void)addLoginView;



@end

@implementation MQLLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //自定义初始化
    [self customInitialization];
    
    //添加LoginView
    [self addLoginView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- MQLLoginViewController函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = BGColor;
    
}

/**
 *  添加LoginView
 */
-(void)addLoginView
{
    MQLLoginView *loginView = [[[NSBundle mainBundle]loadNibNamed:@"MQLLoginView" owner:nil options:nil]lastObject];
    loginView.ownerViewController = self;
    
    loginView.frame = self.adjustView.bounds;
    [self.adjustView addSubview:loginView];
    
}


@end
