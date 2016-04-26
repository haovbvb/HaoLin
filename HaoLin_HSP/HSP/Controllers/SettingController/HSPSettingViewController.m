//
//  HSPSettingViewController.m
//  HaoLin
//
//  Created by PING on 14-10-16.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPSettingViewController.h"
@class HSPAccount;

@interface HSPSettingViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate>

@property (nonatomic, strong) HSPHttpRequest *request;
@property (nonatomic, strong) UIImage *imageUpload;
@property (nonatomic, strong) HSPUserInfo *userInfo;
@property (nonatomic, strong) HSPAccount *account;
@property (nonatomic, strong) HSPDeliveryAddressView *addressView;

@property (nonatomic, strong) NSArray *dataList;
@end

@implementation HSPSettingViewController


//- (id)initWithStyle:(UITableViewStyle)style
//{
//    return [super initWithStyle:UITableViewStyleGrouped];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataList = [HSPProfileGroup groupsWithName:@"user.plist"];
    _request = [HSPHttpRequest Instace];
    _account = [HSPAccountTool account];
    
    [self setupConfig];
    
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 发送请求
    [self sendRequest];
}

- (void)setupConfig
{
    self.title = @"完善个人资料";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor, NSForegroundColorAttributeName, nil]];
    self.view.backgroundColor = HSPBgColor;
    [self.addressView.changeAddress addTarget:self action:@selector(changeAddress) forControlEvents:UIControlEventTouchUpInside];
    
    
}


/**
 *  发送请求
 */
- (void)sendRequest
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak JZDCustomAlertView *alert = [JZDCustomAlertView sharedInstace];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = self.account.user_id;
    params[@"tokenid"] = self.account.userTokenid;
    [self.request connectionREquesturl:userInfoUrl withPostDatas:params withDelegate:nil withBackBlock:^(id backDictionary) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //        YYLog(@"backDictionary==%@",backDictionary);
        if ([backDictionary isKindOfClass:[NSError class]]) {
            [alert popAlert:@"获取数据失败"];
            return;
        }
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
            _userInfo = [HSPUserInfo objectWithKeyValues:[backDictionary objectForKey:@"data"]];
            self.addressView.userInfoItem = _userInfo;
            
            if ([_userInfo.qq_number isEqualToString:@"0"]) {
                _userInfo.qq_number = @" ";
            }
            
            if ([_userInfo.gender isEqualToString:@"1"]) {
                _userInfo.gender = @"男";
            }else{
                _userInfo.gender = @"女";
            }
            [self.tableView reloadData];
        }else{
            [alert popAlert:@"获取数据失败"];
            return;
        }
        
    }];
}


/**
 *  修改地址
 */
- (void)changeAddress
{
    HSPEditViewController *vc = [[HSPEditViewController alloc] initWithNibName:@"HSPEditViewController" bundle:nil];
    vc.title = @"常用收货地址";
    vc.submitTextId = @"delivery_address";
    vc.submitText = _userInfo.delivery_address;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 62;
    }else{
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = [self.dataList[section] items];
    return items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    HSPProfileGroup *group = self.dataList[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [self.dataList[section] footer];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ProfileCell";
    HSPProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HSPProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 取出indexPath(section,row)对应设置条目
    HSPProfileGroup *group = self.dataList[indexPath.section];
    HSPProfileItem *item = group.items[indexPath.row];
    
    item.userInfo = _userInfo;
    cell.item = item;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSPProfileGroup *group = self.dataList[indexPath.section];
    HSPProfileItem *item = group.items[indexPath.row];
    
    // 检查是否PUSH新的视图控制器
    if (item.destClassName) {
        HSPEditViewController *vc = [[HSPEditViewController alloc] initWithNibName:@"HSPEditViewController" bundle:nil];
        if (indexPath.section == 1 && indexPath.row == 0) {
            vc.submitTextId = @"nickname";
            vc.submitText = _userInfo.nickname;
        }else  if (indexPath.section == 1 && indexPath.row == 2) {
            vc.submitTextId = @"qq_number";
            vc.submitText = _userInfo.qq_number;
        }else if (indexPath.section == 1 && indexPath.row == 3) {
            vc.submitTextId = @"email";
            vc.submitText = _userInfo.email;
        }else if (indexPath.section == 1 && indexPath.row == 4) {
            vc.submitTextId = @"phone";
            vc.submitText = _userInfo.mobile;
        }else if (indexPath.section == 1 && indexPath.row == 5) {
            vc.submitTextId = @"user_desc";
            vc.submitText = _userInfo.user_desc;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 调用方法
    if (item.callFunction) {
        SEL func = NSSelectorFromString(item.callFunction);
        SuppressPerformSelectorLeakWarning([self performSelector:func]);
    }
}

/**
 *  修改性别
 */
- (void)chooseGender
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    sheet.tag = 1;
    [sheet showInView:self.view];
}

/**
 *  修改图片
 */
- (void)chooseHeadIcon
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    sheet.tag = 0;
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(int)buttonIndex
{
    if (actionSheet.tag == 0) {
        // 上传图片
        if (buttonIndex==0) {
            // 从相册选择
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                [self getPhotoWithSourceType];
            }
        }else if (buttonIndex==1){
            // 拍照获得
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self cameraGetPhoto];
            }
        }
    }else if (actionSheet.tag == 1){
        // 修改性别
        if (!buttonIndex == 2) {
            [self requestGender:buttonIndex + 1];
        }
    }
    
}

- (void)requestGender:(int)genderIndex
{
    if (genderIndex == 1) {
        _userInfo.gender = @"男";
    }else if (genderIndex == 2){
        _userInfo.gender = @"女";
    }else{
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
    
    HSPAccount *account = [HSPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = account.user_id;
    params[@"tokenid"] = account.userTokenid;
    params[@"gender"] = [NSString stringWithFormat:@"%d",genderIndex];
    [self.request connectionREquesturl:changeUserInfoUrl withPostDatas:params withDelegate:nil withBackBlock:^(id backDictionary) {
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
        }
    }];
}

/**
 *  从相册选择
 */
-(void)getPhotoWithSourceType
{
    UIImagePickerController *pic=[[UIImagePickerController alloc] init];
    [pic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    pic.delegate=self;
    [self presentViewController:pic animated:YES completion:nil];
}

/**
 *  从拍照选择
 */
-(void)cameraGetPhoto
{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
    ipc.delegate=self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        // 将拍的照片保存到相册
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self imageCrop:image];
        });
        [picker dismissViewControllerAnimated:YES completion:nil];
    }else{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self imageCrop:image];
        });
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        
        
    }
    
    
    
}

- (void)imageCrop:(UIImage *)image
{
    // Edit image
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeCircle];
    imageCropVC.delegate = self;
    [self presentViewController:imageCropVC animated:YES completion:nil];
}

#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.userInfo.tempHeadImg = croppedImage;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
    }];
    __weak typeof(self) wself=self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wself uploadHeadImage:croppedImage];
    });
}

-(void)saveImage:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

/**
 *  上传头像
 */
- (void)uploadHeadImage:(UIImage *)image
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = self.account.user_id;
    params[@"tokenid"] = self.account.userTokenid;
    params[@"headimg"] = @"headimg";
    
    __weak JZDCustomAlertView *alert  = [JZDCustomAlertView sharedInstace];
    [self.request connectionUpLoadImage:image parameters:params url:uploadHeadImgUrl withBlock:^(NSDictionary *dict) {
        //        YYLog(@"NSThread==%@",[NSThread currentThread])
        if ([dict isKindOfClass:[NSError class]]) {
            [alert popAlert:@"修改失败"];
            return;
        }
        if ([[dict objectForKey:@"code"] isEqualToString:@"0"]) {
            HSPAccount *account = [HSPAccountTool account];
            account.headimg = [[dict objectForKey:@"data"] objectForKey:@"headimg"];
            //            [HSPAccountTool saveAccount:account];
        }else{
            [alert popAlert:@"修改失败"];
            return;
        }
    }];
}

#pragma mark - 懒加载
- (HSPUserInfo *)userInfo
{
    if (!_userInfo) _userInfo = [[HSPUserInfo alloc] init];
    return _userInfo;
}

- (HSPDeliveryAddressView *)addressView
{
    if (!_addressView) {
        _addressView = [[[NSBundle mainBundle] loadNibNamed:@"HSPDeliveryAddressView" owner:nil options:nil] lastObject];
        self.tableView.tableFooterView = _addressView;
    }
    return _addressView;
}

@end
