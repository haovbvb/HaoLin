
//  MQLPartyViewController.m
//  HaoLin
//
//  Created by mac on 14-8-7.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLPartyViewController.h"

@interface MQLPartyViewController ()
@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，69），因为app start form ios7, 所以该引用备用
@property (nonatomic, assign)BOOL A;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加我的视图
 */
-(void)addMyView;



@end

@implementation MQLPartyViewController

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
    /**
     *  给属性A赋初始值
     */
    self.A = NO;
    /**
     *  添加观察者，添加观察者（退出登录时触发，登录界面点击返回按钮时触发，将A的状态改为YES）
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:@"log" object:nil];
   
    /**
     *  添加观察者（退出登录时触发，登录界面点击返回按钮时触发，将A的状态改为YES）
     *
     *  @param state: 观察者触发的方法
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(state:) name:@"A" object:nil];

    //自定义初始化
    [self customInitialization];
}
- (void)state:(NSNotification *)no
{
    self.A = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //添加我的视图
    [self addMyView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- MQLPartyViewController函数扩展
/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = MQLBGColor;
}
/**
 *  改变状态(亚鹏加)
 *
 */
- (void)push:(NSNotification *)no
{
    HSPAccount *account = [HSPAccountTool account];
    if ([account.user_id length] > 0)
    {
        self.A = YES;
    }else if ([account.user_id length] == 0)
    {
        self.A = NO;
    }
}
/**
 *  添加我的视图
 */
-(void)addMyView
{
    MQLAppDelegate *appDelegate = (MQLAppDelegate*)[UIApplication sharedApplication].delegate;
    int lastTabBarItemIndex = appDelegate.rootViewController.lastTabBarItemIndex;
    
    switch (lastTabBarItemIndex) {
        case 0://从个人切过来的
        {
            //添加你的代码
            YYLog(@"从个人切过来的")
            [self shangjia:lastTabBarItemIndex];
        }
            break;
        case 1://从商家切过来的
        {
            //添加你的代码ma
            YYLog(@"从商家切过来的")
            [self shangjia:lastTabBarItemIndex];
        }
            break;
        default:
            break;
    }
}
/**
 *  判断是否弹出登陆界面，还是进入登陆后的界面
 *
 *  @param tag 判断是从商家过来的，还是从个人过来的
 */
- (void)shangjia:(NSInteger)tag
{
    HSPAccount *account = [HSPAccountTool account];
    //添加你的代码
    if ([account.user_id length]> 0)
    {
        [self tapInto:tag account:account];
    }else if([account.user_id length] == 0)
    {
        [self logout:tag];
        
        if (self.A == YES)
        {
            self.A = YES;
            return;
        }else if (self.A == NO)
        {
            HSPLoginViewController *loginVC = [[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
            HSPNavigationController *nav = [[HSPNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
            self.A = YES;
        }
    }
}

/**
 *  粘贴被选中好的View
 *
 *  @param tag 判断是从商家过来的，还是从个人过来的
 */
- (void)tapInto:(NSInteger)tag account:(HSPAccount *)account
{
    if ([account.user_mark isEqualToString:@"2"]) {
        if (tag == 1)
        {
            for (HSPProfileView *v in _adjustView.subviews)
            {
                if ([v isKindOfClass:[HSPProfileView class]])
                {
                    [v removeFromSuperview];
                }
            }
            ZYPHomeView *homeview = [[[NSBundle mainBundle] loadNibNamed:@"ZYPHomeView" owner:self options:nil] lastObject];
            homeview.partVC = self;
            [self.adjustView addSubview:homeview];
        }else if (tag == 0)
        {
            //  个人界面
            for (ZYPHomeView *v in _adjustView.subviews)
            {
                if ([v isKindOfClass:[ZYPHomeView class]])
                {
                    [v removeFromSuperview];
                }
            }
            HSPProfileView *profileView = [[[NSBundle mainBundle] loadNibNamed:@"HSPProfileView" owner:self options:nil] lastObject];
            profileView.HSPProfileViewController = self;
            [self.adjustView addSubview:profileView];
        }
    }else if ([account.user_mark isEqualToString:@"0"] ||  [account.user_mark isEqualToString:@"1"] || [account.user_mark isEqualToString:@"3"])
    {
            //  个人界面
            HSPProfileView *profileView = [[[NSBundle mainBundle] loadNibNamed:@"HSPProfileView" owner:self options:nil] lastObject];
            profileView.HSPProfileViewController = self;
            [self.adjustView addSubview:profileView];
    }
}
- (void)logout:(NSInteger)tag
{
    for (UIView *view in _adjustView.subviews) {
        [view removeFromSuperview];
    }
    if ([ZYPObjectManger shareInstance].state == 0)
    {
        /**
         *  商家界面
         */
        ZYPHomeView *homeview = [[[NSBundle mainBundle] loadNibNamed:@"ZYPHomeView" owner:self options:nil] lastObject];
        homeview.partVC = self;
        [self.adjustView addSubview:homeview];
    }else if ([ZYPObjectManger shareInstance].state == 1)
    {
        //  个人界面
        HSPProfileView *profileView = [[[NSBundle mainBundle] loadNibNamed:@"HSPProfileView" owner:self options:nil] lastObject];
        profileView.HSPProfileViewController = self;
        [self.adjustView addSubview:profileView];
    }else if([ZYPObjectManger shareInstance].state == -1)
    {
        if (tag == 0)
        {
            //  个人界面
            HSPProfileView *profileView = [[[NSBundle mainBundle] loadNibNamed:@"HSPProfileView" owner:self options:nil] lastObject];
            profileView.HSPProfileViewController = self;
            [self.adjustView addSubview:profileView];
        }else if (tag == 1)
        {
            /**
             *  商家界面
             */
            ZYPHomeView *homeview = [[[NSBundle mainBundle] loadNibNamed:@"ZYPHomeView" owner:self options:nil] lastObject];
            homeview.partVC = self;
            [self.adjustView addSubview:homeview];
        }
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"log" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"A" object:nil];
}
@end