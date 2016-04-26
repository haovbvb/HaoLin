//
//  Main.h
//  HaoLin
//
//  Created by mac on 14-8-7.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "MDLJingyingViewController.h"
#import "MDLWuPinViewController.h"
#import "MDLMercHantView.h"
#import "MDLInformationView.h"
#import "MDQiangdanView.h"
#import "MDLinformationTableViewCell.h"
#import "MDLNetworkservice.h"
#import "MDLWuPinTableViewCell.h"
#import "MDLMapViewController.h"
#import "MDLSuccessfulView.h"
#import "MDLFailureView.h"
#import "MDLQDMapView.h"
#import "MDLXZoneView.h"
#import "MDLSinglesView.h"
#import "MDLDengluyeViewController.h"
#import "MDLXuanzeshangpin.h"
#import "MDLQiangdanliebiao.h"
#import "MDLLijiqiangdan.h"
#import "MDLServiceXZViewController.h"
#import "MDLbasicdataobj.h"
#import "MDLFenleiview.h"
#import "MDLgoodsdata.h"
#import "MDLleidaview.h"
#import "MDLGrabsingleViewController.h"
#import "MDLCellView.h"
#import "MDLInformation.h"
#import "MDLPicView.h"
#import "MDLFuwuView.h"
#import "MDLLiebiaoViewController.h"
#import "MDLgoodscellView.h"
#import "MDLHeaderView.h"
#import "MDLFooterView.h"
#import "MDLLastorderViewController.h"
#import "MDLAudioFile.h"
#import "MDLOrderTimeObject.h"
#import "MDLRefreshView.h"


//#import "Reachability.h"


#define BtainNotification @"AccessData"
#define MesGeNotification @"message"

#define kConnectGetType    @"GET"
#define kConnectPostType   @"POST"

#define JYURL @"http://192.168.1.88:7878/home"
//#define JYURL @"http://t9.wxwork.cn/home"

// //获取喊单详情
//#define ktalkinfosUrl  @"http://192.168.1.88:7878/home/order/talkinfos?user_id=%@&tokenid=%@&talk_id=%@";
//
////商户抢单提交
//#define kgrabtoUrl  @"http://192.168.1.88:7878/home/order/grabto?user_id=%@&tokenid=%@&talk_id=%@&goods_info=%@"
//
////获取分类下的商品列表
//#define Kgoodslisturl  @"http://192.168.1.88:7878/home/goods/goodslist?user_id=%@&tokenid=%@&cat_id=%@&page=%@"
//
////商品分类列表
//#define Kmerchantcatgoryurl  @"http://192.168.1.88:7878/home/goods/merchantcatgory?user_id=%@&tokenid=%@"

////////////////////////////

#define ktalkinfosUrl  @"http://t9.wxwork.cn/home/order/talkinfos?user_id=%@&tokenid=%@&talk_id=%@"                  //获取喊单详情

#define kgrabtoUrl     @"http://t9.wxwork.cn/home/order/grabto?user_id=%@&tokenid=%@&talk_id=%@&goods_info=%@"
                                                       //商户抢单提交

#define Kgoodslisturl  @"http://t9.wxwork.cn/home/goods/goodslist?user_id=%@&tokenid=%@&cat_id=%@&page=%@"                                                //获取分类下的商品列表

#define Kmerchantcatgoryurl  @"http://t9.wxwork.cn/home/goods/merchantcatgory?user_id=%@&tokenid=%@"                                                //商品分类列表
#define kgoodslisturl  @"http://t9.wxwork.cn/home/goods/goodslist?user_id=%@&tokenid=%@"

#define NVBARHeight  65
#define HEIGH  45
#define KDeviceHeight    [UIScreen mainScreen].bounds.size.height
#define KDeviceWidth     [UIScreen mainScreen].bounds.size.width
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define BGColor [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0]

#define MDLBGColor [UIColor colorWithRed:255.0/255 green:75.0/255 blue:0.0/255 alpha:1.0]

//*********文本内容限制**********
#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define kAlpha      @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
#define kNumbers        @"0123456789"
#define kNumbersPeriod  @"0123456789."


