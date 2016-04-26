//
//  HSPPartyViewController.m
//  HaoLin
//
//  Created by PING on 14-9-3.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPPartyViewController.h"

@interface HSPPartyViewController ()

@end

@implementation HSPPartyViewController

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
    
    //添加PartyView
    [self addPartyView];
    
}


/**
 *  添加PartyView
 */
-(void)addPartyView
{
    self.navigationController.navigationBarHidden=NO;
    JZDPartyAddView *partyView=[[[NSBundle mainBundle] loadNibNamed:@"JZDPartyAddView" owner:self options:nil] lastObject];
    partyView.vc=self;
    [self.view addSubview:partyView];
}


@end
