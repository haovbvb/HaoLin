//
//  ZYPAddDetailView.m
//  HaoLin
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPAddDetailView.h"

@implementation ZYPAddDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib
{
    self.listArray = [[NSMutableArray alloc] initWithCapacity:0];
    // Initialization code
    self.layer.cornerRadius = 8;
    self.goodsNameText.delegate = self;
    self.goodsPriceText.delegate = self;
    self.layer.shadowOffset =  CGSizeMake(3,5);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}
/**
 *  textField代理方法
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (IS_IPHONE_5) {
        self.frame = CGRectMake(40, 60, 240, 200);
    }else
    {
        self.frame = CGRectMake(40, -25, 240, 200);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.frame = CGRectMake(40, 60, 240, 200);
    [textField resignFirstResponder];
    return YES;
}


- (void)tapView:(UITapGestureRecognizer *)tap
{
    [self.goodsPriceText resignFirstResponder];
    [self.goodsNameText resignFirstResponder];
}

- (IBAction)makeSure:(id)sender
{
    if ([self.flag isEqualToString:@"2"])
    {
        if ([self.goodsNameText.text length] > 0&&[self.goodsPriceText.text length] >0)
        {
            [self searchGoods];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"商品名和价格为必填参数哦" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }else if ([self.flag isEqualToString:@"1"])
    {
        [self editGoodsone];
    }
}
- (void)searchGoods
{
    [MBProgressHUD showHUDAddedTo:self.sheftView animated:YES];
    __weak ZYPAddDetailView *detail = self;
        ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
       HSPAccount *count = [HSPAccountTool account];

        NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&goods_name=%@",goodsList,count.user_id,count.userTokenid,self.goodsNameText.text];
        [manger connectWithUrlStr:urlString completion:^(id responedObject) {
            NSLog(@"%@",responedObject);
            if ([responedObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = responedObject;
                if ([[dic objectForKey:@"code"] intValue] == 0)
                {
                    [MBProgressHUD hideAllHUDsForView:detail.sheftView animated:YES];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"此商品已存在" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }else
                {
                    [detail addGoodsOne];
                    detail.goodsSheftVC.overBtn.enabled = YES;
                }
            }else
            {
                [MBProgressHUD hideAllHUDsForView:detail.sheftView animated:YES];
                [detail alertWithMessage:@"加载失败,请检查网络连接"];
            }
        }];
}

//  修改商品
- (void)editGoodsone
{
    [MBProgressHUD showHUDAddedTo:self.sheftView animated:YES];
    __weak ZYPAddDetailView *detail = self;
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *count = [HSPAccountTool account];

    NSString *urlstring = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&goods_id=%@&goods_name=%@&goods_price=%@",changeGoods,count.user_id,count.userTokenid,self.detailObject.goods_id,self.goodsNameText.text,self.goodsPriceText.text];
    NSLog(@"%@",urlstring);
    [manger connectWithUrlStr:urlstring completion:^(id respondObject)
    {
        [detail.goodsPriceText resignFirstResponder];
        [detail.goodsNameText resignFirstResponder];
        if ([respondObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = respondObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"])
            {
                [detail.goodsSheftVC updataCategaryTable];
            }else
            {
                [MBProgressHUD hideAllHUDsForView:detail.sheftView animated:YES];
                [detail alertWithMessage:[dic objectForKey:@"message"]];
            }
        }else
        {
            [MBProgressHUD hideAllHUDsForView:detail.sheftView animated:YES];

            [detail alertWithMessage:@"加载失败，请检查网络连接"];
        }
    }];
}

//  添加商品
- (void)addGoodsOne
{
//    [MBProgressHUD showHUDAddedTo:self.sheftView animated:YES];
    __weak ZYPAddDetailView *detail = self;
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *count = [HSPAccountTool account];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&cat_id=%@&goods_name=%@&goods_price=%@",addGood,count.user_id,count.userTokenid,self.listObject.cat_id,self.goodsNameText.text,self.goodsPriceText.text];
    NSLog(@"%@",urlString);
    [manger connectWithUrlStr:urlString completion:^(id respondObject) {
        if ([respondObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = respondObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                [detail.goodsPriceText resignFirstResponder];
                [detail.goodsNameText resignFirstResponder];
                //  添加成功，更新列表
                [detail.goodsSheftVC updataTableView];
            }else
            {
                [MBProgressHUD hideAllHUDsForView:detail.sheftView animated:YES];
                [detail.goodsPriceText resignFirstResponder];
                [detail.goodsNameText resignFirstResponder];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[dic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }else
        {
            [MBProgressHUD hideAllHUDsForView:detail.sheftView animated:YES];
            [detail.goodsPriceText resignFirstResponder];
            [detail.goodsNameText resignFirstResponder];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加载失败,请检查网络连接" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
- (IBAction)selectedCategary:(id)sender
{
    [self.goodsSheftVC createListView];
}
- (IBAction)cancel:(id)sender
{
    self.addView.hidden = YES;
    self.goodsSheftVC.overBtn.enabled = YES;
    [self.goodsNameText resignFirstResponder];
    [self.goodsPriceText resignFirstResponder];
}
- (void)alertWithMessage:(NSString *)mesage
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
