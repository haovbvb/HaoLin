//
//  JZDSec_detailViewController.m
//  HaoLin
//
//  Created by Zidon on 14-9-9.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDSec_detailViewController.h"
#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>
@interface JZDSec_detailViewController ()<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate>
{
    JZDDistance *distance;
    BOOL picExist;
    BOOL decExist;
    NSString *decString;
    NSMutableArray *picUrlArray;
    JZDModuleHttpRequest *requset;
}
@property (nonatomic,strong) NSMutableArray *picArray;
@end

@implementation JZDSec_detailViewController
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.edgesForExtendedLayout=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endCallPhone) name:UIApplicationDidBecomeActiveNotification object:nil];
    _picArray=[[NSMutableArray alloc] init];
    distance=[[JZDDistance alloc] init];
    picUrlArray=[[NSMutableArray alloc] init];
    self.navigationController.navigationBar.barTintColor=HSPBarBgColor;
    [self uiconfig];
    self.title=@"详情";
    [self sendRequest];
}

-(void)endCallPhone
{
    [_callWebView removeFromSuperview];
}

-(void)sendRequest
{
//    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    [MBProgressHUD showHUDAddedTo:win animated:YES];
    __weak JZDSec_detailViewController *wself=self;
    requset=[JZDModuleHttpRequest sharedInstace];
    JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    [requset connectionRequestUrl:[NSString stringWithFormat:DetailSec,_detailId] withJSON:^(id responeJson) {
        if (![responeJson isKindOfClass:[NSError class]]) {
            [wself addData:responeJson];
        }else{
            [wself addNoNetWork];
            [alert popAlert:@"请检查您的网络"];
        }
//        [MBProgressHUD hideAllHUDsForView:win animated:YES];
    }];
}

-(void)addNoNetWork
{
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    _bottomView.frame=CGRectMake(0, 64, CGRectGetWidth(self.view.frame),CGRectGetHeight(win.frame)-64);
    [win addSubview:_bottomView];
}

-(void)addData:(NSDictionary *)dic
{
    [self makeViewData:dic];
    [self makesection:dic];
    _personLable.text=[[dic objectForKey:@"data"] objectForKey:@"used_contacts"];
    _phoneNumber.text=[[dic objectForKey:@"data"] objectForKey:@"mobile"];
    decString=[[dic objectForKey:@"data"] objectForKey:@"used_des"];
    [_littleTable reloadData];
    if ([(NSArray *)[[dic objectForKey:@"data"] objectForKey:@"pic"] count]) {
        [self makeImage:[[dic objectForKey:@"data"] objectForKey:@"pic"]];
    }
}

-(void)makeImage:(NSMutableArray *)array
{
    for(NSDictionary *dic in array){
        [picUrlArray addObject:[dic objectForKey:@"pic_url"]];
    }
}
//查看是否有图片和描述信息
-(void)makesection:(NSDictionary *)dic
{
    if ([(NSArray *)[[dic objectForKey:@"data"] objectForKey:@"pic"] count]) {
        picExist=YES;
    }
    if ([[dic objectForKey:@"data"] objectForKey:@"used_des"]) {
        decExist=YES;
    }
    [_littleTable reloadData];
}

-(void)makeViewData:(NSDictionary *)dic
{
    _secTheme.text=[[dic objectForKey:@"data"] objectForKey:@"used_title"];
    _userName.text=[[dic objectForKey:@"data"] objectForKey:@"nickname"];
    _seenCount.text=[[dic objectForKey:@"data"] objectForKey:@"used_click_num"];
    _publishTime.text=[[dic objectForKey:@"data"] objectForKey:@"used_addtime"];
    _priceLable.text=[[dic objectForKey:@"data"] objectForKey:@"used_price"];
    if (_farwaryDouble==1.0) {
        _farwary.text=@"未知";
    }else{
        _farwary.text=[NSString stringWithFormat:@"%.2fkm",_farwaryDouble/1000];
    }
}

-(void)uiconfig
{
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor=HSPBarBgColor;
    _callPerson.buttonTitleRect=CGRectMake(-8, 35, 50, 15);
    _sendMessage.buttonTitleRect=CGRectMake(-8, 35, 50, 15);
    _callPerson.buttonImageRect=CGRectMake(0, 0, 25, 25);
    _sendMessage.buttonImageRect=CGRectMake(0, 0, 25, 25);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
//    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
//    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellOne";
        JZDImgTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"JZDImgTableViewCell" owner:self options:nil] lastObject];
        }
        cell.picArray=picUrlArray;
        [cell setItem:nil];
        return cell;
    }else{
        static NSString *cellId=@"cellTwo";
        JZDDecTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"JZDDecTableViewCell" owner:self options:nil] lastObject];
        }
        cell.desStr=decString;
        return cell;
    }
//    return nil;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"参考图片:";
    }else{
        return @"详细描述:";
    }
}
/**
 *  打电话
 */
- (IBAction)callPerson:(JZDCheckButton *)sender {
    if ([self checkDevice:@"iPhone"]) {
        NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_phoneNumber.text]];// 貌似tel://或者 tel:都行//4006207575
        [_callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.view addSubview:_callWebView];
    }else{
        JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
        [alert popAlert:@"您的设备不支持打电话"];
    }
}

//只有手机支持打电话
-(BOOL)checkDevice:(NSString*)name
{
    NSString *deviceTp = [UIDevice currentDevice].model;
    NSRange range = [deviceTp rangeOfString:name];
    return range.location != NSNotFound;
}

/**
 *  发短信
 */
- (IBAction)sendMessage:(JZDCheckButton *)sender {
    [self showSMSPicker];
}

-(void)showSMSPicker{
    //动态获取类
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass!= nil) {
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
        }else {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"设备不支持短信功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }else {
    
    }
}

-(void)displaySMSComposerSheet
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate =self;
    NSString *smsBody =[NSString stringWithFormat:@"你好,我从好邻帮看到你的%@信息，想和你详细咨询一下",_secTheme.text] ;
    picker.body=smsBody;
    picker.recipients = [NSArray arrayWithObject:_phoneNumber.text];
    [self presentViewController:picker animated:YES completion:nil];
}
//返回行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size=[decString boundingRectWithSize:CGSizeMake(302, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    if (indexPath.section==0&&picExist) {
        return 70;
    }else if(indexPath.section==1&&decExist){
        return size.height+6;
    }else{
        return 0;
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    switch (result){
        case MessageComposeResultCancelled:
            YYLog(@"Result: SMS sending canceled");
            break;
        case MessageComposeResultSent:
            YYLog(@"Result: SMS sent");
            break;
        case MessageComposeResultFailed:
            YYLog(@"Result: SMS sent");
            break;
        default:
            YYLog(@"Result: SMS not sent");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)back
{
    [_bottomView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickBtnRefrsh:(UIButton *)sender {
    [_bottomView removeFromSuperview];
    [self sendRequest];
}
@end
