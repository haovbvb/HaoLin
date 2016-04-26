//
//  ZYPShopAddressVC.m
//  HaoLin
//
//  Created by mac on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPShopAddressVC.h"

@interface ZYPShopAddressVC ()<BMKGeoCodeSearchDelegate,UITextViewDelegate>
{
    BMKGeoCodeSearch *search;

}
@property (nonatomic, strong)NSString *fl;
@property (nonatomic, assign)BOOL edit;
@end

@implementation ZYPShopAddressVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)over:(id)sender
{

        if ([self isEmptyOrNull:self.addressTextView.text] == YES)
    {
        self.fl = @"1";
        if (self.DManage.pushBusinessScope.coordinate.latitude != 0 && self.DManage.pushBusinessScope.coordinate.longitude != 0)
        {
            [self prama:@"shop_address" realNss:self.addressTextView.text axis:@"axis" axisSource:[NSString stringWithFormat:@"%f,%f",self.DManage.pushBusinessScope.coordinate.longitude, self.DManage.pushBusinessScope.coordinate.latitude]];
        }else
        {
            [self searchMap];
        }
    }else
    {
        [self alertWithMessage:@"商家地址不能为空"];
    }
}
/**
 *  判断商家地址是否为空，或者全是空格
 *
 */
-(BOOL)isEmptyOrNull:(NSString *) str {
    
    if (str) {
        // 空对象
        return YES;
    } else {
        
     NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            // 空字符串
            return NO;
            
        } else {
            // is neither empty nor null
            return YES;
        }
    }
}
/**
 *  正向地理编码
 *
 *  @param 没有查看地图的情况下
 */
- (void)searchMap
{
    //  通过地址搜索位置获取经纬度
//    search = [[BMKGeoCodeSearch alloc] init];
//    search.delegate = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BMKGeoCodeSearchOption *option = [[BMKGeoCodeSearchOption alloc] init];
    option.address = self.addressTextView.text;
    BOOL flag = [search geoCode:option];
    
    if (flag)
    {
        NSLog(@"成功");
    }else
    {
        [self alertWithMessage:@"获取位置信息失败，请重新获取"];
    }
}
#pragma mark - 正向地里编码代理方法
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        if (result.location.latitude == 0 && result.location.longitude == 0)
        {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self alertWithMessage:@"获取位置信息失败，请重新获取"];
            return;
        }else
        {
            [self prama:@"shop_address" realNss:self.addressTextView.text axis:@"axis" axisSource:[NSString stringWithFormat:@"%f,%f",result.location.longitude,result.location.latitude]];
        }
    }
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)mapIn:(id)sender
{
    ZYPMapViewController *mapVC = [[ZYPMapViewController alloc] initWithNibName:@"ZYPMapViewController" bundle:nil];
    mapVC.DataManage = self.DManage;
    [self.navigationController pushViewController:mapVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.addressTextView.text = self.addressTEXT;
    self.addressTextView.delegate = self;
    
    search = [[BMKGeoCodeSearch alloc] init];
    search.delegate = self;
    if (self.DManage.pushBusinessScope.coordinate.latitude != 0 && self.DManage.pushBusinessScope.coordinate.longitude != 0)
    {
        self.edit = YES;
        [self.addressTextView becomeFirstResponder];
        [self fanBianma];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    search.delegate = nil;
}
#pragma mark - textView 代理方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return self.edit;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    self.DManage = [[MQLPersonalHanDanDataManage alloc] init];
    self.titleLabel.backgroundColor = ZYPBGColor;
    self.edit = NO;
    [self alertWithMessage:@"请进入地图搜索具体位置"];
}





/**
 *  反向地理编码,获取具体的文字位置信息
 *
 */
- (void)fanBianma
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){self.DManage.pushBusinessScope.coordinate.latitude, self.DManage.pushBusinessScope.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [search reverseGeoCode:reverseGeoCodeSearchOption];
   if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
}
#pragma mark - 反向地理编码代理方法
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR)
  {
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      self.addressTextView.text = result.address;
  }
  else
  {
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      NSLog(@"抱歉，未找到结果");
      [self alertWithMessage:@"获取位置信息失败,请重新获取"];
      self.edit = NO;
      [self.addressTextView resignFirstResponder];
  }
}







/**
 *  上传接口
 *
 *  @param str        参数名
 *  @param source     上传的地址
 *  @param str1       坐标参数名
 *  @param axisSource 坐标经纬度
 */
- (void)prama:(NSString *)str realNss:(NSString *)source axis:(NSString *)str1 axisSource:(NSString *)axisSource
{
    if ([self.fl isEqualToString:@"1"])
    {
        /**
         *  显示加载状态
         */
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.fl = nil;
    }
    
    __weak ZYPShopAddressVC *addressVC = self;
    HSPAccount *accout = [HSPAccountTool account];

    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&%@=%@&%@=%@",changeBusinessInfor,accout.user_id,str,source,str1,axisSource];
    NSLog(@"%@",urlString);
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         /**
          *  隐藏加载状态
          */
         [MBProgressHUD hideAllHUDsForView:addressVC.view animated:YES];
         if ([respondObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *dic = respondObject;
             if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                 [addressVC.navigationController popViewControllerAnimated:YES];
             }else
             {
                 [addressVC alertWithMessage:[dic objectForKey:@"message"]];
             }
         }else
         {
             [addressVC alertWithMessage:@"信息上传失败"];
         }
    }];
}

//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
