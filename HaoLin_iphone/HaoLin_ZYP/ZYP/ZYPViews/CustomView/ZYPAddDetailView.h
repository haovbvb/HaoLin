//
//  ZYPAddDetailView.h
//  HaoLin
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYPGoodsSheftViewController;
@class ZYPCategaryListObject;
@class ZYPDetailGoodsObject;

@interface ZYPAddDetailView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *goodsNameText;
@property (weak, nonatomic) IBOutlet UITextField *goodsPriceText;
@property (weak, nonatomic) IBOutlet UIButton *allCategaryBtn;
@property (weak, nonatomic) IBOutlet UILabel *categaryLabel;

@property (nonatomic, strong)ZYPGoodsSheftViewController *goodsSheftVC;
@property (nonatomic, strong)ZYPCategaryListObject *listObject;
@property (nonatomic, strong)ZYPDetailGoodsObject *detailObject;
@property (nonatomic, strong)NSString *flag;
@property (nonatomic, strong)UIView *addView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *sheftView;

@property (nonatomic, strong)NSMutableArray *listArray;
@end
