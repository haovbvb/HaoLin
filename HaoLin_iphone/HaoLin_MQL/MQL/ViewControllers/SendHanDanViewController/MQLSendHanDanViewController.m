//
//  MQLSendHanDanViewController.m
//  HaoLin
//
//  Created by maqianli on 14-8-21.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLSendHanDanViewController.h"

@interface MQLSendHanDanViewController ()

@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，20），因为app start form ios7, 所以该引用备用

@property (nonatomic, strong) MQLSendHanDanView *sendHanDanView;


/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加SendHanDanView
 */
-(void)addSendHanDanView;


@end

@implementation MQLSendHanDanViewController
-(void)dealloc
{
    MQLCharacterOrAudioHanDanViewController *vc = (MQLCharacterOrAudioHanDanViewController*)self.fromVC;
    [vc registerForKeyboardNotificationsAgain];
    
}

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
    
    //添加SendHanDanView
    [self addSendHanDanView];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    static BOOL isFirstAppear = YES;
    if (isFirstAppear) {
        
        isFirstAppear = NO;
    }else{
        
        //刷新sendHanDanView
        [self.sendHanDanView refreshContentTableView];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --MQLSendHanDanViewController函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = MQLBGColor;
    
}

/**
 *  添加SendHanDanView
 */
-(void)addSendHanDanView
{
    self.sendHanDanView = [[[NSBundle mainBundle]loadNibNamed:@"MQLSendHanDanView" owner:nil options:nil]lastObject];
    self.sendHanDanView.ownerViewController = self;
    self.sendHanDanView.selectedHanDankind = self.selectedHanDankind;
    self.sendHanDanView.personalHanDanDataManage = self.personalHanDanDataManage;
    
    self.sendHanDanView.frame = self.adjustView.bounds;
    [self.adjustView addSubview:self.sendHanDanView];
}

@end
