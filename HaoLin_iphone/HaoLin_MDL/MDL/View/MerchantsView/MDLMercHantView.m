//
//  MDLMercHantView.m
//  HAOLINAPP
//
//  Created by apple on 14-8-10.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//  商家 - 首页View

#import "MDLMercHantView.h"
#import <AVFoundation/AVFoundation.h>

@interface MDLMercHantView () {
    
    MDLSuccessfulView         *succes;
    MDLFailureView            *failure;
    MDLSinglesView            *singlesview;
    MDLDengluyeViewController *dengluvc;
    MDLNetworkservice         *service;
    MDLbasicdataobj           *basicdataobj;
    MDLleidaview              *leidaview;
    MDQiangdanView            *Qdview;
    UIView                    *yinyingview;
    NSMutableArray            *Notifyarry;
    NSMutableArray            *submitarry;
    MDLLiebiaoViewController  *liebiaoVC;
    MDLAudioFile              *audifile;
    AVAudioPlayer             *player;
    MDLMapViewController      *mapvc;
    int                       timenum;
    
    ZYPLoginStateView         *stateView;
    AVAudioPlayer             *audioPlay;
    NSString                  *wavpath;
    
    
    CGFloat                   cellheight;
    NSTimer                   *counttime;
    HSPAccount                *account;
    
    NSTimer                   *lishiTimer;
    
}

@property (nonatomic,strong) NSMutableArray *lisarry;
@property (nonatomic,copy)   NSString       *filepath;
@property (nonatomic,strong) NSMutableArray *merchdataarry;
@property (nonatomic,assign) NSInteger      timercount;
@property (nonatomic,strong) NSString       *timerstate;
@property (nonatomic,strong) NSMutableArray *timearray;
@property (nonatomic,assign) BOOL makeSureOneLoadIdentifier;

@property (nonatomic,strong) NSMutableArray *merchdataarry1;

@property (nonatomic, strong)NSMutableArray *linshiArray;
@property (nonatomic,copy)   NSString       *indentifierSTR;
@property (nonatomic, strong)NSMutableArray *linshiTimeArray;


@end

@implementation MDLMercHantView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)stal
{
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"MDLshangjiazhongxin@2x"] forState:(UIControlStateNormal)];
    self.backgroundColor                =BGColor;
    self.navgaionbarview.backgroundColor=MDLBGColor;
}
- (void)linshiCount:(NSTimer *)timer
{
    if (self.linshiTimeArray.count == 0)
    {
        [lishiTimer invalidate];
    }else if (self.linshiTimeArray.count > 0)
    {
        for (MDLOrderTimeObject *timeobj in self.linshiTimeArray)
        {
            if (timeobj.timercount <= 0)
            {
                timeobj.timercount = 0;
                timeobj.timerstate = @"订单已过期";
                
            }else
            {
                timeobj.timercount--;
            }
        }
    }
}
-(void)awakeFromNib
{
    [_merchdataarry removeAllObjects];
    [_lisarry       removeAllObjects];
    
    self.linshiArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.indentifierSTR = @"OK";
    self.linshiTimeArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    lishiTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(linshiCount:) userInfo:nil repeats:YES];
    
    JZDPushSingl *s=[JZDPushSingl sharedInstance];
    NSLog(@"%@",s);
    liebiaoVC      =[[MDLLiebiaoViewController alloc] initWithNibName:@"MDLLiebiaoViewController" bundle:nil];
    mapvc =[[MDLMapViewController alloc]init];
    
    [self stal];
    
    //  创建提示view
    stateView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPLoginStateView" owner:self options:nil] lastObject];
    
    /**
     *  适配
     */
    if (IS_IPHONE_5)
    {
        self.frame = CGRectMake(0, 0, 320, 568);
        stateView.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.frame = CGRectMake(0, 0, 320, 480);
        stateView.frame = CGRectMake(0, 0, 320, 480);
    }
    
    audifile       =[[MDLAudioFile alloc]init];
    //请求网络单例
    service        =[MDLNetworkservice shareservice];
    //参数相关单例
    basicdataobj   =[MDLbasicdataobj sharebasicdataobj];
    
    /**
     * _merchdataarry :主列表数据
     * _lisarry       :待确认数据
     * _timearray     :单元格计时器数组
     * submitarry     :选择后的商品
     * Notifyarry     :提交订单反回
     */
    
    _timearray     =[[NSMutableArray alloc] initWithCapacity:0];
    submitarry     =[[NSMutableArray alloc] initWithCapacity:0];
    _lisarry       =[[NSMutableArray alloc] initWithCapacity:0];
    _merchdataarry =[[NSMutableArray alloc] initWithCapacity:0];
    Notifyarry     =[[NSMutableArray alloc] initWithCapacity:0];
    
    /**
     *  通知相关
     */
    [self pushNotificationCenter];
    /*
     **
     ****雷达视图****初始化视图*****
     **
     */
    [self initwithviews];
    /**
     *  视图层次关系
     */
    [self bringSubviewToFront:Qdview];
    [self bringSubviewToFront:self.navgaionbarview];
    [self bringSubviewToFront:succes];
    [self bringSubviewToFront:failure];
    
    [self moduleview];
    
    //    [self performSelectorInBackground:@selector(mulstzhread) withObject:nil];
    counttime =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAchtion:) userInfo:nil repeats:YES];
    [counttime fire];
    
    [self reloadtableview];
    self.makeSureOneLoadIdentifier = YES;
}

/**
 *  首页雷达
 */

-(void)drawRect:(CGRect)rect
{
    leidaview=[[MDLleidaview alloc]initWithFrame:CGRectMake(0, NVBARHeight, KDeviceWidth, 120)];
    
    leidaview.backgroundColor=BGColor;
    [self addSubview:leidaview];
    [self sendSubviewToBack:leidaview];
    //    [leidaview.avbutton addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)didMoveToWindow
{
    [leidaview removeFromSuperview];
    [self setNeedsDisplay];
}

#pragma mark ----通知----


/**
 *  审核通过或者失败，接收的通知的方法
 */
- (void)changeState:(NSNotification *)no
{
    //  模拟数据
    NSDictionary *dic = no.userInfo;
    account = [HSPAccountTool account];
    if ([[dic objectForKey:@"code"] intValue] == 0)
    {
        account.user_mark = @"2";
    }else if ([[dic objectForKey:@"code"] intValue] == 1)
    {
        account.user_mark = @"3";
    }
    [self login];
}
-(void)pushNotificationCenter
{
    //商家通知 （亚鹏）审核通过或者失败，接收的通知
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(changeState:)
                                                  name:@"changeState"
                                                object:nil];
    //商家通知 （亚鹏）商家退出登录获得的通知
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(login)
                                                  name:@"logout"
                                                object:nil];
    //选择商品通知
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector (mytestNot:)
                                                  name:@"LBviewtext"
                                                object:nil];
    //提交订单返回数据
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector (Notmessage:)
                                                  name:MesGeNotification
                                                object:nil];
    //push到选择界面
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector (pushxzVC)
                                                  name:@"pushSZVC"
                                                object:nil];
    //获取到数据的通知
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector (AccessData:) name:BtainNotification
                                                object:nil];
    //push到地图页面
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector (pushMAPVC)
                                                  name:@"pushMapVC"
                                                object:nil];
    /**
     *  亚鹏测试
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDat:) name:@"取消" object:nil];
    
}
- (void)reloadDat:(NSNotification *)no
{
    if (self.linshiArray.count == 0) {
        [self reloadtableview];
    }else if (self.linshiArray.count > 0)
    {
        for (int i = 0; i < self.linshiArray.count; i++)
        {
            [_merchdataarry insertObject:[self.linshiArray objectAtIndex:i] atIndex:0];
            [_timearray insertObject:[self.linshiTimeArray objectAtIndex:i] atIndex:0];
        }
        [self reloadtableview];
        [self.linshiArray removeAllObjects];
        [self.linshiTimeArray removeAllObjects];
    }
}
/**
 *  抢单提交
 *
 *  @param notification 提交商品的通知 * 内容数组
 */
- (void)mytestNot:(NSNotification*) notification
{
    NSMutableArray *textarry=[notification object];
    NSMutableArray *dataarry=[[NSMutableArray alloc]init];
    float sum=0.0;
    for (int i = 0; i <textarry.count ; i ++) {
        MDLgoodsdata *goods = [textarry objectAtIndex:i];
        NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:goods.goodsname,@"goods_name",goods.goodsid,@"goods_id",goods.goodsprice,@"goods_price",goods.goodsnum,@"goods_num", nil];
        if (goods.goodsnum==nil) {
            goods.goodsnum=@"1";
        }if (goods.goodsprice) {
            NSLog(@"没有价格的商品你也敢要！");
        }
        float  A =[goods.goodsprice floatValue];
        float  B =[goods.goodsnum floatValue];
        float  C = A*B;
        sum+=C;
        [submitarry addObject:dic];
        NSLog(@"选定后要提交的数据%@",dataarry);
    }
    if ([account.range_type isEqualToString:@"1"]) {
        Qdview.TotalPicLable.text=[NSString stringWithFormat:@"%.2f元",sum];
        Qdview.xuanzeneirong.text=@" 商品已录入";
        Qdview.xuanzeneirong.textColor=[UIColor redColor];
    }if ([account.range_type isEqualToString:@"2"]) {
        Qdview.TotalPicLable.text=@"价格面议";
        
    }
    NSLog(@"要提交的数据%@",submitarry);
}

/**
 *  登陆模块视图
 */
-(void)moduleview
{
    [self login];
}
/**
 *  判断登陆状态方法
 */
- (void)login
{
    for (UIView * view in self.subviews)
    {
        if ([view isKindOfClass:[ZYPLoginStateView class]])
        {
            [view removeFromSuperview];
            [_merchdataarry removeAllObjects];
            [_lisarry       removeAllObjects];
            [self reloadtableview];
        }
    }
    account = [HSPAccountTool account];
    if ([account.user_id length] > 0)
    {
        if ([account.user_mark intValue] == 0)
        {
            stateView.dianhuaBTN.hidden = YES;
            stateView.lineLabel. hidden = YES;
            stateView.imageView. hidden = NO;
            [stateView.loginBtn setTitle:@"马上提交资料" forState:UIControlStateNormal];
            
            NSString *str = @"    你尚未提交商家审核资料,提交后才能使用商家提供的功能,马上去提交吧";
            CGFloat height = [self heightOfLabelFromString:str];
            stateView.tishiLabel.frame = CGRectMake(40, 190, 240, height);
            stateView.tishiLabel.text = str;
            
            stateView.loginBtn.hidden = NO;
            [stateView.loginBtn addTarget:self action:@selector(dengluba) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:stateView];
            
        }else if ([account.user_mark intValue] == 1)
        {
            /**
             *  判断审核是否通过，有一个借口，还欠一个3
             */
            NSString *str = @"    您提交的审核资料好邻已经收到,请耐心等待审核,您现在可以使用普通用户功能,如有疑问请拨打下方电话";
            CGFloat height = [self heightOfLabelFromString:str];
            stateView.tishiLabel.frame = CGRectMake(40, 190, 240,height );
            stateView.tishiLabel.text = str;
            
            stateView.loginBtn.hidden   = YES;
            stateView.imageView.hidden  = YES;
            stateView.dianhuaBTN.hidden = NO;
            [stateView.dianhuaBTN addTarget:self action:@selector(callHaoLin:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:stateView];
            
        }else if ([account.user_mark intValue] == 2)
        {
            [stateView   removeFromSuperview];
            [_merchdataarry removeAllObjects];
            
            [self reloadtableview];
            
        }else if ([account.user_mark intValue] == 3)
        {
            /**
             *  提交审核失败
             */
            stateView.dianhuaBTN.hidden = YES;
            stateView.lineLabel. hidden = YES;
            stateView.imageView. hidden = NO;
            [stateView.loginBtn setTitle:@"再次提交资料" forState:UIControlStateNormal];
            NSString *str = @"    你提交的审核资料被驳回啦,可能您提交的信息有错,请检查提交的信息并且再次提交资料";
            CGFloat height = [self heightOfLabelFromString:str];
            stateView.tishiLabel.frame = CGRectMake(40, 190, 240, height);
            stateView.tishiLabel.text = str;
            
            stateView.loginBtn.hidden = NO;
            [stateView.loginBtn addTarget:self action:@selector(dengluba) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:stateView];
            
            [_lisarry removeAllObjects];
        }
    }else if ([account.user_id length]== 0)
    {
        [_lisarry       removeAllObjects];
        [_merchdataarry removeAllObjects];
        stateView.tishiLabel.textAlignment = NSTextAlignmentCenter;
        stateView.dianhuaBTN.hidden  = YES;
        stateView.lineLabel.hidden   = YES;
        stateView.loginBtn.hidden    = NO;
        stateView.imageView.hidden   = NO;
        stateView.tishiLabel.text = @"您尚未登陆,赶快登陆体验吧";
        [stateView.loginBtn setTitle:@"马上登录" forState:UIControlStateNormal];
        [stateView.loginBtn addTarget:self action:@selector(dengluba) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:stateView];
    }
}
/**
 *
 * Lable 自适应
 */
- (CGFloat)heightOfLabelFromString:(NSString *)text
{
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    CGSize size1 = [text boundingRectWithSize:CGSizeMake(240, 0) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    return size1.height;
}
- (void)callHaoLin:(UIButton *)btn
{
    /**
     *  判断设备是否支持打电话功能
     */
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==  UIUserInterfaceIdiomPhone)
    {
        /**
         *   打电话
         :returns:
         */
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",btn.titleLabel.text];
        UIWebView *webView = [[UIWebView alloc] init];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self addSubview:webView];
    }else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"此设备暂不支持打电话" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark -- 抢单限制 计时器

-(void)timerAchtion:(NSTimer *)timer
{
    if (Qdview.testInt) {
        Qdview.testInt--;
        YYLog(@"%d",Qdview.testInt);
    }
    for (MDLOrderTimeObject *timeobj in self.timearray)
    {
        if (timeobj.timercount <= 0) {
            timeobj.timercount = 0;
            timeobj.timerstate = @"订单已过期";
            
        }else
        {
            timeobj.timercount--;
        }
    }
    //    if ([_timearray count]>0) {
    //        [counttime setFireDate:[NSDate distantPast]];
    //    }else {
    //        [counttime setFireDate:[NSDate distantFuture]];
    //    }
}

#pragma mark   创建view视图

/**
 *  抢单视图
 */
-(void)singview
{
    
    yinyingview=[[UIView alloc]initWithFrame:CGRectMake(0, 65, KDeviceWidth, KDeviceHeight)];
    yinyingview.backgroundColor=[UIColor blackColor];
    yinyingview.alpha=0.6;
    [self addSubview:yinyingview];
    yinyingview.hidden=YES;
    
    //抢单视图初始化
    Qdview =[[[NSBundle mainBundle]loadNibNamed:@"MDQiangdanView" owner:self options:nil]lastObject];
    Qdview.frame=CGRectMake(0,-320, KDeviceWidth,Qdview.frame.size.height);
    [Qdview.quxiaobtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [Qdview.JixuQiangdanButton addTarget:self action:@selector(LijiQiangDan:) forControlEvents:UIControlEventTouchUpInside];
    [Qdview.YuyinButton addTarget:self action:@selector(audiobtn:) forControlEvents:UIControlEventTouchUpInside];
    Qdview.backgroundColor=[UIColor whiteColor];
    [self addSubview:Qdview];
    [Qdview.xuanzebutton addTarget:Qdview action:@selector(pushxz:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)pushxz:(UIButton *)sender
{
}
-(void)reloadtableview
{
    [_informationtableView reloadData];
}

/**
 *  初始化界面 * 表示图 ..
 */
-(void)initwithviews
{
    self.informationtableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _informationtableView.BackgroundColor=[UIColor clearColor];
    
    if (DEVICE_IS_IPHONE5) {
        self.informationtableView.frame=CGRectMake(0,NVBARHeight+120, KDeviceWidth,KDeviceHeight-230);
    }else{
        self.informationtableView.frame=CGRectMake(0, NVBARHeight+120, KDeviceWidth,KDeviceHeight-230);
    }
    
    _informationtableView.delegate   = self;
    _informationtableView.dataSource = self;
    
    [self addSubview:_informationtableView];
    
    [self singview];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_merchdataarry count]>0) {
        return [_merchdataarry count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat contentLaleheight=[self heightOfLabelString:[[_merchdataarry objectAtIndex:indexPath.row]objectForKey:@"call_infos"]];
    CGFloat addressLaleheight=[self heightOfLabelString:[[_merchdataarry objectAtIndex:indexPath.row]objectForKey:@"delivery_address"]];
    if (contentLaleheight == 0 ) {
        contentLaleheight = 30;
        return 30+addressLaleheight+84;
    }else
        return contentLaleheight+addressLaleheight+84;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MDLinformationTableViewCell";
    MDLinformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MDLinformationTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    
    CGFloat contentLaleheight=[self heightOfLabelString:[[_merchdataarry objectAtIndex:indexPath.row]objectForKey:@"call_infos"]];
    CGFloat addressLaleheight=[self heightOfLabelString:[[_merchdataarry objectAtIndex:indexPath.row]objectForKey:@"delivery_address"]];
    if ([[[_merchdataarry objectAtIndex:indexPath.row]objectForKey:@"call_type"]isEqualToString:@"1"]) {
        cell.voicebutton.enabled=YES;
        cell.contentLale.frame=CGRectMake(82, 36, 228,30);
        cell.contentLale.text=@"无文字内容,请点语音喇叭";
        cell.contentLale.textColor=[UIColor redColor];
        cell.addressLable.frame=CGRectMake(82,40 + 30, 230, addressLaleheight);
        cell.addsLable.frame=CGRectMake(8, 30+38, 230, 30);
        cell.peisongpicLable.frame=CGRectMake(8,30+ addressLaleheight +40 + 4, 66, 31);
        cell.surchargeLable.frame=CGRectMake(74,30+ addressLaleheight +40 + 4, 66, 31);
        cell.bianxianimage.frame=CGRectMake(0,30+ addressLaleheight + 32 + 34+4+4, KDeviceWidth, 10);
        
    }else{
        cell.contentLale.textColor=[UIColor blackColor];
        cell.contentLale.text=[[_merchdataarry objectAtIndex:indexPath.row]objectForKey:@"call_infos"];
        cell.voicebutton.enabled=NO;
        cell.contentLale.frame=CGRectMake(82, 36, 228,contentLaleheight);
        cell.addressLable.frame=CGRectMake(82,40 + contentLaleheight, 230, addressLaleheight);
        cell.addsLable.frame=CGRectMake(8, contentLaleheight+38, 230, 30);
        cell.peisongpicLable.frame=CGRectMake(8,contentLaleheight+ addressLaleheight +40 + 4, 66, 31);
        cell.surchargeLable.frame=CGRectMake(74,contentLaleheight+ addressLaleheight +40 + 4, 66, 31);
        cell.bianxianimage.frame=CGRectMake(0,contentLaleheight+ addressLaleheight + 32 + 34+4+4, KDeviceWidth, 10);
    }
    
    if ([_merchdataarry count] > 0) {
        //        refreshview.hidden=YES;
        MDLOrderTimeObject *timeobj=[self.timearray objectAtIndex:indexPath.row];
        cell.time=timeobj.timercount;
        
        cell.timelable.text=[self ordertime:[[_merchdataarry objectAtIndex:indexPath.row] objectForKey:@"createtime"]];
        
        cell.addressLable.text=[[_merchdataarry objectAtIndex:indexPath.row]objectForKey:@"delivery_address"];
        cell.surchargeLable.text=[NSString stringWithFormat:@"%@元",[[_merchdataarry objectAtIndex:indexPath.row] objectForKey:@"server_price"]];
        [cell.voicebutton addTarget:self action:@selector(audiobtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.voicebutton.tag=indexPath.row;
        
    }else{
        NSLog(@"没有订单");
    }
    return cell;
}
- (void)tableView:(UITableView *)sender didSelectRowAtIndexPath:(NSIndexPath *)path
{
    MDLinformationTableViewCell *cell=(MDLinformationTableViewCell *)[_informationtableView cellForRowAtIndexPath:path];
    NSString *Axisstr=[NSString stringWithFormat:@"%@",[[_merchdataarry objectAtIndex:path.row]objectForKey:@"user_axis"]];
    NSString *Addressstr=[[_merchdataarry objectAtIndex:path.row] objectForKey:@"delivery_address"];
    NSDictionary *Axisdic=@{@"axis":Axisstr,@"address":Addressstr};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserAxis" object:Axisdic];
    /**
     *  以下是抢单相关数据
     */
    NSInteger row=[path row];
    Qdview.NeirongLable.text = cell.contentLale.text;
    if ([[[_merchdataarry objectAtIndex:path.row]objectForKey:@"call_type"]isEqualToString:@"1"]) {
        Qdview.NeirongLable.textColor=[UIColor redColor];
        Qdview.YuyinButton.enabled=YES;
        
    }else{
        Qdview.YuyinButton.enabled=NO;
        Qdview.NeirongLable.textColor=[UIColor blackColor];
    }
    MDLOrderTimeObject *timeobj=[self.timearray objectAtIndex:path.row];
    Qdview.AddressLable.text = cell.addressLable.text;
    Qdview.DistributionMoneyLable.text = cell.surchargeLable.text;
    Qdview.YuyinButton.       tag = row;
    Qdview.JixuQiangdanButton.tag = row;
    Qdview.MapButton.         tag = row;
    if ([account.range_type isEqualToString:@"1"]) {
        Qdview.TotalPicLable    .text = @"0元";
        Qdview.xuanzeneirong    .text = nil;
        Qdview.xuanzebutton.enabled   =YES;
    }if ([account.range_type isEqualToString:@"2"]) {
        Qdview.xuanzeneirong.text     = @" 无商品";
        Qdview.xuanzebutton.enabled   = NO;
        Qdview.TotalPicLable    .text = @"价格面议";
    }
    Qdview.testInt=timeobj.timercount;
    
    //    if (timeobj.timercount >0) {
    Qdview.timerLable.text=@"抢单中...";
    //    }else {
    //        Qdview.timerLable.text=timeobj.timerstate;
    //    };
    if (timeobj.timercount >0) {
        //        Qdview.timerLable.text= [NSString stringWithFormat:@"%d", cell.time];
        //        Qdview.timerLable.text=[NSString stringWithFormat:@"%d",timeobj.timercount];
        Qdview.timerLable.text=@"抢单进行中...";
        
    }else {
        
        Qdview.timerLable.text=timeobj.timerstate;
    };
    
    BOOL T=YES;
    if (T==YES) {
        yinyingview.backgroundColor=[UIColor blackColor];
        yinyingview.hidden=NO;
    }
    [self QdviewAnimations];
    self.indentifierSTR = @"OFF";
    
    [lishiTimer fire];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_merchdataarry removeObjectAtIndex:indexPath.row];
        [_timearray     removeObjectAtIndex:indexPath.row];
        [_informationtableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if ([_merchdataarry count]==0) {
        }
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}
- (CGFloat)heightOfLabelString:(NSString *)text
{
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    CGSize LBsize = [text boundingRectWithSize:CGSizeMake(228, 0) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    return LBsize.height;
}
#pragma mark -tableview delegate End-

#pragma mark 私有方法

-(NSString*)ordertime:(NSString *)time
{
    /**
     * 时间戳转换
     */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSDate *timedate = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSString *timedata = [formatter stringFromDate:timedate];
    return timedata;
}

#pragma mark  ----点击事件----

/**
 *  音频文件的播放
 *
 *  @param btn 播放音频
 */

-(void)audiobtn:(UIButton *)btn
{
    NSInteger index=btn.tag;
    if ([_merchdataarry count] > 0) {
        self.filepath=[[_merchdataarry objectAtIndex:index]objectForKey:@"audio"];
        if (self.filepath ==nil){
            JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
            [alert popAlert:@"没有声音信息"];
        }else{
            Reachability * rp = [Reachability reachabilityWithHostName:@"www.baidu.com"];
            if (rp.currentReachabilityStatus == NotReachable)
            {
                JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
                [alert popAlert:@"无网络"];
                
            }else{
                
                if ([self.filepath hasSuffix:@".amr"])
                {
                    if (self.makeSureOneLoadIdentifier == YES) {
                        NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
                            self.makeSureOneLoadIdentifier = NO ;
                            [self load:[NSURL URLWithString:self.filepath]];
                        }];
                        [operation2 start];
                    }
                }else
                {
                    JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
                    [alert popAlert:@"无声音"];
                    
                }
            }
        }
    }else{
        JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
        [alert popAlert:@"没有声音信息"];
    }
}
/**
 *  下载音频文件
 *
 *  @param url 下载url
 */
- (void)load:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    /**
     *  下载音频临时文件
     */
    //    __weak MDLMercHantView *handanView = self;
    NSURLSessionDownloadTask *downSession = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
                                             {
                                                 if (!error) {
                                                     
                                                     /**
                                                      *  将临时文件存储到本地
                                                      */
                                                     NSString *path = NSTemporaryDirectory();
                                                     NSString *pathString = [path stringByAppendingString:response.suggestedFilename];
                                                     NSURL *newFileLocation =[NSURL fileURLWithPath:pathString];
                                                     [[NSFileManager defaultManager] copyItemAtURL:location toURL:newFileLocation error:nil];
                                                     [self getChangeFormat:pathString];
                                                 }else
                                                 {
                                                     self.makeSureOneLoadIdentifier = YES;
                                                 }
                                             }];
    [downSession resume];
}
/**
 *  转换格式后播放本地文件
 */
- (void)getChangeFormat:(NSString *)path
{
    /**
     *  本地文件存在，就从本地读取
     */
    if ([path hasSuffix:@".amr"])
    {
        /**
         *  将amr文件转化成wav格式
         */
        wavpath = [path stringByReplacingOccurrencesOfString:@".amr" withString:@".wav"];
        [MQLAudioManage encodeToWav:wavpath fromAmr:path];
        NSLog(@"%@",[NSData dataWithContentsOfFile:wavpath]);
        /**
         *  播放本地音频
         */
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        NSURL*url = [NSURL fileURLWithPath:wavpath];
        audioPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:url  error:nil];
        NSBlockOperation *operation1 =[NSBlockOperation blockOperationWithBlock:^{
            [audioPlay play];
            self.makeSureOneLoadIdentifier=YES;
        }];
        [operation1 start];
    }
}
/**
 *  抢单界面
 *
 *  @param sender 立即抢单点击方法
 */
- (void)LijiQiangDan:(UIButton *)sender {
    
    if ([account.range_type isEqualToString:@"1"]) {
        
        if ([submitarry count]>0) {
            
            NSString *Talkid =[NSString stringWithFormat:@"%@",[[_merchdataarry objectAtIndex:sender.tag] objectForKey:@"talk_id"]];
            NSDictionary *dic= @{@"talk_id": Talkid,@"goods_info":submitarry};
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfSendToBusiness object:MDLCommit userInfo:dic];
            
            NSInteger  Mtag =sender.tag;
            
            if ([_lisarry containsObject:[_merchdataarry objectAtIndex:sender.tag]]) {
                NSLog(@"重复添加");
            }else{
                [_lisarry insertObject:[_merchdataarry objectAtIndex:sender.tag] atIndex:0];
            }
            NSString    * MStag =[NSString stringWithFormat:@"%d",Mtag];
            NSDictionary * Mdic =@{@"tag":MStag,@"lisarry":_lisarry};
            NSLog(@"_lisarry:%@",_lisarry);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MerNot" object:Mdic];
            //            liebiaoVC.dicBlock=^NSDictionary *(void){
            //                return Mdic;
            //            };
            [self QiandanAnimations];
            [_merchdataarry removeObjectAtIndex:sender.tag];
            [_timearray     removeObjectAtIndex:sender.tag];
            /**
             *  亚鹏测试
             */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"取消" object:nil];
            self.indentifierSTR = @"OK";
            
            NSLog(@"抢单提交");
            
        }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您还没有选择商品，无法提交！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        }
    }if ([account.range_type isEqualToString:@"2"]) {
        
        NSString *Talkid =[NSString stringWithFormat:@"%@",[[_merchdataarry objectAtIndex:sender.tag] objectForKey:@"talk_id"]];
        NSDictionary *dic= @{@"talk_id": Talkid,@"goods_info":submitarry};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfSendToBusiness object:MDLCommit userInfo:dic];
        NSInteger  Mtag =sender.tag;
        
        if ([_lisarry containsObject:[_merchdataarry objectAtIndex:sender.tag]]){
            
        }else{
            
            [_lisarry insertObject:[_merchdataarry objectAtIndex:sender.tag] atIndex:0];
        }
        NSString    * MStag =[NSString stringWithFormat:@"%d",Mtag];
        NSDictionary * Mdic =@{@"tag":MStag,@"lisarry":_lisarry};
        NSLog(@"_lisarry:%@",_lisarry);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MerNot" object:Mdic];
        //        liebiaoVC.dicBlock=^NSDictionary *(void){
        //            return Mdic;
        //        };
        [self QiandanAnimations];
        [_merchdataarry removeObjectAtIndex:sender.tag];
        [_timearray     removeObjectAtIndex:sender.tag];
        /**
         *  亚鹏测试
         */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"取消" object:nil];
        self.indentifierSTR = @"OK";
        [lishiTimer invalidate];
    }
    
    [submitarry removeAllObjects];
    [self reloadtableview];
}

-(void)QiandanAnimations
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    CGRect frames = Qdview.frame;
    frames.origin.y = -330;
    Qdview.frame = frames;
    [UIView commitAnimations];
    yinyingview.hidden=YES;
    
    //        CATransition *transition = [CATransition animation];
    //        transition.duration = 2.0f;
    //        transition.type = kCATransitionPush;
    //        transition.subtype = kCATransitionFromRight;
    //        [Qdview exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    //        [Qdview.layer addAnimation:transition forKey:@"animation"];
}

/**
 *  登陆模块
 */
-(void)dengluba
{
    account = [HSPAccountTool account];
    if ([account.user_id length] == 0)
    {
        /**
         *  真实数据
         */
        HSPLoginViewController *view = [[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
        [self.MQLBusinessViewController presentViewController:view animated:YES completion:nil];
        
        /**
         *  测试数据
         */
        //        ZYPRegWriteInformationVC *write = [[ZYPRegWriteInformationVC alloc] initWithNibName:@"ZYPRegWriteInformationVC" bundle:nil];
        //        [self.MQLBusinessViewController.navigationController pushViewController:write animated:YES];
        //        ZYPOverViewController *overView = [[ZYPOverViewController alloc] initWithNibName:@"ZYPOverViewController" bundle:nil];
        //        [self.MQLBusinessViewController.navigationController pushViewController:overView animated:YES];
        
    }else if([account.user_id length] > 0)
    {
        if ([account.user_mark intValue] == 0)
        {
            ZYPRegWriteInformationVC *write = [[ZYPRegWriteInformationVC alloc] initWithNibName:@"ZYPRegWriteInformationVC" bundle:nil];
            write.user_id = account.user_id;
            //            UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:write];
            [self.MQLBusinessViewController.navigationController pushViewController:write animated:YES];
        }else if ([account.user_mark intValue] == 1)
        {
            
        }
    }
}
/**
 *
 *  待确认View
 *  @param sender
 */
- (IBAction)pushixsVC:(id)sender {
    
    self.MQLBusinessViewController.navigationController.tabBarController.tabBar.hidden=YES;
    [self.MQLBusinessViewController.navigationController pushViewController:liebiaoVC animated:YES];
}

#pragma mark — Animations -

/**
 *  抢单View动画
 */
-(void)QdviewAnimations
{
    [UIView beginAnimations:@"testanimation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGRect frames = Qdview.frame;
    frames.origin.y = self.size.height/2-Qdview.size.height/2+NVBARHeight/2-20;
    Qdview.frame = frames;
    [UIView commitAnimations];
}
-(void)cancel
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    CGRect frames = Qdview.frame;
    frames.origin.y = -360;
    Qdview.frame = frames;
    [UIView commitAnimations];
    yinyingview.hidden=YES;
    
    /**
     *  亚鹏测试
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"取消" object:nil];
    self.indentifierSTR = @"OK";
    [lishiTimer invalidate];
    
}

//抢单成功界面动画
- (IBAction)SuccessfulAnimation:(id)sender {
    
    if (!succes) {
        succes =[[[NSBundle mainBundle]loadNibNamed:@"MDLSuccessfulView" owner:self options:nil]lastObject];
        succes.backgroundColor=BGColor;
        [succes.jixuqiangdanbutton addTarget:self action:@selector(animationstop) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:succes];
    yinyingview.backgroundColor=[UIColor whiteColor];
    yinyingview.hidden=NO;
    
    [UIView beginAnimations:@"testanimation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    //   [UIView setAnimationDidStopSelector:@selector(animationstop:)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //获得视图的位置
    CGRect frames = succes.frame;
    frames.origin.y = 20;
    succes.frame = frames;
    [UIView commitAnimations];
}

//抢单成功界面回原位
-(void)animationstop{
    
    yinyingview.hidden=YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    CGRect frames = succes.frame;
    frames.origin.y = -380;
    succes.frame = frames;
    [UIView commitAnimations];
}

//抢单失败界面动画
- (IBAction)FailureAnimation:(id)sender {
    
    if (!failure) {
        failure =[[[NSBundle mainBundle]loadNibNamed:@"MDLFailureView" owner:self options:nil]lastObject];
        //        failure.frame=CGRectMake(0, -320, 320, 320);
        [failure.JXqiangdanButton addTarget:self action:@selector(failureAnimationstop) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:failure];
    yinyingview.backgroundColor=[UIColor whiteColor];
    yinyingview.hidden=NO;
    
    [UIView beginAnimations:@"testanimation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    
    //    [UIView setAnimationDidStopSelector:@selector(failureAnimationstop)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGRect frames = failure.frame;
    frames.origin.y = 20;
    failure.frame = frames;
    [UIView commitAnimations];
}

//抢单失败回到原位动画
-(void)failureAnimationstop
{
    yinyingview.hidden=YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    CGRect frames = failure.frame;
    frames.origin.y = -360;
    failure.frame = frames;
    [UIView commitAnimations];
}

#pragma mark - NotificationCenter -
/**
 *  获取订单
 *
 *  @param Not 订单详情参数
 */
- (void)AccessData:(NSNotification *)Not
{
    int counst=1;
    if ([Not.object isEqualToString:@"can"]) {
        
        NSDictionary *data =[Not userInfo];
        NSLog(@"通知获取到的数据%@",data);
        if ([[data objectForKey:@"code"]isEqualToString:@"0"]) {
            
//            [_merchdataarry insertObject:[data objectForKey:@"data"] atIndex:0];
//            MDLOrderTimeObject *timeobj=[[MDLOrderTimeObject alloc]init];
//            timeobj.timercount   =100;
//            [_timearray insertObject:timeobj atIndex:0];
//            [self reloadtableview];
            
            if ([self.indentifierSTR isEqualToString:@"OK"])
            {
                [_merchdataarry insertObject:[data objectForKey:@"data"] atIndex:0];
                MDLOrderTimeObject *timeobj=[[MDLOrderTimeObject alloc]init];
                timeobj.timercount   =100;
                [_timearray insertObject:timeobj atIndex:0];
                [self reloadtableview];
                
            }else if ([self.indentifierSTR isEqualToString:@"OFF"])
            {
                [self.linshiArray addObject:[data objectForKey:@"data"]];
                MDLOrderTimeObject *timeobj=[[MDLOrderTimeObject alloc]init];
                timeobj.timercount   =100;
                [self.linshiTimeArray addObject:timeobj];
            }
            
        }else{
            NSLog(@"非法操作");
        }
        [self AudioNotification:counst];
        
    }
}
/**
 *  提交订单回执
 *
 *  @param Notification 返回的参数
 */
-(void)Notmessage:(NSNotification *)Notification
{
    int coust=0;
    NSDictionary *dic=[Notification userInfo];
    if ([[dic objectForKey:@"code"] isEqualToString:@"1008"]) {
        //抢单失败
        coust=2;
        [self FailureAnimation:nil];
        
    }if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
        [self SuccessfulAnimation:nil];
        [Notifyarry addObject:[dic objectForKey:@"data"]];
        NSLog(@"Notifyarry:%@",Notifyarry);
        //抢单成功
        coust=3;
        NSString *str=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"]objectForKey:@"mobile"]];
        NSDictionary *Phonedic=@{@"phone":str};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Telephone" object:nil userInfo:Phonedic];
        [succes.DianhuahaoButton addTarget:succes action:@selector(CallPhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self AudioNotification:coust];
    NSLog(@"提交返回的数据:%@",dic);
}
-(void)CallPhone:(UIButton *)btn
{
}
-(void)AudioNotification:(int)cost
{
    /**
     * 调用系统提示音！
     */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xiguan" ofType:@"mp3"];
    //组装并播放音效
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    if (cost == 1) {
        AudioServicesPlaySystemSound(1007);
    }else if (cost == 2){
        AudioServicesPlaySystemSound(1009);
    }else if (cost == 3){
        AudioServicesPlaySystemSound(1001);
    }else{
        AudioServicesPlaySystemSound(1001);
    }
}

/**
 *  跳转地图
 */
-(void)pushMAPVC
{
    self.MQLBusinessViewController
    .tabBarController.tabBar.hidden=YES;
    [self.MQLBusinessViewController.navigationController pushViewController:mapvc animated:YES];
}
/**
 *  选择物品VC
 */
-(void)pushxzVC
{
    MDLJingyingViewController *JYVC =[[MDLJingyingViewController alloc]init];
    self.MQLBusinessViewController.tabBarController.tabBar.hidden=YES;
    [submitarry removeAllObjects];
    [self.MQLBusinessViewController.navigationController pushViewController:JYVC animated:YES];
}

/**
 *  移除观察者
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logout" object:nil];
}
@end
