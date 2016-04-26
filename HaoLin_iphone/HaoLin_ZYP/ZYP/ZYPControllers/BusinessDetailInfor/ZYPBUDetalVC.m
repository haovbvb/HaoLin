//
//  ZYPBUDetalVC.m
//  HaoLin
//
//  Created by mac on 14-9-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPBUDetalVC.h"

@interface ZYPBUDetalVC ()<UIScrollViewDelegate>
{
    NSTimer *time;
    UIScrollView *scroll;
    UIPageControl *pageControl;
    NSInteger j;
    ZYPDetailVCC *dView;
}
@property (nonatomic, strong)NSMutableArray *sourceArray;
@property (nonatomic, strong)ZYPBusinessDetailObject *businedetailObject;
@end

@implementation ZYPBUDetalVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
        dView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPDetailVCC" owner:self options:nil] lastObject];
    dView.detailVC = self;
    dView.btn.alpha = 0;
//    j = 0;
    self.sourceArray = [[NSMutableArray alloc] initWithCapacity:0];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.backgroundColor = ZYPBGColor;
    self.tableView.hidden = YES;
    [self getSource];
}
- (void)getSource
{
    //  显示加载状态
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    HSPAccount *accout = [HSPAccountTool account];
    
    __weak ZYPBUDetalVC *businessVC = self;
    NSString *urlString = [NSString stringWithFormat:@"%@merchant_id=%@&tokenid=%@&user_id=%@",businessDetailUrl,self.object.merchant_id,accout.userTokenid,accout.user_id];
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    [manger connectWithUrlString:urlString completion:^(id responedObject) {
        if ([responedObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responedObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"])
            {
                NSDictionary *detailDic = [dic objectForKey:@"data"];
                businessVC.businedetailObject = [[ZYPBusinessDetailObject alloc] initBusinessDetailObjectWithDic:detailDic];
                NSArray *array = [detailDic objectForKey:@"photo"];
                for (NSDictionary *dic1 in array)
                {
                    [businessVC.sourceArray addObject:[dic1 objectForKey:@"y_thumb"]];
                }
                dView.businedetailObj = businessVC.businedetailObject;
                dView.imagesArr = businessVC.sourceArray;
                dView.object = self.object;
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"商家详情布局" object:nil];
                //  隐藏加载状态
                [MBProgressHUD hideAllHUDsForView:businessVC.view animated:YES];
                [businessVC.view addSubview:dView];
                
        }else
            {
                //  隐藏加载状态
                [MBProgressHUD hideAllHUDsForView:businessVC.view animated:YES];
                dView.btn.alpha = 1;
                [businessVC.view addSubview:dView];
               // 弹出对话框
                [businessVC alertWithMessage:[dic objectForKey:@"message"]];
            }
        }else
        {
            //  隐藏加载状态
            [MBProgressHUD hideAllHUDsForView:businessVC.view animated:YES];
            dView.btn.alpha = 1;
            [businessVC.view addSubview:dView];
            // 弹出对话框
            [businessVC alertWithMessage:@"请求出错,请重新请求"];
        }

    }];
}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
//刷新view
- (void)freshView
{
    dView.btn.alpha = 0;
    [self getSource];
}








#pragma mark - 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 || indexPath.section == 3 || indexPath.section == 4)
    {
        static NSString *indentifier = @"indentifier";
        ZYPLastCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPLastCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineLabel.backgroundColor = [UIColor clearColor];
        cell.totalLabel.hidden = YES;
        cell.priceLabel.hidden = YES;
        cell.backgroundColor = [UIColor whiteColor];
        [cell.palyBtn removeFromSuperview];
        cell.stateLabel.textColor = [UIColor lightGrayColor];
        cell.contentLabel.textColor = [UIColor lightGrayColor];
        if (indexPath.section == 0)
        {
            //  商户介绍，暂无用产品介绍代替*******************
            cell.stateLabel.text = @"商家介绍:";
            if ([self.businedetailObject.product_desc length] > 0) {
                CGFloat height = [self heightOfLabelFromString:self.businedetailObject.product_desc];
                cell.contentLabel.frame = CGRectMake(20, 40, 280, height);
                cell.contentLabel.text = self.businedetailObject.product_desc;
            }else
            {
                cell.contentLabel.frame = CGRectMake(20, 40, 280, 35);
                cell.contentLabel.text = @"商家暂无介绍";
            }
        }else if (indexPath.section == 3)
        {
                //  产品介绍
            cell.stateLabel.text = @"产品介绍:";
            if ([self.businedetailObject.product_desc length] > 0) {
                CGFloat height = [self heightOfLabelFromString:self.businedetailObject.product_desc];
                cell.contentLabel.frame = CGRectMake(20, 40, 280, height);
                cell.contentLabel.text = self.businedetailObject.product_desc;
            }else
            {
                cell.contentLabel.frame = CGRectMake(20, 40, 280, 35);
                cell.contentLabel.text = @"商家暂无介绍";
            }
        }else if (indexPath.section == 4)
        {
                    //  产品介绍
            cell.stateLabel.text = @"活动介绍:";
            if ([self.businedetailObject.activ_desc length] > 0) {
                CGFloat height = [self heightOfLabelFromString:self.businedetailObject.activ_desc];
                cell.contentLabel.frame = CGRectMake(20, 40, 280, height);
                cell.contentLabel.text = self.businedetailObject.activ_desc;
            }else
            {
                cell.contentLabel.frame = CGRectMake(20, 40, 280, 35);
                cell.contentLabel.text = @"商家暂无介绍";
            }
        }
        
        return cell;
    }else if(indexPath.section == 1 ||indexPath.section == 2 || indexPath.section == 5)
    {
        static NSString *indentifiew = @"used";
        ZYPBUPlainCell *plainCell = [tableView dequeueReusableCellWithIdentifier:indentifiew];
        if (plainCell == nil)
    {
            plainCell = [[[NSBundle  mainBundle] loadNibNamed:@"ZYPBUPlainCell" owner:self options:nil] lastObject];
    }
        plainCell.backgroundColor = [UIColor whiteColor];
        plainCell.selectionStyle = UITableViewCellSelectionStyleNone;
        plainCell.someLanel.textColor = [UIColor lightGrayColor];
        if (indexPath.section == 1)
    {
            plainCell.someLanel.text = @"商户地址:";
            plainCell.rightLabel.textAlignment = NSTextAlignmentLeft;
            plainCell.rightLabel.text = self.businedetailObject.shop_address;
        [plainCell.rightImageView removeFromSuperview];
            
    }else if (indexPath.section == 2)
    {
            plainCell.someLanel.text = @"电话呼叫";
            plainCell.rightLabel.textAlignment = NSTextAlignmentRight;
           plainCell.rightLabel.textColor = [UIColor orangeColor];
            plainCell.rightLabel.text = self.businedetailObject.mobile;
            plainCell.rightImageView.image = [UIImage imageNamed:@"ZYPLeft.png"];
    }else if (indexPath.section == 5)
    {
            plainCell.someLanel.text = @"评论总数";
            plainCell.rightLabel.textAlignment = NSTextAlignmentRight;
        plainCell.rightLabel.textColor = [UIColor orangeColor];
            plainCell.rightLabel.text = @"1024条";
            plainCell.rightImageView.image = [UIImage imageNamed:@"ZYPLeft.png"];
    }
        
    return plainCell;
    }
    return nil;
}
//  返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //  商户介绍，等待待数据******************************
        if ([self.businedetailObject.product_desc length] > 0) {
            CGFloat height = [self heightOfLabelFromString:self.businedetailObject.product_desc];
            return 40 + height +10;
        }else if([self.businedetailObject.product_desc length] == 0)
        {
            return 40 + 40;
        }
        
    }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 5)
    {
        return 44;
    }else if(indexPath.section == 3)
    {
        if ([self.businedetailObject.product_desc length] > 0) {
            CGFloat height = [self heightOfLabelFromString:self.businedetailObject.product_desc];
            NSLog(@"product %f",height);

            return 40 + height + 10;
        }else if([self.businedetailObject.product_desc length] == 0)
        {
            return 40 + 40;
        }
       
    }else if(indexPath.section == 4)
    {
        if ([self.businedetailObject.activ_desc length] > 0) {
            CGFloat height = [self heightOfLabelFromString:self.businedetailObject.activ_desc];
            NSLog(@"active %f",height);

            return 40 + height + 10;
        }else if([self.businedetailObject.activ_desc length] == 0)
        {
            return 40 + 40;
        }
    }
    return 0;
}
//  label自适应高度
- (CGFloat)heightOfLabelFromString:(NSString *)text
{
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    CGSize size1 = [text boundingRectWithSize:CGSizeMake(280, 0) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    return size1.height;
}
//  点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        //  打电话
        //  判断设备是iphone还是ipad iphone能打电话，ipad不能
        if ([[UIDevice currentDevice] userInterfaceIdiom] ==  UIUserInterfaceIdiomPhone)
        {
            /**
             *   打电话
             :returns:
             */
            NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.businedetailObject.mobile];
            UIWebView *webView = [[UIWebView alloc] init];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:webView];
        }else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            [self alertWithMessage:@"此设备暂不支持打电话"];
        }
        
    }else if (indexPath.section == 5)
    {
        //  进入评价界面
        ZYPBUEvaluteVC *evaluteVC = [[ZYPBUEvaluteVC alloc] initWithNibName:@"ZYPBUEvaluteVC" bundle:nil];
        evaluteVC.mercont_id = self.businedetailObject.merchant_id;
        [self.navigationController pushViewController:evaluteVC animated:YES];
    }
}
- (void)callPhone:(NSString *)phone
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView *webView = [[UIWebView alloc] init];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:webView];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        //  创建返回视图
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 210)];
        customView.backgroundColor = [UIColor whiteColor];

        if (self.sourceArray.count > 0) {
            NSInteger count = self.sourceArray.count;
            NSLog(@"%d",self.sourceArray.count);
                        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
            scroll.contentSize = CGSizeMake(320*count, 140);
            scroll.scrollEnabled = YES;
            scroll.userInteractionEnabled = YES;
            scroll.delegate = self;
            [customView addSubview:scroll];
            //  创建pageControl
            pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(180, 120, 120, 20)];
            pageControl.numberOfPages = count;
            pageControl.currentPage = 0;
            pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
            pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
            [customView addSubview:pageControl];
            //  加载商家店铺视图
            for (int i = 0; i < count; i ++) {
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 140)];
                //  afnetorking 请求图片
                [imageview setImageWithURL:[NSURL URLWithString:[self.sourceArray objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"ZYPshop_default_avatar.png"]];
                [scroll addSubview:imageview];
            }
        }else
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
            imageview.image = [UIImage imageNamed:@"ZYPshop_default_avatar.png"];
            [customView addSubview:imageview];
            
        }
        //  创建商店名称label
        UILabel *nalabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 145, 180, 20)];
        
        nalabel.text = self.businedetailObject.merchant_name;
        nalabel.textColor = [UIColor grayColor];
        [customView addSubview:nalabel];
        //  地图imageView
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(260, 150, 10, 10)];
        imageView.image = [UIImage imageNamed:@"ZYPDian@2x.png"];
        [customView addSubview:imageView];
        // 距离label.这里用到上一级商户的距离object*********
        UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(275, 145, 40, 20)];
        distanceLabel.text = self.object.distance;
        [customView addSubview:distanceLabel];
        if ([self.businedetailObject.score intValue] != 0)
        {
            //  创建评分label
            for (int i = 0; i < [self.businedetailObject.score intValue]; i++)
            {
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i*24 , 175, 20, 20)];
                imageview.image = [UIImage imageNamed:@"ZYPChengseStar@2x_01.png"];
                [customView addSubview:imageview];
            }
            for (int i = [self.businedetailObject.score intValue]; i < 5 ; i ++)
            {
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i*24 , 175, 20, 20)];
                imageview.image = [UIImage imageNamed:@"ZYPHuiseStar@2x_03.png"];
                [customView addSubview:imageview];
            }

        }else if([self.businedetailObject.score intValue] == 0)
        {
            for (int i = 0; i < 5 ; i ++)
            {
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i*24 , 175, 20, 20)];
                imageview.image = [UIImage imageNamed:@"ZYPHuiseStar@2x_03.png"];
                [customView addSubview:imageview];
            }
        }
                //  评分label
        UILabel *scoreLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(130, 170, 50, 30)];
        scoreLabel1.textColor = [UIColor orangeColor];
        scoreLabel1.text = self.businedetailObject.score;
        scoreLabel1.font = [UIFont systemFontOfSize:22];
        scoreLabel1.textAlignment = NSTextAlignmentCenter;
        [customView addSubview:scoreLabel1];
        /**
            隔条颜色
         */
        UILabel *scoreLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 10)];
        scoreLabel2.backgroundColor = [UIColor lightGrayColor];
        [customView addSubview:scoreLabel2];
        return customView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 210.0;
    }
    return 1;
}
#pragma mark -scrollView代理方法
//  代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    j = scrollView.contentOffset.x/320;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [time finalize];
}
- (void)anomation
{
    NSLog(@"%s__%d__",__FUNCTION__,__LINE__);
}
//  timer 方法
- (void)changeDistance
{
    if (j < self.sourceArray.count) {
        [UIView animateWithDuration:1 animations:^{
            scroll.contentOffset = CGPointMake(320*j, 0);
        }];
        pageControl.currentPage = scroll.contentOffset.x/320;
        j ++;
    }
    if (j == self.sourceArray.count) {
        j = 0;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
