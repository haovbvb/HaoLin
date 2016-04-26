//
//  HSPOrderPayViewController.m
//  HaoLin
//
//  Created by PING on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPOrderPayViewController.h"
#define HSPTag 456

@interface HSPOrderPayViewController ()
{
    NSInteger counter;
    HSPTextStepperField *contador;
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) HSPHttpRequest *request;
@property (nonatomic, strong) NSMutableArray *goodsM;
@property (nonatomic, strong) HSPOrder *order;



@end

@implementation HSPOrderPayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = HSPBgColor;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    YYLog(@"btn==%d",_orderId);
    [self sendRequest];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"订单详情";
    
    // num
    counter = 1;
    contador.Current = 1;
    contador.Step = 1;
    contador.Minimum=1;
    contador.Maximum = 99;
    contador.NumDecimals =0;
    contador.IsEditableTextField=FALSE;
    
    
}

- (void)sendRequest
{
//    HSPAccount *account = [HSPAccountTool account];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"user_id"] = account.user_id;
//    params[@"tokenid"] = account.userTokenid;
    [self.request connectionRequestUrl:@"http://localhost/orderPay.json" withJSON:^(id responeJson) {
        //        YYLog(@"==%@",responeJson);
        HSPOrder *order = [[HSPOrder alloc] init];
        order = [HSPOrder objectWithKeyValues:[responeJson objectForKey:@"data"]];
        
        order.goodsM = [NSMutableArray array];
        for (NSDictionary *dic in [[responeJson objectForKey:@"data"] objectForKey:@"goodsinfo"]) {
            HSPGoods *goods = [[HSPGoods alloc] init];
            goods = [HSPGoods objectWithKeyValues:dic];
            [order.goodsM addObject:goods];
        }
        
        self.order = order;
        
        [self UIConfig];
    }];
    
    
}

- (void)UIConfig
{
    // 收货地址
    HSPAddressView *addressView = [[[NSBundle mainBundle] loadNibNamed:@"HSPAddressView" owner:nil options:nil]lastObject];
    addressView.personNameLabel.text = self.order.userinfo.nickname;
    addressView.phoneNumberLabel.text = self.order.userinfo.mobile;
    addressView.addressLabel.text = self.order.userinfo.delivery_address;
    
    CGFloat addressX = 0;
    CGFloat addressY = 0;
    CGFloat addressW = HSPScreenWidth;
    CGFloat addressH = 98;
    addressView.frame = CGRectMake(addressX, addressY, addressW, addressH);
    [_scrollView addSubview:addressView];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    CGFloat cX = 0;
    CGFloat cY = CGRectGetMaxY(addressView.frame) + 10;
    CGFloat cW = HSPScreenWidth;
    CGFloat cH = 75 + (self.order.goodsM.count-1) * 40;
    contentView.frame = CGRectMake(cX, cY, cW, cH);
    [_scrollView addSubview:contentView];
    self.contentView = contentView;
    
    // 订单内容
    HSPOrderContentTitleView *contentTitleView = [[[NSBundle mainBundle] loadNibNamed:@"HSPOrderContentTitleView" owner:nil options:nil]lastObject];
    contentTitleView.totalPriceLabel.text = [NSString stringWithFormat:@"¥%@",self.order.real_price];
    CGFloat tX = 0;
    CGFloat tY = 0;
    CGFloat tW = HSPScreenWidth;
    CGFloat tH = 40;
    contentTitleView.frame = CGRectMake(tX, tY, tW, tH);
    [contentView addSubview:contentTitleView];
    // 商品
    for (int i = 0; i<self.order.goodsM.count; i++) {
        HSPOrderPayGoodsListView *goodsView = [[[NSBundle mainBundle] loadNibNamed:@"HSPOrderPayGoodsListView" owner:nil options:nil] lastObject];
        
        HSPGoods *goods = self.order.goodsM[i];
        goodsView.goodsNameLabel.text = goods.goods_name;
        goodsView.goodsPriceLabel.text = [NSString stringWithFormat:@"¥%@",goods.goods_price];
        
        HSPTextStepperField *stepper = [[HSPTextStepperField alloc] initWithFrame:CGRectMake(226, 9, 74, 22)];
        stepper.tag = HSPTag + i;
        [stepper addTarget:self
                    action:@selector(programmaticallyCreatedStepperDidStep:)
          forControlEvents:UIControlEventValueChanged];
        [goodsView addSubview:stepper];
        
        CGFloat goodsViewX = 0;
        CGFloat goodsViewY = CGRectGetMaxY(contentTitleView.frame) + (i * 40);
        goodsView.frame = CGRectMake(goodsViewX, goodsViewY, 300, 40);
        [self.contentView addSubview:goodsView];
    }
    
    // 订单其它信息
    HSPOrderPayView *PayView = [[[NSBundle mainBundle] loadNibNamed:@"HSPOrderPayView" owner:nil options:nil]lastObject];
    PayView.payTypeBlock = ^(int senderTag){
        YYLog(@"===%d",senderTag);
    };
    PayView.orderStatusLabel.text = [_order orderStatusStr:self.order.status];
    PayView.servicePriceLabel.text = [NSString stringWithFormat:@"%@元",self.order.server_price];
    PayView.orderSnLabel.text = [NSString stringWithFormat:@"订单编号: %@",self.order.order_sn];
    PayView.CreatedTimeLabel.text = [self.order orderTime:self.order.createtime dateFromat:@"yyyy-MM-dd  hh:mm:ss"];
    CGFloat oX = 0;
    CGFloat oY = CGRectGetMaxY(contentView.frame) + 10;
    CGFloat oW = HSPScreenWidth;
    CGFloat oH = 538;
    PayView.frame = CGRectMake(oX, oY, oW, oH);
    [_scrollView addSubview:PayView];
    
    // 底部
    [self setButtonWithStatus:self.order.real_price setTitle:@"付款" setTitleColor:HSPFontColor setBgColor:HSPBarBgColor action:@selector(pay)];
    
    CGFloat scrollH = CGRectGetMaxY(PayView.frame) + 50;
    _scrollView.contentSize = CGSizeMake(HSPScreenWidth, scrollH);
}

- (void)programmaticallyCreatedStepperDidStep:(HSPTextStepperField *)stepper {
    
    if (stepper.TypeChange == TextStepperFieldChangeKindNegative) {
        if (counter == 1) {
            counter = 1;
            return;
        }else{
            counter -= 1;
        }
    }
    else {
        
        if (counter == 99) {
            counter = 99;
            return;
        }else{
            counter += 1;
        }
    }
    
    YYLog(@"==%d++++%@---%@",stepper.tag,[NSString stringWithFormat:@"%d PR", counter],stepper.textField.text);
}

/**
 *  付款
 */
- (void)pay
{
    LogFunc
}

- (void)setButtonWithStatus:(NSString *)text setTitle:(NSString *)title setTitleColor:(UIColor *)titleColor setBgColor:(UIColor *)bgColor action:(SEL)action
{
    HSPOrderBottomView *bottomView = [[[NSBundle mainBundle] loadNibNamed:@"HSPOrderBottomView" owner:nil options:nil] lastObject];
    bottomView.totalPriceLabel.text = [NSString stringWithFormat:@"总额: %@",text];
    bottomView.totalPriceLabel.textColor = bgColor;
    [bottomView.confirmBtn setTitle:title forState:UIControlStateNormal];
    [bottomView.confirmBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [bottomView.confirmBtn setBackgroundColor:bgColor];
    [bottomView.confirmBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    bottomView.confirmBtn.frame = CGRectMake(180, 11, 50, 30);
    bottomView.frame = CGRectMake(0, 518, HSPScreenWidth, 50);
    [self.view addSubview:bottomView];
    
    // 添加取消按钮
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(125, 11, 80, 30);
    [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:HSPBarBgColor forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    cancelBtn.layer.borderWidth = 1;
    CGColorRef cgColor = HSPBarBgColor.CGColor;
    cancelBtn.layer.borderColor = cgColor;
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelBtn];
    
}

- (void)cancelBtnClick
{
    HSPAccount *account = [HSPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = account.user_id;
    params[@"tokenid"] = account.userTokenid;
    params[@"order_id"] = [NSString stringWithFormat:@"%d",_orderId];
    params[@"status"] = @"4";
    __weak JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    [self.request connectionREquesturl:orderStatusChangeUrl withPostDatas:params withDelegate:nil withBackBlock:^(id backDictionary) {
        
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
            [alert popAlert:@"取消成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [alert popAlert:[backDictionary objectForKey:@"message"]];
            return;
        }
        
    }];
}

#pragma mark - 懒加载
- (HSPHttpRequest *)request
{
    if (!_request) {
        _request = [HSPHttpRequest Instace];
    }
    return _request;
}

- (NSMutableArray *)goodsM
{
    if (!_goodsM) _goodsM = [NSMutableArray array];
    return _goodsM;
}

- (HSPOrder *)order
{
    if (!_order) _order = [[HSPOrder alloc] init];
    return _order;
}

@end
