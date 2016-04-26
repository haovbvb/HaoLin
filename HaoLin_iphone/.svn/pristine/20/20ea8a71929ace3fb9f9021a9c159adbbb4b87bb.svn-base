//
//  MQLHanDanWaitingViewController.m
//  HaoLin
//
//  Created by MQL on 14-9-3.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLHanDanWaitingViewController.h"

@interface MQLHanDanWaitingViewController ()

@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，20），因为app start form ios7, 所以该引用备用
@property (nonatomic, strong) MQLHanDanWaitingView *hanDanWaitingView;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加HanDanWaitingView
 */
-(void)addHanDanWaitingView;


@end

@implementation MQLHanDanWaitingViewController

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
    
    //自定义初始化
    [self customInitialization];
    
    //添加HanDanWaitingView
    [self addHanDanWaitingView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --MQLHanDanWaitingViewController函数扩展
/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = MQLBGColor;
}

/**
 *  添加HanDanWaitingView
 */
-(void)addHanDanWaitingView
{
    self.hanDanWaitingView = [[[NSBundle mainBundle]loadNibNamed:@"MQLHanDanWaitingView" owner:nil options:nil]lastObject];
    
    self.hanDanWaitingView.ownerViewController = self;
    self.hanDanWaitingView.selectedHanDankind = self.selectedHanDankind;
    self.hanDanWaitingView.personalHanDanDataManage = self.personalHanDanDataManage;
    self.hanDanWaitingView.dataOfHanDanOver = self.dataOfHanDanOver;
    
    self.hanDanWaitingView.frame = self.adjustView.bounds;
    [self.adjustView addSubview:self.hanDanWaitingView];
}

@end
