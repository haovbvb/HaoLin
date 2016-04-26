//
//  MQLCharacterOrAudioHanDanViewController.m
//  HaoLin
//
//  Created by mac on 14-8-15.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLCharacterOrAudioHanDanViewController.h"

@interface MQLCharacterOrAudioHanDanViewController ()

@property (nonatomic, weak) IBOutlet UIView *adjustView;    //适配视图（0，-20，0，20），因为app start form ios7, 所以该引用备用
@property (nonatomic, strong) MQLCharacterOrAudioHanDanView *characterOrAudioHanDanView;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加CharacterOrAudioHanDanView
 */
-(void)addCharacterOrAudioHanDanView;


@end

@implementation MQLCharacterOrAudioHanDanViewController

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
    
    //添加CharacterOrAudioHanDanView
    [self addCharacterOrAudioHanDanView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- MQLCharacterOrAudioHanDanViewController函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.view.backgroundColor = MQLBGColor;
    
}

/**
 *  添加CharacterOrAudioHanDanView
 */
-(void)addCharacterOrAudioHanDanView
{
    self.characterOrAudioHanDanView = [[[NSBundle mainBundle]loadNibNamed:@"MQLCharacterOrAudioHanDanView" owner:nil options:nil]lastObject];
    
    self.characterOrAudioHanDanView.ownerViewController = self;
    self.characterOrAudioHanDanView.selectedHanDankind = self.selectedHanDankind;
    self.characterOrAudioHanDanView.frame = self.adjustView.bounds;
    [self.adjustView addSubview:self.characterOrAudioHanDanView];
}

-(void)registerForKeyboardNotificationsAgain
{
    [self performSelector:@selector(delayRegisterForKeyboardNotificationsAgain) withObject:self afterDelay:0.2];
}

-(void)delayRegisterForKeyboardNotificationsAgain
{
    [self.characterOrAudioHanDanView registerForKeyboardNotifications];
}

@end
