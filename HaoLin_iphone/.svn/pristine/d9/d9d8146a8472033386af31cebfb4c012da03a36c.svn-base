//
//  MQLPersonalView.m
//  HaoLin
//
//  Created by mac on 14-8-8.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLPersonalView.h"

@interface MQLPersonalView ()

@property (nonatomic, weak) IBOutlet UIView *navView;

@property (nonatomic, weak) IBOutlet UIScrollView *middleScrollView;
@property (nonatomic, weak) IBOutlet UIView *adViewContainerInPersonalView;     //个人视图中广告容器
@property (nonatomic, weak) IBOutlet UIView *hanDanKindsViewContainer;          //喊单种类容器

@property (nonatomic, strong) MQLAdViewInPersonalView *adViewInPersonalView;
@property (nonatomic, strong) MQLHanDanKindsView *hanDanKindsView;

/**
 *  初始化登陆前的单实例
 */
-(void)singleInstanceInitializationBeforeLogin;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加个人视图里的广告视图
 */
-(void)addAdViewInPersonalView;

/**
 *  添加喊单种类视图
 */
-(void)addHanDanKindsView;



@end

@implementation MQLPersonalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    //自定义初始化
    [self customInitialization];
    
    //添加个人视图里的广告视图
    [self addAdViewInPersonalView];
    
    //添加喊单种类视图
    [self addHanDanKindsView];
    
    
}

-(void)setOwnerViewController:(UIViewController *)ownerViewController
{
    _ownerViewController = ownerViewController;
    
    self.adViewInPersonalView.ownerViewController = self.ownerViewController;
    self.hanDanKindsView.ownerViewController = self.ownerViewController;
}

#pragma mark -- MQLPersonalView函数扩展

/**
 *  初始化登陆前的单实例
 */
-(void)singleInstanceInitializationBeforeLogin
{
    [MQLBMKMapManage instance];
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.navView.backgroundColor = BGOrangeColor;
    
    //初始化登陆前的单实例
    [self singleInstanceInitializationBeforeLogin];
    
}

/**
 *  添加个人视图里的广告视图
 */
-(void)addAdViewInPersonalView
{
    
    self.adViewInPersonalView = [[[NSBundle mainBundle]loadNibNamed:@"MQLAdViewInPersonalView" owner:nil options:nil]lastObject];
    self.adViewInPersonalView.frame = self.adViewContainerInPersonalView.bounds;
    self.adViewInPersonalView.ownerViewController = self.ownerViewController;
    [self.adViewContainerInPersonalView addSubview:self.adViewInPersonalView];
    
}

/**
 *  添加喊单种类视图
 */
-(void)addHanDanKindsView
{
    self.hanDanKindsView = [[[NSBundle mainBundle]loadNibNamed:@"MQLHanDanKindsView" owner:nil options:nil]lastObject];

    self.hanDanKindsViewContainer.frame = CGRectMake(self.hanDanKindsViewContainer.frame.origin.x,
                                                     self.hanDanKindsViewContainer.frame.origin.y,
                                                     self.hanDanKindsView.frame.size.width,
                                                    self.hanDanKindsView.frame.size.height);
    
    self.hanDanKindsView.frame = self.hanDanKindsViewContainer.bounds;
    [self.hanDanKindsViewContainer addSubview:self.hanDanKindsView];
    
    self.middleScrollView.contentSize = CGSizeMake(self.hanDanKindsView.bounds.size.width,
      self.adViewContainerInPersonalView.bounds.size.height + self.hanDanKindsView.bounds.size.height);
}


@end
