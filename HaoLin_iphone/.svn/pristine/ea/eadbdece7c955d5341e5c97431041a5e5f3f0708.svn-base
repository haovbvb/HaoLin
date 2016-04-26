//
//  MDQiangdanView.h
//  HAOLINAPP
//
//  Created by apple on 14-8-13.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDQiangdanView;

@protocol pushmapDelegate <NSObject>

-(void)pushimap:(MDQiangdanView *)mdqview;

@end

@interface MDQiangdanView : UIView 
/*
 **
 * UIButton *xuanzebutton:选择物品
 * UILabel  *NeirongLable:订单内容
 * UILabel  *AddressLable:配送地址
 * UIButton *YuyinButton :语音按钮
 * UIButton *MapButton;  :地图按钮
 * UIButton *quxiaobtn;  :取消按钮
 * UILabel  *xuanzeneirong;        :选择后的商品名称
 * UIButton *JixuQiangdanButton    :抢单按钮
 * UILabel  *DistributionMoneyLable:配送费
 ***
 */

@property (nonatomic,assign)id<pushmapDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *xuanzebutton;
@property (weak, nonatomic) IBOutlet UILabel  *timerLable;
@property (weak, nonatomic) IBOutlet UILabel  *NeirongLable;
@property (weak, nonatomic) IBOutlet UILabel  *AddressLable;
@property (weak, nonatomic) IBOutlet UIButton *YuyinButton;
@property (weak, nonatomic) IBOutlet UIButton *MapButton;
@property (weak, nonatomic) IBOutlet UILabel  *DistributionMoneyLable;
@property (weak, nonatomic) IBOutlet UIButton *JixuQiangdanButton;
@property (weak, nonatomic) IBOutlet UILabel  *xuanzeneirong;
@property (weak, nonatomic) IBOutlet UIButton *quxiaobtn;
@property (weak, nonatomic) IBOutlet UILabel  *TotalPicLable;
@property (nonatomic, weak) UIView            *view ;
@property (nonatomic,assign) NSInteger testInt;

@end
