//
//  ZYPServeOrderDetailVC.m
//  HaoLin
//
//  Created by mac on 14-9-5.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPServeOrderDetailVC.h"

@interface ZYPServeOrderDetailVC ()
{
    ZYPServeOrderBottomView *bottomView;
    ZYPServeOrderDetailView *serveView;
}
@property (nonatomic, strong)ZYPOrderDetailObject *orderDetailObject;
@property (nonatomic, strong)ZYPUserObject *userObject;
@end

@implementation ZYPServeOrderDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([[ZYPObjectManger shareInstance].barTitle isEqualToString:@"pet"]) {
            self.hidesBottomBarWhenPushed = YES;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ZYPObjectManger shareInstance].barTitle1 = @"come";
    bottomView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPServeOrderBottomView" owner:self options:nil] lastObject];
    
    bottomView.serveVC = self;
    if (IS_IPHONE_5)
    {
       self.view.frame = CGRectMake(0, 0, 320, 568);
       bottomView.frame = CGRectMake(0, 504, 320, 60);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
       bottomView.frame = CGRectMake(0, 420, 320, 60);
    }
    serveView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPServeOrderDetailView" owner:self options:nil] lastObject];
    serveView.btn.hidden = YES;
    serveView.detailVC = self;
    bottomView.hidden = YES;
    [self.view addSubview:serveView];
    [self getSource];
}
- (void)getSource
{
    

    
    //  显示加载图标
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak ZYPServeOrderDetailVC *detailVC = self;
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *acout = [HSPAccountTool account];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&order_id=%@",orderDetailInfor,acout.user_id,acout.userTokenid,self.servrObject.order_id];
    [manger connectWithUrlStr:urlString completion:^(id respondObject) {
        NSLog(@"%@",respondObject);
        if ([respondObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = respondObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"])
            {
                NSDictionary *dicSource = [dic objectForKey:@"data"];
                detailVC.orderDetailObject = [[ZYPOrderDetailObject alloc] initWithOrderDetailDic:dicSource];
                detailVC.userObject = [[ZYPUserObject alloc] initUserObjectWithDic:[dicSource objectForKey:@"userinfo"]];
                //  隐藏图标
                [MBProgressHUD hideAllHUDsForView:detailVC.view animated:YES];
                
                serveView.servrObject = detailVC.servrObject;
                serveView.orderDetailObject = detailVC.orderDetailObject;
                serveView.userObject = detailVC.userObject;
                /**
                 *  通知view进行布局，对象已经传递完成
                 */
                [[NSNotificationCenter defaultCenter] postNotificationName:@"2" object:nil];

                bottomView.totalMoney.text = [NSString stringWithFormat:@"总额:面议"];
                
                                [bottomView.cancelBtn removeFromSuperview];
                [detailVC.view addSubview:bottomView];
                bottomView.hidden = NO;
        }else
        {
                //  隐藏图标
                [MBProgressHUD hideAllHUDsForView:detailVC.view animated:YES];
            serveView.btn.hidden = NO;
            [detailVC.view addSubview:serveView];

                [detailVC alertWithMessage:[dic objectForKey:@"message"]];
            }
        }else
        {
            //  隐藏图标
            [MBProgressHUD hideAllHUDsForView:detailVC.view animated:YES];
            serveView.btn.hidden = NO;
            [detailVC.view addSubview:serveView];
            [detailVC alertWithMessage:@"加载失败,请检查网络连接"];
        }
    }];
}
//刷新view
- (void)refreshView
{
    serveView.btn.hidden = YES;
    [self getSource];
}

//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
/**
 *  确认发货订单
 */
- (void)cancelDingDan
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *account = [HSPAccountTool account];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&order_id=%@&status=4",changeDingDanState,account.user_id,account.userTokenid,self.orderDetailObject.order_id];
    __weak ZYPServeOrderDetailVC *detailVc = self;
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         if ([respondObject isKindOfClass:[NSDictionary class]]) {
             NSDictionary *dic = respondObject;
             if ([[dic objectForKey:@"code"] intValue] == 0)
             {
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                 [detailVc alertWithMessage:[dic objectForKey:@"message"]];
                 /**
                  *  状态更新成功，改变btn的状态和title
                  */
                 [bottomView.cancelBtn setTitle:@"服务中" forState:UIControlStateNormal];
                 bottomView.cancelBtn.enabled = NO;
                 bottomView.cancelBtn.backgroundColor = [UIColor grayColor];
             }else
             {
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                 [detailVc alertWithMessage:[dic objectForKey:@"message"]];
             }
         }else
         {
             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             [detailVc alertWithMessage:@"取消失败，请重试"];
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
