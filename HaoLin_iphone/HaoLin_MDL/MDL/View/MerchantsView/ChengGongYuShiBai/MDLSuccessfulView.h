//
//  MDLSuccessfulView.h
//  HaoLin
//
//  Created by apple on 14-8-16.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDLSuccessfulView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *ChenggongimageView;       //成功抢单主图
@property (weak, nonatomic) IBOutlet UIImageView *beijingimageView;         //联系顾客背景图
@property (weak, nonatomic) IBOutlet UIButton *DianhuahaoButton;            //电话号按钮
@property (weak, nonatomic) IBOutlet UIImageView *bjimageview;
@property (weak, nonatomic) IBOutlet UILabel *PromptLable;     //提示语
@property (weak, nonatomic) IBOutlet UIView *btnimge;
                                                                            //电话号后边小图
@property (weak, nonatomic) IBOutlet UIView *navbar;
@property (weak, nonatomic) IBOutlet UIButton *jixuqiangdanbutton;          //继续抢单按钮
@property (nonatomic ,retain)UIWebView *phoneWebView;
@end
