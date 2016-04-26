//
//  MQLShiWuOrFuWuConfirmOrderFormViewController.m
//  HaoLin
//
//  Created by MQL on 14-9-16.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLShiWuOrFuWuConfirmOrderFormViewController.h"

@interface MQLShiWuOrFuWuConfirmOrderFormViewController ()

@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，20），因为app start form ios7, 所以该引用备用
@property (nonatomic, weak) MQLShiWuOrFuWuConfirmOrderFormView *shiWuOrFuWuConfirmOrderFormView;


/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加ShiWuOrFuWuConfirmOrderFormView
 */
-(void)addShiWuOrFuWuConfirmOrderFormView;


@end

@implementation MQLShiWuOrFuWuConfirmOrderFormViewController

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
    
    //自定义初始化
    [self customInitialization];
    
    //添加ShiWuOrFuWuConfirmOrderFormView
    [self addShiWuOrFuWuConfirmOrderFormView];
    
}

-(void)setTalk_id:(NSString *)talk_id
{
    _talk_id = talk_id;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- MQLShiWuOrFuWuConfirmOrderFormViewController函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = MQLBGColor;
}

/**
 *  添加ShiWuOrFuWuConfirmOrderFormView
 */
-(void)addShiWuOrFuWuConfirmOrderFormView
{
    self.shiWuOrFuWuConfirmOrderFormView = [[[NSBundle mainBundle]loadNibNamed:@"MQLShiWuOrFuWuConfirmOrderFormView" owner:nil options:nil]lastObject];
    self.shiWuOrFuWuConfirmOrderFormView.ownerViewController = self;
    self.shiWuOrFuWuConfirmOrderFormView.talk_id = self.talk_id;
    self.shiWuOrFuWuConfirmOrderFormView.frame = self.adjustView.bounds;
    [self.adjustView addSubview:self.shiWuOrFuWuConfirmOrderFormView];
}


@end
