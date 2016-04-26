//
//  ZYPRegWriteInformationVC.m
//  HaoLin
//
//  Created by mac on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPRegWriteInformationVC.h"

@interface ZYPRegWriteInformationVC ()<BMKGeoCodeSearchDelegate>
{
    UIImagePickerController *imagePicker;
    UIImageView *imageview;
    UIImageView *imageview1;
    UIImageView *imageview2;
    UIImageView *imageview3;
    UIImageView *imageview4;
    BMKGeoCodeSearch *_search;
    BMKGeoCodeResult * coord;
    NSString *categary;
    ZYPScopeVC *scopeVC;
    BOOL A;
    BOOL S;
    BMKGeoCodeSearch *search;
}
@property (nonatomic, strong)NSString *text;
@property (nonatomic, assign)BOOL W;
@property (nonatomic, strong)CLLocation *result;
@property (nonatomic, strong)NSMutableArray *imagesArray;
@property (nonatomic, strong)NSMutableArray *imageviewArray;
@property (nonatomic, assign)BOOL state;

@end

@implementation ZYPRegWriteInformationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
/**
 *  手势方法
 *
 */
- (void)resignXiange:(UITapGestureRecognizer *)tap
{
    if (self.DManage.pushBusinessScope.coordinate.latitude == 0 && self.DManage.pushBusinessScope.coordinate.longitude == 0 && [self.shopAddressText.text length] > 0)
    {
        [self searchMap];
    }
    [self.shopAddressText resignFirstResponder];

}
/**
 *  反向地理编码,获取具体的文字位置信息
 *
 */
- (void)fanBianma
{
    [MBProgressHUD showHUDAddedTo:self.scrollView animated:YES];
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
        [MBProgressHUD hideAllHUDsForView:self.scrollView animated:YES];
        [self alertWithMessage:@"获取位置信息失败，请检查网络"];
    }
}
#pragma mark - 反向地理编码代理方法
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        [MBProgressHUD hideAllHUDsForView:self.scrollView animated:YES];
        self.shopAddressText.text = result.address;
    }
    else
    {
        [MBProgressHUD hideAllHUDsForView:self.scrollView animated:YES];
        [self alertWithMessage:@"获取位置信息失败,请重新获取"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.shopAddressText resignFirstResponder];
    [super viewWillAppear:animated];
    search = [[BMKGeoCodeSearch alloc] init];
    search.delegate = self;
    if (self.DManage.pushBusinessScope.coordinate.latitude != 0 && self.DManage.pushBusinessScope.coordinate.longitude != 0)
    {
        [self fanBianma];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    scopeVC = [[ZYPScopeVC alloc] initWithNibName:@"ZYPScopeVC" bundle:nil];
    self.navigationController.navigationBar.hidden = YES;
    self.DManage = [[MQLPersonalHanDanDataManage alloc] init];
    /**
     *  初始化动态数组
     */
    self.imagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.imageviewArray = [[NSMutableArray alloc] initWithCapacity:0];
    A = YES;
    S = YES;
    /**
     *  分类button设置
     */
    self.realGoodBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.serviceBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.realGoodBtn.layer.borderWidth = 1;
    self.serviceBtn.layer.borderWidth = 1;
    /**
     *  屏幕适配
     */
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
        self.scrollView.contentSize = CGSizeMake(320, 600);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.scrollView.frame = CGRectMake(0, 64, 320, 416);
        self.scrollView.contentSize = CGSizeMake(320,500);
    }
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    /**
     *  取消地址textField响应
     */
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignXiange:)];
    tap1.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:tap1];
    /**
     *  自定义导航条
     */
    ZYPNavagationView *naView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPNavagationView" owner:self options:nil] lastObject];
    naView.backgroundColor = ZYPBGColor;
    naView.titleLabel.text = @"填写资料";
    naView.writeVC = self;
    naView.frame = CGRectMake(0, 0, 320, 64);
    [self.view addSubview:naView];
    /**
     *  添加图片手势
     *
     *  @param idImage: 手势方法
     *
     *  @return 获取从相册获得的图片
     */
    SEL action = @selector(idImage:);
    UITapGestureRecognizer *idtap = [self withAction:action];
    self.idImage1.userInteractionEnabled = YES;
    self.idImage1.tag = 101;
    [self.idImage1 addGestureRecognizer: idtap];
    UITapGestureRecognizer *idtap1 = [self withAction:action];
    self.idImage2.userInteractionEnabled = YES;
    self.idImage2.tag = 102;
    [self.idImage2 addGestureRecognizer: idtap1];
    UITapGestureRecognizer *locensetap1 = [self withAction:action];
    self.licenseImage1.userInteractionEnabled = YES;
    self.licenseImage1.tag = 103;
    [self.licenseImage1 addGestureRecognizer:locensetap1];
    UITapGestureRecognizer *locensetap2 = [self withAction:action];
    self.licenseImage2.tag = 104;
    self.licenseImage2.userInteractionEnabled = YES;
    [self.licenseImage2 addGestureRecognizer:locensetap2];
    
}
#pragma mark - textField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self searchMap];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)idImage:(UITapGestureRecognizer *)tap
{
    imageview = (UIImageView *)tap.view;
    imageview.tag = tap.view.tag;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"选择图片" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册",@"拍照", nil];
    [alertView show];
}
#pragma mark - alert代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.navigationController.delegate = self;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 1) {
        //  判断相机是否尅一得到
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        
    }else if (buttonIndex == 2)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
}
#pragma mark - 图片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    switch (imageview.tag) {
        case 101:
            imageview1 = imageview;
            imageview1.image = image;
            break;
        case 102:
            imageview2 = imageview;
            imageview2.image = image;
            break;
        case 103:
            imageview3 = imageview;
            imageview3.image = image;
            break;
        case 104:
            imageview4 = imageview;
            imageview4.image = image;
            break;
        default:
            break;
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITapGestureRecognizer *)withAction:(SEL)action
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    tap.numberOfTapsRequired = 1;
    return tap;
}
//  选择类别按钮
- (IBAction)realGood:(id)sender
{
    if (A == YES) {
        if (S == YES) {
            [self.realGoodBtn setBackgroundImage:[UIImage imageNamed:@"ZYPcheck@2x.png"] forState:UIControlStateNormal];
            A = NO;
        }
        
    }else if (A == NO)
    {
        [self.realGoodBtn setBackgroundImage:nil forState:UIControlStateNormal];
        A = YES;
    }
}

- (IBAction)service:(id)sender
{
    if (S == YES) {
        if  (A == YES){
            [self.serviceBtn setBackgroundImage:[UIImage imageNamed:@"ZYPcheck@2x.png"] forState:UIControlStateNormal];
            S = NO;
        }
        
    }else if (S == NO)
    {
        [self.serviceBtn setBackgroundImage:nil forState:UIControlStateNormal];
        S = YES;
    }
}
- (IBAction)mapSearch:(id)sender
{
    ZYPMapViewController *mapVC = [[ZYPMapViewController alloc] initWithNibName:@"ZYPMapViewController" bundle:nil];
    mapVC.DataManage = self.DManage;
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (IBAction)nextStep:(id)sender
{
    self.DManage.sendAddress = self.shopAddressText.text;
    NSArray *array = [NSArray arrayWithObjects:imageview1,imageview2,imageview3,imageview4, nil];
    if (self.imagesArray.count <=4) {
        for (int i = 0; i < array.count; i ++)
        {
            UIImageView *imageView = [array objectAtIndex:i];
            if(imageView.image != nil)
            {
            [self.imagesArray addObject:imageView.image];
            }
        }
    }
    //  判读选择是实物还是服务
    if (A == NO) {
        categary = @"1";//@"实物"
    }
    if (S == NO) {
        categary = @"2";//@"服务"
    }

    if ([self.shopNameText.text length] == 0)
    {
        [self alertWithMessage:@"商店名称还没填写哦亲"];
        return;
    }else if ([self.shopAddressText.text length] == 0)
    {
        [self alertWithMessage:@"请输入商店详细位置哦亲"];
        return;
    }else if ([categary length] == 0)
    {
        [self alertWithMessage:@"商户类型还没选择哦亲"];
        return;
    }else if ([self.imagesArray count] < 3)
    {
        [self alertWithMessage:@"至少需要提交三照片哦亲"];
        return;
    }else if ((self.DManage.pushBusinessScope.coordinate.latitude == 0 && self.DManage.pushBusinessScope.coordinate.longitude == 0) &&  (coord.location.latitude == 0 && coord.location.longitude == 0))
    {
        [self alertWithMessage:@"获取位置信息失败，请重新获取"];
        return;
    }else
    {
            scopeVC.shopName = self.shopNameText.text;
            scopeVC.shopAddress = self.shopAddressText.text;
            scopeVC.imagesArr = self.imagesArray;
            scopeVC.categary = categary;
            scopeVC.result = self.DManage.pushBusinessScope;
            scopeVC.coord = coord;
            scopeVC.userid = self.user_id;
            [self.navigationController pushViewController:scopeVC animated:YES];
    }
}
//  获取经纬度(没有查看地图的情况下)
- (void)searchMap
{
    //  通过地址搜索位置获取经纬度
    _search = [[BMKGeoCodeSearch alloc] init];
    _search.delegate = self;
    BMKGeoCodeSearchOption *option = [[BMKGeoCodeSearchOption alloc] init];
    option.address = self.shopAddressText.text;
    BOOL flag = [_search geoCode:option];
    
    if (flag)
    {
        NSLog(@"成功");
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取地理位置失败" message:@"请检查网络并重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
#pragma mark - 代理方法
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        
        if (result.location.latitude == 0 && result.location.longitude == 0)
        {
            [self alertWithMessage:@"获取位置信息失败，请重新获取"];
            return;
        }else
        {
            coord = result;
        }

    }
}
- (void)panduanInfor
{
    
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
