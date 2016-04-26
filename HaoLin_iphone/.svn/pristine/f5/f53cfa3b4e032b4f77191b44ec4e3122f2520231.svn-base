//
//  MQLAdViewInHanDanWaitingView.m
//  HaoLin
//
//  Created by MQL on 14-10-15.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLAdViewInHanDanWaitingView.h"

@interface MQLAdViewInHanDanWaitingView ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *act;

@property (nonatomic, strong) NSMutableArray *viewsArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) CycleADScrollView *adView;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  注册通知
 */
-(void)registerNotifications;

/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag;


@end

@implementation MQLAdViewInHanDanWaitingView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[MQLHttpRequestManage instance]cancelAdInHanDanWaitingRequest];
    [self.adView invalidateTimer];
    
}

-(void)awakeFromNib
{
    [self customInitialization];
    [self registerNotifications];
}

-(void)setOwnerViewController:(UIViewController *)ownerViewController
{
    _ownerViewController = ownerViewController;
}

#pragma mark -- MQLAdViewInHanDanWaitingView
/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.viewsArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    
    MQLHttpRequestManage *httpRequestManage = [MQLHttpRequestManage instance];
    [httpRequestManage sendAdInHanDanWaitingRequest];
    [self.act startAnimating];
}

/**
 *  注册通知
 */
-(void)registerNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onReceiveNotificationOfAdInHanDanWaitingRequestOver:) name:NotificationOfAdInHanDanWaitingRequestOver object:nil];
}

-(void)onReceiveNotificationOfAdInHanDanWaitingRequestOver:(NSNotification*)notification
{
    [self.act stopAnimating];
    
    NSDictionary *userInfo = notification.userInfo;
    int code = [[userInfo objectForKey:@"code"]intValue];
    if (code == 0) {
        
        [self.viewsArray removeAllObjects];
        [self.dataArray removeAllObjects];
        
        self.dataArray = [userInfo objectForKey:@"data"];
        for (int i = 0; i < [self.dataArray count]; ++i) {
            
            NSDictionary *adItem = [self.dataArray objectAtIndex:i];
            NSURL *imgurl = [NSURL URLWithString:[adItem objectForKey:@"imgurl"]];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
            [imageView setImageWithURL:imgurl placeholderImage:nil];
            [self.viewsArray addObject:imageView];
        }
        
        self.adView = [[CycleADScrollView alloc] initWithFrame:self.bounds animationDuration:2.0];
        
        __weak MQLAdViewInHanDanWaitingView *blockSelf = self;
        self.adView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            
            return blockSelf.viewsArray[pageIndex];
            
        };
        self.adView.totalPagesCount = ^NSInteger(void){
            
            return [blockSelf.viewsArray count];
            
        };
        self.adView.TapActionBlock = ^(NSInteger pageIndex){
            
            NSLog(@"点击了第%d个",pageIndex);
            MQLAdDetailViewController *vc = [[MQLAdDetailViewController alloc]initWithNibName:@"MQLAdDetailViewController" bundle:nil];
            vc.adItem = [blockSelf.dataArray objectAtIndex:pageIndex];;
            [blockSelf.ownerViewController.navigationController pushViewController:vc animated:YES];
            
        };
        [self addSubview:self.adView];
        
        
    }else{
        
        NSString *msg = [userInfo objectForKey:@"message"];
        [self showAlertViewWithTitle:@"提示" msg:msg tag:-1];
        
    }
}

/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}




@end
