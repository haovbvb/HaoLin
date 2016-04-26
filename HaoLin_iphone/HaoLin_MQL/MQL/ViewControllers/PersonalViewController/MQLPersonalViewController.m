//
//  MQLPersonalViewController.m
//  HaoLin
//
//  Created by mac on 14-8-7.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLPersonalViewController.h"

@interface MQLPersonalViewController ()

@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，69），因为app start form ios7, 所以该引用备用


/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加PersonalView
 */
-(void)addPersonalView;


@end

@implementation MQLPersonalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //自定义初始化
    [self customInitialization];
    
    //添加PersonalView
    [self addPersonalView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- MQLPersonalViewController函数扩展
/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = MQLBGColor;
}

/**
 *  添加PersonalView
 */
-(void)addPersonalView
{
    MQLPersonalView *personalView = [[[NSBundle mainBundle]loadNibNamed:@"MQLPersonalView" owner:nil options:nil]lastObject];
    personalView.ownerViewController = self;
    personalView.frame = self.adjustView.bounds;
    [self.adjustView addSubview:personalView];
    
}


@end
