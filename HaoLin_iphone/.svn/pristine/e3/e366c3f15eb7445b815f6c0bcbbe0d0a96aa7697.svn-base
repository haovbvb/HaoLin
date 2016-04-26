//
//  ZYPCompleteinfoVC.m
//  HaoLin
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPCompleteinfoVC.h"

@interface ZYPCompleteinfoVC ()
{
    UIImagePickerController *imagePicker;
    ZYPScopeViewController *scopevc;
    ZYPCustomeCell  *cell;
    NSString *str1;
}
@property (nonatomic,strong)NSMutableArray *sourceArray;
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation ZYPCompleteinfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [scopevc callback:^(NSMutableArray *arr) {
       
        if (arr.count > 4) {
            NSRange range;
            range.location = 3;
            range.length = arr.count - 3;
            [arr removeObjectsInRange:range];
        }else if (arr.count == 3) {
            str1 = [NSString stringWithFormat:@"%@,%@,%@",[arr objectAtIndex:0],[arr objectAtIndex:1],[arr objectAtIndex:2]];
            cell.nameLabel.text = str1;
        }else if (arr.count == 2)
        {
            str1 = [NSString stringWithFormat:@"%@,%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
            cell.nameLabel.text = str1;
        }else if(arr.count == 1)
        {
            str1 = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
            cell.nameLabel.text = str1;
        }else if (arr.count == 0)
        {
            str1 = [NSString stringWithFormat:@""];
            cell.nameLabel.text = str1;
        }
        NSLog(@"%@",cell.nameLabel.text);
    }];

}
//  移除观察者
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"popToRootViewController" object:nil];
}
//  方法
- (void)backInto
{
    MQLPartyViewController *part = [[MQLPartyViewController alloc] initWithNibName:@"MQLPartyViewController" bundle:nil];
    [self.navigationController pushViewController:part animated:NO];
    
}

- (void)viewDidLoad
{
    self.sourceArray = [[NSMutableArray alloc] initWithCapacity:0];
    [super viewDidLoad];
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }

    //  添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backInto) name:@"popToRootViewController" object:nil];
    // Do any additional setup after loading the view from its nib.
    
}
#pragma mark - tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
        label.font = [UIFont systemFontOfSize:19];
        label.textColor = [UIColor orangeColor];
        label.text = @"上传商户图像信息";
        [v addSubview:label];
        return v;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }else if(indexPath.section == 1)
    {
        return 300;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *indentifier = @"indentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPCustomeCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = str1;
        return cell;
    }else if (indexPath.section == 1)
    {
        static NSString *indentifier = @"indentifie";
        ZYPAddImageCell *cell1 = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell1 == nil) {
            cell1 = [[[NSBundle mainBundle] loadNibNamed:@"ZYPAddImageCell" owner:self options:nil] lastObject];
        }
         cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        //  添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage:)];
        tap.numberOfTapsRequired = 1;
        [cell1.businessLicenseImage addGestureRecognizer:tap];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage:)];
        tap.numberOfTapsRequired = 1;
        [cell1.IDIamge addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage:)];
        tap.numberOfTapsRequired = 1;
        [cell1.healthImage addGestureRecognizer:tap2];
        
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage:)];
        tap.numberOfTapsRequired = 1;
        [cell1.IDImageF addGestureRecognizer:tap3];
        return cell1;
    }
    return nil;
}
- (void)addImage:(UITapGestureRecognizer *)tap
{
    //  获得点击的imageView
    self.imageView = (UIImageView *)tap.view;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"选择图片源" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册",@"拍照", nil];
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
        }
    }else if (buttonIndex == 2)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        }
    }
     [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark - 图片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //  从相册获取照片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //  显示到imageView上
    self.imageView.image = image;
    //  将图片放到数组中
    [self.sourceArray addObject:image];
    //  上传图片
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    ZYPObjectManger *object = [ZYPObjectManger shareInstance];
    [manger uploadImage:image userID:object.loginInObject.user_id  token:object.loginInObject.tokenid name:@"headimg.jpg" completion:^(id responedObject) {
        NSLog(@"%@",responedObject );
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//   点击cell触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        scopevc = [[ZYPScopeViewController alloc] initWithNibName:@"ZYPScopeViewController" bundle:nil];
        [self.navigationController pushViewController:scopevc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 64;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *custome = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(100, 14, 120, 40);
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:19];
        btn.titleLabel.textColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(commitInformation:) forControlEvents:UIControlEventTouchUpInside];
        [custome addSubview:btn];
        return custome;
    }
    return nil;
}
//  提交信息
- (void)commitInformation:(UIButton *)btn
{
   
}
- (void)commitWithUrl:(NSString *)urlStr imagesArray:(NSMutableArray *)array
{
//    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
//    ZYPObjectManger *object = [ZYPObjectManger shareInstance];
//    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&range_catstr=%@",changeBusinessInfor];
}
//  返回按钮
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
