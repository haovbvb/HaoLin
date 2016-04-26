//
//  MDLSingleView.m
//  HAOLINAPP
//
//  Created by apple on 14-8-9.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//  商家 - 抢单页面

#import "MDLSinglesView.h"

@interface MDLSinglesView()<UITableViewDataSource,UITableViewDelegate>
{
    MDLQiangdanliebiao *liebiao;

}

@end

@implementation MDLSinglesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

-(void)awakeFromNib
{

    liebiao=[[MDLQiangdanliebiao alloc]init];
    
//    _QDinfosarry =[[NSMutableArray alloc]init];
//    _QDaudioarry=[[NSMutableArray alloc]init];
//    _QDpricearry=[[NSMutableArray alloc]init];
//    _QDaddressarry=[[NSMutableArray alloc]init];
//    _QDtypearry=[[NSMutableArray alloc]init];
//    _QDuseraxisarry=[[NSMutableArray alloc]init];
 
    _QDarry =[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    NSMutableArray *rray=[_QDarry copy];

//    NSMutableArray *audioarry   =[_QDinfosarry copy];
//    NSMutableArray *pricearry   =[_QDaudioarry copy];
//    NSMutableArray *addressarry =[_QDpricearry copy];
//    NSMutableArray *typearry    =[_QDaddressarry copy];
//    NSMutableArray *useraxisarry=[_QDuseraxisarry copy];

    //抢单视图初始化
    _Qdview =[[[NSBundle mainBundle]loadNibNamed:@"MDQiangdanView" owner:self options:nil]lastObject];
    _Qdview.frame=CGRectMake(0,10, KDeviceWidth,_Qdview.frame.size.height);
    [self.singscrollview addSubview:_Qdview];
    
    _Qdview.timerLable.text=[rray objectAtIndex:0];
/*
    _Qdview.DistributionMoneyLable.text=[pricearry objectAtIndex:0];
    _Qdview.AddressLable.text          =[addressarry objectAtIndex:0];
    _Qdview.NeirongLable.text          =[audioarry objectAtIndex:0];
*/

//**************************
    
    if (DEVICE_IS_IPHONE5) {
        self.singscrollview.contentSize = CGSizeMake(320, 480*1.4);
    }else{
        self.singscrollview.contentSize = CGSizeMake(320, 480*1.5);
    }
    self.singscrollview.scrollEnabled = YES;
    
//**************************
    self.backgroundColor=BGColor;
    
    //布置数据列表视图
    [self showview];
    
    //通知的私有方法
    [self NotificationCenter];
    
}

-(void)NotificationCenter
{
    //让键盘出现时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:@"Notification"
                                               object:nil];
    //键盘消失时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopinputnotification)
                                                 name:@"EndinputNotification"
                                               object:nil];
    
    //点击cell的时候 立即抢单界面回原位
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(huiyuanwei)
                                                 name:@"yuanweiNotificationCenter"
                                               object:nil];
    

}

- (IBAction)fanhuiback:(id)sender {
    
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定退出抢单界面吗？退出将会终止抢单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    
    [aler show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pophomview" object:nil];
    }
}
//singscrollview回原位通知方法
-(void)huiyuanwei
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.singscrollview.contentOffset=CGPointMake(0, 0);
    [UIView commitAnimations];

}

//键盘出现时调用
-(void)keyboardWillShow
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGRect frames = self.frame;
    frames.origin.y = -65;
    self.frame = frames;
    [UIView commitAnimations];
}

//键盘回收时调用
-(void)stopinputnotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGRect frames = self.frame;
    frames.origin.y = 0;
    self.frame = frames;
    [UIView commitAnimations];
}

//初始化界面
-(void)showview

{
//    [_Qdview.StopButton addTarget:self action:@selector(delegatecell:) forControlEvents:UIControlEventTouchUpInside];
    
    self.informationtableView=[[UITableView alloc]init];
    _informationtableView.BackgroundColor=[UIColor redColor];
    
    if (DEVICE_IS_IPHONE5) {
        self.informationtableView.frame=CGRectMake(0,20+_Qdview.frame.size.height, KDeviceWidth,KDeviceHeight-200);
    }else{
        self.informationtableView.frame=CGRectMake(0, 20+_Qdview.frame.size.height, KDeviceWidth,KDeviceHeight-150);
    }
    
    _informationtableView.delegate = self;
    _informationtableView.dataSource =self;
    
    [self.singscrollview addSubview:_informationtableView];

}
//立即抢单 结束 按钮
-(void)delegatecell:(UIButton *)sender
{
    if (sender.tag==[_QDarry count]) {
        nil;
    }else{
        NSUInteger tag1=sender.tag;
        [_QDarry removeObjectAtIndex:tag1];
        [self.informationtableView reloadData];
        //    _Qdview.timerLable.text=[_QDarry objectAtIndex:tag1++];
        //    _Qdview.DistributionMoneyLable.text=[_QDarry objectAtIndex:tag1++];
        _Qdview.timerLable.text=[_QDarry objectAtIndex:tag1];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 2.0f;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [self.Qdview exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        [self.Qdview.layer addAnimation:transition forKey:@"animation"];
    }
    

}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.QDarry.count;
//    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //     MDLinformationTableViewCell *cell = [self tableView:_informationtableView cellForRowAtIndexPath:indexPath] ;
    //    MDLinformationTableViewCell *cell;
    //    return cell.frame.size.height;
    return 120;
}
//绘制单元格
-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"MDLinformationTableViewCell";
    
    MDLinformationTableViewCell *cell = (MDLinformationTableViewCell *)[_informationtableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MDLinformationTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    cell.timelable.text=[_QDarry objectAtIndex:indexPath.row];
    [cell.stopbutton addTarget:self action:@selector(deletecell:) forControlEvents:UIControlEventTouchUpInside];
    cell.stopbutton.tag     =indexPath.row;                        //秒数
  
/*
    cell.contentLale.text   =[liebiao.callinfos objectAtIndex:indexPath.row];                              //配送内容
    cell.addressLable.text  =[liebiao.deliveryaddress objectAtIndex:indexPath.row];                              //配送地址
    cell.surchargeLable.text=[liebiao.serverprice objectAtIndex:indexPath.row];                              //配送费
*/
    return cell;
}
-(void)deletecell:(UIButton *)sender
{
    NSUInteger tag=sender.tag;
    [_QDarry removeObjectAtIndex:tag];
    [self.informationtableView reloadData];
    
}
- (void)tableView:(UITableView *)sender didSelectRowAtIndexPath:(NSIndexPath *)path {
    
    //点击cell的时候 界面回立即抢单界面回原位
    [[NSNotificationCenter defaultCenter]postNotificationName:@"yuanweiNotificationCenter" object:nil];
    //取到cell的内容
    MDLinformationTableViewCell *cell=(MDLinformationTableViewCell *)[_informationtableView cellForRowAtIndexPath:path];
    
    NSInteger row=[path row];
//    _Qdview.StopButton.tag=row;
    _Qdview.DistributionMoneyLable.text=[NSString stringWithFormat:@"%d",row];
    ;
    _Qdview.timerLable.text=cell.timelable.text;
    
    
    
}

@end
