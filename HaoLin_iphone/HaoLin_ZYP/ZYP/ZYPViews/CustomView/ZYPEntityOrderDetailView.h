//
//  ZYPEntityOrderDetailView.h
//  HaoLin
//
//  Created by mac on 14-9-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZYPUserObject;
@class ZYPOrderDetailVC;

@interface ZYPEntityOrderDetailView : UIView
{
    ZYPCustomBottomView *bottomView;
}
@property (nonatomic, strong)ZYPUserObject * userObj;
@property (nonatomic, strong)ZYPOrderDetailObject *orderDetailObj;
@property (nonatomic, strong)ZYPorderObject *orderObject;

@property (nonatomic, strong)ZYPOrderDetailVC *detailV;


@property (weak, nonatomic) IBOutlet UILabel *naLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;// 滑动scrollView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//  导航label

@property (weak, nonatomic) IBOutlet UIButton *backBtn;//返回按钮



@property (weak, nonatomic) IBOutlet UILabel *shouhuorenLabel;
@property (weak, nonatomic) IBOutlet UILabel *addresslABEL;

@property (weak, nonatomic) IBOutlet UILabel *shDianHuaLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@property (weak, nonatomic) IBOutlet UIView *huodanView;//  订单详情View
@property (weak, nonatomic) IBOutlet UILabel *dingdanStateLabel;
@property (weak, nonatomic) IBOutlet UIView *dingdanStateView;//  订单状态view


@property (weak, nonatomic) IBOutlet UILabel *peiSongFeiLabel;


@property (weak, nonatomic) IBOutlet UIView *peisongfeiView;//  配送View


@property (weak, nonatomic) IBOutlet UILabel *zhifustateLabel;

@property (weak, nonatomic) IBOutlet UIView *zhiduzhuangStateView;//  支付状态View

@property (weak, nonatomic) IBOutlet UILabel *dingdanBianhaoLabel;

@property (weak, nonatomic) IBOutlet UILabel *dingdanTimeLabel;



@property (weak, nonatomic) IBOutlet UIView *dingdanxinxiView;//  低昂单信息View编号等

@property (nonatomic, strong)UIButton *btn;



@end
