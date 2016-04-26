//
//  ZYPServ1View.h
//  HaoLin
//
//  Created by mac on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYPServeOrderView;
@interface ZYPServ1View : UIView

@property (weak, nonatomic) IBOutlet UILabel *serveFeiL;

@property (weak, nonatomic) IBOutlet UIButton *soundBtn;


@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (nonatomic, strong)NSString *urlString;
@property (nonatomic, strong)NSString *orderID;

@property (nonatomic, strong)ZYPServeOrderView *orderView1;
@end
