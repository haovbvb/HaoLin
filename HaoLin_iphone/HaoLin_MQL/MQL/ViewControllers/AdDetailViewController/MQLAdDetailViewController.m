//
//  MQLAdDetailViewController.m
//  HaoLin
//
//  Created by MQL on 14-10-14.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLAdDetailViewController.h"

@interface MQLAdDetailViewController ()

@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，20），因为app start form ios7, 所以该引用备用

@property (nonatomic, strong) MQLAdDetailView *adDetailView;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加adDetailView
 */
-(void)addAdDetailView;

@end

@implementation MQLAdDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self customInitialization];
    [self addAdDetailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --MQLAdDetailViewController
/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = MQLBGColor;
}

/**
 *  添加adDetailView
 */
-(void)addAdDetailView
{
    self.adDetailView = [[[NSBundle mainBundle]loadNibNamed:@"MQLAdDetailView" owner:nil options:nil]lastObject];
    self.adDetailView.frame = self.adjustView.bounds;
    self.adDetailView.ownerViewController = self;
    self.adDetailView.adItem = self.adItem;
    [self.adjustView addSubview:self.adDetailView];
}

@end
