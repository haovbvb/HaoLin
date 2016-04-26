//
//  ZYPServeOrderDetailView.m
//  HaoLin
//
//  Created by mac on 14-9-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPServeOrderDetailView.h"

@implementation ZYPServeOrderDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)refreashTable:(UIButton *)btn1
{
    [self.detailVC refreshView];
}
- (void)awakeFromNib
{
    self.titleLabel.backgroundColor = ZYPBGColor;
    bottomView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPServeOrderBottomView" owner:self options:nil] lastObject];
    if (IS_IPHONE_5) {
        self.frame = CGRectMake(0, 0, 320, 568);
        self.scrollView.frame = CGRectMake(0, 64, 320, 444);
    }else
    {
        self.frame = CGRectMake(0, 0, 320, 480);
        self.scrollView.frame = CGRectMake(0, 64, 320, 356);
    }
    self.userInteractionEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.hidden = YES;
    
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"MDLrefresh"] forState:UIControlStateNormal];
    self.btn.frame = CGRectMake(110, 200, 100, 100);
    [self.btn addTarget:self action:@selector(refreashTable:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutView:) name:@"2" object:nil];
}
- (void)layoutView:(NSNotification *)no
{
    [self viewsFrame];
    [self tianxieInfo];
}
- (IBAction)back:(id)sender
{
    [self.detailVC.navigationController popViewControllerAnimated:YES];
}

- (void)viewsFrame
{
    self.shouhuoView.frame = CGRectMake(0, 28,320,30+30);
    self.fuwustateView.frame = CGRectMake(0, 100, 320, 40);
    if ([self.orderDetailObject.order_desc length] > 0) {
        self.dingdanneirongView.frame = CGRectMake(0, 150, 320, 80);
        self.zhifuView.frame = CGRectMake(0, 240 ,320, 40);
        self.fuwufeView.frame = CGRectMake(0, 290 ,320, 40);
        self.dingdanbianhaoView.frame = CGRectMake(0,340 ,  320, 120);
        self.scrollView.contentSize = CGSizeMake(320,464);
    }else
    {
        self.dingdanneirongView.frame = CGRectMake(0, 150, 320, 50);
        self.zhifuView.frame = CGRectMake(0, 210, 320, 40);
        self.fuwufeView.frame = CGRectMake(0, 260 ,320, 40);
        self.dingdanbianhaoView.frame = CGRectMake(0,310 ,  320, 120);
        self.scrollView.contentSize = CGSizeMake(320,434);
    }
}
- (void)tianxieInfo
{
    self.servePeopleLabel.text = [NSString stringWithFormat:@"收货人:%@",self.userObject.nickname];
    self.shouhuorenDIANhuAlABEL.text = self.userObject.mobile;
    self.serveAddressLabel.text = self.orderDetailObject.delivery_address;
    
    
    
    /**
     *  判断服务状态
     */
    ////订单状态（0：订单取消，1.已确认，2.未支付，3.已支付，4.已发货，5.已完成，6.已评价）申明：当状态为3，4时表示商家已经发货，用户这时候不能做取消订单操作
//    if ([self.orderDetailObject.status intValue] == 4 ) {
//        self.dingdanStateLabel.text = @"服务中";
//    } else
    if ([self.orderDetailObject.status intValue] == 5 )
    {
        self.dingdanStateLabel.text = @"已完成";
    }else
    {
        self.dingdanStateLabel.text = @"待服务";
    }
//    else if ([self.orderDetailObject.status intValue] == 1 )
//    {
//        self.dingdanStateLabel.text = @"未完成";
//    }else if ([self.orderDetailObject.status intValue] == 2 )
//    {
//        self.dingdanStateLabel.text = @"未支付";
//    }else if ([self.orderDetailObject.status intValue] == 3 )
//    {
//        self.dingdanStateLabel.text = @"已支付";
//    }
    
    
    
    if ([self.orderDetailObject.order_desc length] > 0)
    {
        self.dingdanneirongLabel.text = self.orderDetailObject.order_desc;
    }
    self.fueuFeiLabel.text = [NSString stringWithFormat:@"￥%@",self.orderDetailObject.server_price];
    self.dingdanshijianLabel.text = [self timeTranslate:self.orderDetailObject.createtime];
    self.dingdanbianhaoLabel.text = self.orderDetailObject.order_sn;
    self.scrollView.hidden = NO;
}
#pragma mark -时间戳时间转化
- (NSString *)timeTranslate:(NSString *)time
{
    //  将时间戳转化为时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSString *dateString = [formatter stringFromDate:date1];
    return dateString;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
