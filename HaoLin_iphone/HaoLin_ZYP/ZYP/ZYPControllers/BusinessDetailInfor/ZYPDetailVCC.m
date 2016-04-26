//
//  ZYPDetailVCC.m
//  HaoLin
//
//  Created by mac on 14-10-6.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPDetailVCC.h"





@interface ZYPDetailVCC ()
@property (nonatomic, strong)CycleADScrollView *adView;
@end
@implementation ZYPDetailVCC
/**
 *  xib初始化
 */
- (void)awakeFromNib
{
    
    self.jieshaoContentLabel.numberOfLines = 0;
    self.jieshaoContentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.huodongjieshaoLabel.numberOfLines = 0;
    self.huodongjieshaoLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.chanpinjieshaoLelabel.numberOfLines = 0;
    self.chanpinjieshaoLelabel.lineBreakMode = NSLineBreakByCharWrapping;
    if (IS_IPHONE_5) {
        self.frame = CGRectMake(0, 0, 320, 504);
        self.bottomScrollView.frame = CGRectMake(0, 64, 320, 504);
    }else
    {
        self.frame = CGRectMake(0, 0, 320, 480);
        self.bottomScrollView.frame = CGRectMake(0, 64, 320, 416);

    }
    //刷新按钮
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"MDLrefresh"] forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventTouchUpInside];
    self.btn.frame = CGRectMake(110, 200, 100, 100);
    [self addSubview:self.btn];
    
    
    
    
    
    self.titleLabel.backgroundColor = ZYPBGColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutAll) name:@"商家详情布局" object:nil];
    self.bottomScrollView.hidden = YES;
}
- (void)refreshView:(UIButton *)btn
{
    [self.detailVC freshView];
}
/**
 *  通知方法，用来布局界面
 */
- (void)layoutAll
{
    [self layoutFrame];
    [self fuzhi];
}
/**
 *  布局视图的frame
 */
- (void)layoutFrame
{
    self.imagesScrollview.frame = CGRectMake(0, 0, 320, 140);
    self.imagesScrollview.contentSize = CGSizeMake(320*self.imagesArr.count, 140);
    /**
     *  第一个视图的view
     */
    self.addressView.frame = CGRectMake(0, 140, 320, 60);
    /**
     *  第二个视图的view
     */
    CGFloat height = [self heightOfLabelFromString:self.businedetailObj.product_desc];
    self.jieshaoView.frame = CGRectMake(0, 210, 320, height + 30 + 10);
    /**
     *  第三个视图的view
     */
    
    self.addressView2.frame = CGRectMake(0, 260 + height , 320, 40);
    /**
     *  第四个视图的view
     */
    self.phoneView.frame = CGRectMake(0, 310 + height , 320, 40);
    /**
     *  第五个视图的view
     */
    CGFloat height1 = [self heightOfLabelFromString:self.businedetailObj.product_desc];
    self.chanpinjieshaoView.frame = CGRectMake(0, 350 + height + 10, 320, 30 + height1 + 10);
    /**
     *  第六个视图的view
     */
     CGFloat height2 = [self heightOfLabelFromString:self.businedetailObj.activ_desc];
    self.huodongjieshaoView.frame = CGRectMake(0, 400 + height + height1 + 10, 320, height2 + 30 + 10);
    self.bottomScrollView.contentSize = CGSizeMake(320, 410 + height1 + height2 + height + 50);
}
/**
 *  赋值
 */
- (void)fuzhi
{
    /**
     *  scrollView
     */
    if (self.imagesArr.count > 1)
    {
        NSMutableArray *viewsArray = [NSMutableArray array];
        for (int i = 0; i < self.imagesArr.count; ++i) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.imagesScrollview.bounds];
            [imageView setImageWithURL:[NSURL URLWithString:[self.imagesArr objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"ZYPshop_default_avatar.png"]];
            [viewsArray addObject:imageView];
        }
        
        self.adView = [[CycleADScrollView alloc] initWithFrame:self.imagesScrollview.bounds animationDuration:2];
        
        self.adView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return viewsArray[pageIndex];
        };
        self.adView.totalPagesCount = ^NSInteger(void){
            return [viewsArray count];
        };
        self.adView.TapActionBlock = ^(NSInteger pageIndex){
            NSLog(@"点击了第%d个",pageIndex);
        };
        [self.imagesScrollview addSubview:self.adView];
    }else if(self.imagesArr.count == 0)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:self.imagesScrollview.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor orangeColor];
        label.text = @"暂无图片";
        label.font = [UIFont systemFontOfSize:30];
        [self.imagesScrollview addSubview:label];
    }else if(self.imagesArr.count == 1)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.imagesScrollview.bounds];
        [imageView setImageWithURL:[NSURL URLWithString:[self.imagesArr objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"ZYPshop_default_avatar.png"]];
        [self.imagesScrollview addSubview:imageView];
    }
    /**
     *  第一个view的数据
     */
    self.addressLabel.text = self.businedetailObj.merchant_name;
    self.distanceLabel.text = self.object.distance;
    if ([self.businedetailObj.score intValue] != 0)
    {
        //  创建评分label
        for (int i = 0; i < [self.businedetailObj.score intValue]; i++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i*24 , 30, 20, 20)];
            imageview.image = [UIImage imageNamed:@"ZYPChengseStar@2x_01.png"];
            [self.addressView addSubview:imageview];
        }
        for (int i = [self.businedetailObj.score intValue]; i < 5 ; i ++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i*24 , 30, 20, 20)];
            imageview.image = [UIImage imageNamed:@"ZYPHuiseStar@2x_03.png"];
            [self.addressView addSubview:imageview];
        }
        
    }else if([self.businedetailObj.score intValue] == 0)
    {
        for (int i = 0; i < 5 ; i ++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i*24 , 30, 20, 20)];
            imageview.image = [UIImage imageNamed:@"ZYPHuiseStar@2x_03.png"];
            [self.addressView addSubview:imageview];
        }
    }
    /**
     *  第二个view的数据
     */
    if ([self.businedetailObj.mer_desc length] > 0) {
        CGFloat height = [self heightOfLabelFromString:self.businedetailObj.product_desc];
        self.jieshaoContentLabel.frame = CGRectMake(20, 25, 280, height + 10);
        self.jieshaoContentLabel.text = self.businedetailObj.mer_desc;
        
    }else
    {
        self.jieshaoContentLabel.frame = CGRectMake(20, 25, 280, 30 + 10);
        self.jieshaoContentLabel.text = @"抱歉，商家暂无介绍";
    }
    /**
     *  第三个view的数据
     */
    self.addressLabel2.text = self.businedetailObj.shop_address;
    /**
     *  第四个view的数据
     */
    [self.callBtn setTitle:self.businedetailObj.mobile forState:UIControlStateNormal];
    [self.callBtn addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    /**
     *  第五个view的数据
     */
    if ([self.businedetailObj.product_desc length] > 0) {
        CGFloat height = [self heightOfLabelFromString:self.businedetailObj.product_desc];
        self.chanpinjieshaoLelabel.frame = CGRectMake(20, 25, 280, height + 10);
        self.chanpinjieshaoLelabel.text = self.businedetailObj.product_desc;
    }else
    {
        self.chanpinjieshaoLelabel.frame = CGRectMake(20, 25, 280, 30 + 10);
        self.chanpinjieshaoLelabel.text = @"抱歉，商家暂无介绍";
    }
    /**
     *  第六个view的数据
     */
    if ([self.businedetailObj.activ_desc length] > 0) {
        CGFloat height = [self heightOfLabelFromString:self.businedetailObj.activ_desc];
        self.huodongjieshaoLabel.frame = CGRectMake(20,25, 280, height + 10);
        self.huodongjieshaoLabel.text = self.businedetailObj.activ_desc;
    }else
    {
        self.huodongjieshaoLabel.frame = CGRectMake(20, 25, 280, 30  + 10);
        self.huodongjieshaoLabel.text = @"抱歉，商家暂无介绍";
    }
    
    self.bottomScrollView.hidden = NO;
}

//  label自适应高度
- (CGFloat)heightOfLabelFromString:(NSString *)text
{
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    CGSize size1 = [text boundingRectWithSize:CGSizeMake(280, 0) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    return size1.height;
}

- (void)callPhone:(UIButton *)btn
{
    //  打电话
    //  判断设备是iphone还是ipad iphone能打电话，ipad不能
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==  UIUserInterfaceIdiomPhone)
    {
        /**
         *   打电话
         :returns:
         */
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.businedetailObj.mobile];
        UIWebView *webView = [[UIWebView alloc] init];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self addSubview:webView];
    }else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [self alertWithMessage:@"此设备暂不支持打电话"];
    }

}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (IBAction)back:(id)sender
{
    [self.detailVC.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"商家详情布局" object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
