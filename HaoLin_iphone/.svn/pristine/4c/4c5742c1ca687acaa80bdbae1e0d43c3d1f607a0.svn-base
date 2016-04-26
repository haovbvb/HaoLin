//
//  MQLAdDetailView.m
//  HaoLin
//
//  Created by MQL on 14-10-14.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLAdDetailView.h"

@interface MQLAdDetailView ()<UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *navView;
@property (nonatomic, weak) IBOutlet UILabel *titleLab;
@property (nonatomic, weak) IBOutlet UIButton *reloadBtn;
@property (nonatomic, weak) IBOutlet UIWebView *detailWebView;


-(IBAction)backBtnClicked:(id)sender;
-(IBAction)reloadBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  加载在线html页面
 */
-(void)loadOnlinePage;

/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag;

@end

@implementation MQLAdDetailView

-(void)awakeFromNib
{
    [self performSelectorInBackground:@selector(customInitialization) withObject:nil];
}

-(void)setOwnerViewController:(UIViewController *)ownerViewController
{
    _ownerViewController = ownerViewController;
    
}

-(void)setAdItem:(NSDictionary *)adItem
{
    _adItem = adItem;
    
    self.titleLab.text = [adItem objectForKey:@"name"];
    [self loadOnlinePage];

}

#pragma mark -- MQLAdDetailView函数扩展

-(IBAction)backBtnClicked:(id)sender
{
    [self.ownerViewController.navigationController popViewControllerAnimated:YES];
}

-(IBAction)reloadBtnClicked:(id)sender
{
    self.reloadBtn.hidden = YES;
    [self loadOnlinePage];
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.navView.backgroundColor = BGOrangeColor;
    
    if (IS_IPHONE_5) {
        
        CGRect frame = self.reloadBtn.frame;
        frame.origin = CGPointMake(110, 202 - 20);
        self.reloadBtn.frame = frame;
        
    }else{
        
        CGRect frame = self.reloadBtn.frame;
        frame.origin = CGPointMake(110, 158 -20);
        self.reloadBtn.frame = frame;
    }
}

/**
 *  加载在线html页面
 */
-(void)loadOnlinePage
{
    self.detailWebView.hidden = NO;
    [MBProgressHUD showHUDAddedTo:self.detailWebView animated:YES];
    
    NSURL *url = [NSURL URLWithString:[_adItem objectForKey:@"clickurl"]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.detailWebView loadRequest:request];
    
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

#pragma mark-- UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.detailWebView animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    if([error code] == NSURLErrorCancelled)
    {
        return;
        
    }else{
        
        [MBProgressHUD hideHUDForView:self.detailWebView animated:YES];
        self.detailWebView.hidden = YES;
        self.reloadBtn.hidden = NO;
        
        NSString *msg = @"请检查网络是否通畅.";
        [self showAlertViewWithTitle:@"提示" msg:msg tag:-1];
    }
    
}


@end
