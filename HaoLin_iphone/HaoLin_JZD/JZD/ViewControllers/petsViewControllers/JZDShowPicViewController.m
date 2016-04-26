//
//  JZDShowPicViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDShowPicViewController.h"

@interface JZDShowPicViewController ()
{
    JZDModuleHttpRequest *request;
}

@end

@implementation JZDShowPicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _pageScrollView.currentPageIndex=_currentIndex;
    self.navigationController.navigationBarHidden=YES;
    request=[JZDModuleHttpRequest sharedInstace];
    [self uiconfig];
}

-(void)uiconfig
{
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    NSMutableArray *viewsArray = [@[] mutableCopy];
    for (int i = 0; i < _imageArray.count; ++i) {
        JZDImageView *groupImg = [[JZDImageView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        groupImg.image=_imageArray[i];
        [viewsArray addObject:groupImg];
    }
    _pageScrollView.blockView = ^UIView *(int pageIndex){
        return viewsArray[pageIndex];
    };
    _pageScrollView.blockNum = ^NSInteger(void){
        return viewsArray.count;
    };
    _pageScrollView.tapCountIndex = ^(int pageIndex){
        if (self.navigationController.navigationBarHidden) {
            self.navigationController.navigationBarHidden=NO;
        }else{
            self.navigationController.navigationBarHidden=YES;
        }
    };
//    JZDLoop_ScrollView *loop=[[JZDLoop_ScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
//    [loop imageArray:_imageArray];
//    [self.view addSubview:loop];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
