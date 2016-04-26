//
//  ZYPServeOrderBottomView.h
//  HaoLin
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZYPServeOrderDetailVC;
@interface ZYPServeOrderBottomView : UIView

@property (weak, nonatomic) IBOutlet UILabel *totalMoney;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;//  确认发货按钮
@property (nonatomic, strong)ZYPServeOrderDetailVC *serveVC;

@end
