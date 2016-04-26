//
//  HSPOrderAllCell.m
//  HaoLin
//
//  Created by PING on 14-9-9.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPOrderAllCell.h"

#define HSPPadding 10
#define HSPTitleFont 16
#define HSPGreenBgBtnColor HSPColor(12, 175, 83)



@interface HSPOrderAllCell ()


@end

@implementation HSPOrderAllCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = HSPColor(248, 248, 248);
        
        UIView *topView = [[UIView alloc] init];
        [self addSubview:topView];
        self.topView = topView;
        
        UIView *goodsView = [[UIView alloc] init];
        [self addSubview:goodsView];
        self.goodsView = goodsView;
        
        UIView *totalView = [[UIView alloc] init];
        [self addSubview:totalView];
        self.totalView = totalView;
        
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        self.bottomView = bottomView;
        
        
    }
    return self;
}


- (void)setOrder:(HSPOrder *)order
{
    _order = order;
    
    for (HSPOrderCreatedTimeView *v in self.topView.subviews) {
        [v removeFromSuperview];
    }
    
    HSPOrderCreatedTimeView *createdTimeView = [[[NSBundle mainBundle] loadNibNamed:@"HSPOrderCreatedTimeView" owner:nil options:nil] lastObject];
    createdTimeView.createdTimeLabel.text = [order orderTime:order.createtime dateFromat:nil];
    createdTimeView.orderTitle.text = order.cat_name;
    
    int imageS = [order.cat_id intValue];
    switch (imageS) {
        case 3:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_3"];
            break;
        case 4:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_4"];
            break;
        case 5:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_5"];
            break;
        case 6:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_6"];
            break;
        case 7:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_7"];
            break;
        case 8:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_8"];
            break;
        case 9:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_9"];
            break;
        case 10:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_10"];
            break;
        case 11:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_11"];
            break;
        case 12:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_12"];
            break;
        case 13:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_13"];
            break;
        case 14:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_14"];
            break;
        case 15:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_15"];
            break;
        case 16:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_16"];
            break;
        case 17:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_17"];
            break;
        case 18:
            createdTimeView.orderIcon.image = [UIImage imageNamed:@"MQLKindId_18"];
            break;
            
        default:
            break;
    }
    
    
    [self.topView addSubview:createdTimeView];
    self.topView.frame = CGRectMake(0, 10, HSPScreenWidth, 44);
    
    // 商品
    if (order.goodsM.count) {
        for (int i = 0; i<order.goodsM.count; i++) {
            HSPOrderGoodsView *goodsView = [[[NSBundle mainBundle] loadNibNamed:@"HSPOrderGoodsView" owner:nil options:nil] lastObject];
            goodsView.tag=100+i;
            HSPGoods *goods = order.goodsM[i];
            goodsView.goodsNameLabel.text = goods.goods_name;
            goodsView.goodsCountLabel.text = goods.goods_num;
            goodsView.goodsPriceLabel.text = [NSString stringWithFormat:@"¥%@",goods.goods_price];
            
            CGFloat goodsViewX = HSPPadding - 10;
            CGFloat goodsViewY = CGRectGetMaxY(self.topView.frame) + (i * 25) - 50;
            goodsView.frame = CGRectMake(goodsViewX, goodsViewY, 300, 25);
            [self.goodsView addSubview:goodsView];
            
            self.goodsView.frame = CGRectMake(0, 50, HSPScreenWidth, (i+1)*27);
        }
    }
    
    int s = [order.status intValue];
    if ([order.order_type isEqualToString:@"1"]) {
        
        for (HSPServiceCountView *v in self.totalView.subviews) {
            [v removeFromSuperview];
        }
        
        // 总计
        CGFloat totalY;
        if (order.goodsM.count) {
            totalY = CGRectGetMaxY(self.goodsView.frame);
        }else{
            totalY = CGRectGetMaxY(self.topView.frame);
        }
        CGFloat totalX = 0;
        CGFloat totalW = HSPScreenWidth;
        CGFloat totalH = 80;
        self.totalView.frame = CGRectMake(totalX, totalY, totalW, totalH);
        HSPOrderCountView *countView = [[[NSBundle mainBundle] loadNibNamed:@"HSPOrderCountView" owner:nil options:nil] lastObject];
        countView.servicePrice.text = [NSString stringWithFormat:@"¥%@",order.server_price];
        countView.totalPrice.text = [NSString stringWithFormat:@"¥%@",order.real_price];
        _voiceBtn = countView.voiceBtn;
        [self.totalView addSubview:countView];
        
        // 状态 订单状态（0：订单取消，1.已确认，2.未支付，3.已支付，4.已发货，5.已完成，6.已评价, 7,）
        CGFloat bottomX = 0;
        CGFloat bottomY = CGRectGetMaxY(self.totalView.frame);
        CGFloat bottomW = HSPScreenWidth;
        CGFloat bottomH = 40;
        self.bottomView.frame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
        
        
        switch (s) {
            case 0:
                [self setButtonWithStatus:@"订单取消" setTitle:@"订单关闭" setTitleColor:HSPFontColor setBgColor:[UIColor lightGrayColor]];
                break;
            case 1:
                [self setButtonWithStatus:@"已确认" setTitle:@"确认订单" setTitleColor:HSPFontColor setBgColor:HSPBarBgColor];
                break;
            case 2:
                [self setButtonWithStatus:@"待发货" setTitle:@"等待发货" setTitleColor:HSPFontColor setBgColor:HSPBarBgColor];
                break;
            case 3:
                [self setButtonWithStatus:@"待发货" setTitle:@"等待发货" setTitleColor:HSPFontColor setBgColor:HSPGreenBgBtnColor];
                break;
            case 4:
                [self setButtonWithStatus:@"已发货" setTitle:@"确认收货" setTitleColor:HSPFontColor setBgColor:HSPBarBgColor];
                break;
            case 5:
                [self setButtonWithStatus:@"已完成" setTitle:@"已发货" setTitleColor:HSPFontColor setBgColor:HSPGreenBgBtnColor];
                break;
            case 6:
                [self setButtonWithStatus:@"已完成" setTitle:@"已发货" setTitleColor:HSPFontColor setBgColor:HSPGreenBgBtnColor];
                break;
                
            default:
                break;
        }
        
    }else{
        
        for (HSPOrderCountView *v in self.totalView.subviews) {
            [v removeFromSuperview];
        }
        
        // 总计
        CGFloat totalY;
        if (order.goodsM.count) {
            totalY = CGRectGetMaxY(self.goodsView.frame);
        }else{
            totalY = CGRectGetMaxY(self.topView.frame);
        }
        CGFloat totalX = 0;
        CGFloat totalW = HSPScreenWidth;
        CGFloat totalH = 80;
        self.totalView.frame = CGRectMake(totalX, totalY, totalW, totalH);
        
        switch (s) {
            case 0:
                [self setServiceStatus:order.server_price realPrice:order.real_price setTitle:@"订单关闭" setTitleColor:HSPFontColor setBgColor:[UIColor lightGrayColor]];
                break;
            case 1:
                [self setServiceStatus:order.server_price realPrice:order.real_price setTitle:@"确认订单" setTitleColor:HSPFontColor setBgColor:HSPBarBgColor];
                break;
            case 2:
                [self setServiceStatus:order.server_price realPrice:order.real_price setTitle:@"等待服务" setTitleColor:HSPFontColor setBgColor:HSPBarBgColor];
                break;
            case 3:
                [self setServiceStatus:order.server_price realPrice:order.real_price setTitle:@"已服务" setTitleColor:HSPFontColor setBgColor:HSPGreenBgBtnColor];
                break;
            case 4:
                [self setServiceStatus:order.server_price realPrice:order.real_price setTitle:@"确认服务" setTitleColor:HSPFontColor setBgColor:HSPGreenBgBtnColor];
                break;
            case 5:
                [self setServiceStatus:order.server_price realPrice:order.real_price setTitle:@"已服务" setTitleColor:HSPFontColor setBgColor:HSPGreenBgBtnColor];
                break;
            case 6:
                [self setServiceStatus:order.server_price realPrice:order.real_price setTitle:@"已服务" setTitleColor:HSPFontColor setBgColor:[UIColor lightGrayColor]];
                break;
                
            default:
                break;
        }
    }
}

/**
 *  设置按钮状态
 *
 */
- (void)setButtonWithStatus:(NSString *)text setTitle:(NSString *)title setTitleColor:(UIColor *)titleColor setBgColor:(UIColor *)bgColor
{
    HSPOrderStatusView *statusView = [[[NSBundle mainBundle] loadNibNamed:@"HSPOrderStatusView" owner:nil options:nil] lastObject];
    statusView.statusLabel.text = text;
    statusView.statusLabel.textColor = bgColor;
    [statusView.statusBtn setTitle:title forState:UIControlStateNormal];
    [statusView.statusBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [statusView.statusBtn setBackgroundColor:bgColor];
    [self.bottomView addSubview:statusView];
    _confirmBtn = statusView.statusBtn;
    
}

- (void)setServiceStatus:(NSString *)servicePrice realPrice:(NSString *)realPrice setTitle:(NSString *)title setTitleColor:(UIColor *)titleColor setBgColor:(UIColor *)bgColor
{
    HSPServiceCountView *countView = [[[NSBundle mainBundle] loadNibNamed:@"HSPServiceCountView" owner:nil options:nil] lastObject];
    countView.servicePrice.text = [NSString stringWithFormat:@"¥%@",servicePrice];
    countView.totalPrice.text = [NSString stringWithFormat:@"¥%@",realPrice];
    [countView.actionBtn setTitle:title forState:UIControlStateNormal];
    [countView.actionBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [countView.actionBtn setBackgroundColor:bgColor];
    _voiceBtn = countView.voiceBtn;
    _confirmBtn = countView.actionBtn;
    [self.totalView addSubview:countView];
    
}






@end
