//
//  ZYPEntityOrderView.h
//  HaoLin
//
//  Created by mac on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    allOrder,
    waitToDeliverGood,//  等待发货
    waitToGetMoney,// 等代收款
    readyToDelivery//  已发货
}State;

@class MQLPetsViewController;//  bar界面
@class ZYPBusinrssOrderViewController;//  商户中心订单界面
@interface ZYPEntityOrderView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    ZYPorderObject *objects;//  测试数据
}
@property (nonatomic, strong)NSMutableArray *sourceArray;
@property (nonatomic,strong)NSArray *sourceArray1;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign)State state;
@property (nonatomic, strong)NSString *str;
@property (nonatomic, strong)MQLPetsViewController *petVC;//  bar界面
@property (nonatomic, strong)ZYPBusinrssOrderViewController *businessOrderVC;//  商户中心订单界面

- (void)allOrder;
- (void)waitToDeliverGood1;
- (void)waitToGetMoney1;
- (void)readyToDelivery1;

@end
