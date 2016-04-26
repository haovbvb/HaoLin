//
//  JZDPublishSecViewController.m
//  HaoLin
//
//  Created by Zidon on 14-9-10.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDPublishSecViewController.h"

@interface JZDPublishSecViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    int temp;
    int ory;
    int height;
    __block BOOL publish;
    NSMutableArray *imageArray;
    NSMutableArray *buttonArray;
    NSMutableArray *mutable;
    JZDModuleHttpRequest *request;
}
@property (nonatomic,copy) NSString *cateGrayIdString;
@end

@implementation JZDPublishSecViewController
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.edgesForExtendedLayout=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sdf:) name:UIKeyboardWillShowNotification object:nil];
    temp=0;
    publish=NO;
//    _showCateGray.buttonTitleRect=CGRectMake(5, -3, 80, 30);
//    _showCateGray.buttonImageRect=CGRectMake(80, 5, 15, 15);
    ory=_addImageBtn.frame.origin.y;
    self.title=@"转让";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.barTintColor=HSPBarBgColor;
    imageArray=[[NSMutableArray alloc] init];
    buttonArray=[[NSMutableArray alloc] init];
    mutable=[[NSMutableArray alloc] init];
    request =[JZDModuleHttpRequest sharedInstace];
    [buttonArray addObject:_addImageBtn];
    [self noticeTheKeyBoard];
    [self uiconfig];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)noticeTheKeyBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWillHide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyWillShow
{
    self.bottomScrollView.contentSize=CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.addView.frame)+216);
}

-(void)keyWillHide
{
    self.bottomScrollView.contentSize=CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.addView.frame));
}

-(void)uiconfig
{
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    _detailDescribe.layer.masksToBounds=YES;
    _detailDescribe.layer.cornerRadius=5;
    self.bottomScrollView.contentSize=_addView.frame.size;
    [self.bottomScrollView addSubview:_addView];
    [self.bottomScrollView addGestureRecognizer:_backTheKeyBoard];
}

-(void)back
{
    if (!publish) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您还没有发布" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"继续", nil];
        [alert show];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark  --alert代理--
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)popActionSheet
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        //从相册选择
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self getPhotoWithSourceType];
        }
    }else{
        //拍照获得
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self cameraGetPhoto];
        }
    }
}

-(void)getPhotoWithSourceType
{
    UIImagePickerController *pic=[[UIImagePickerController alloc] init];
    [pic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    pic.delegate=self;
    [self presentViewController:pic animated:YES completion:^{
        
    }];
}

-(void)cameraGetPhoto
{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    //图片来源
    ipc.sourceType=UIImagePickerControllerSourceTypeCamera;
    ipc.delegate=self;
    [self presentViewController:ipc animated:YES completion:^{
        
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    temp++;
    UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage *imgUpload=[image imageWithImageSimple:image scaledToSize:CGSizeMake(640, 960)];
    [imageArray addObject:imgUpload];
    image=[image thumbnailWithImageWithoutScale:image size:CGSizeMake(60, 60)];
    [self setButtonImage:image];
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        //将拍的照片保存到相册
        if (picker.sourceType == UIImagePickerControllerCameraCaptureModeVideo) {
            [NSThread detachNewThreadSelector: @selector(saveImage:) toTarget:self withObject:image];
        }
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(void)saveImage:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}
//编辑添加图片
-(void)setButtonImage:(UIImage *)img
{
    [_addImageBtn removeFromSuperview];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(10+60*temp+5, ory, 60, 60);
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [buttonArray insertObject:btn atIndex:0];
    if (buttonArray.count==4) {
        _addImageBtn.hidden=YES;
    }
    for(int j=0;j<buttonArray.count;j++){
        UIButton *b=buttonArray[j];
        b.frame=CGRectMake(10+60*j+j*5, ory, 60, 60);
        [_addView addSubview:b];
    }
}

-(void)deleteBtn:(UIButton *)btn
{
    [btn removeFromSuperview];
    for(int j=0;j<buttonArray.count;j++){
        UIButton *b=buttonArray[j];
        if ([b isEqual:btn]) {
            [buttonArray removeObjectAtIndex:j];
        }
    }
    _addImageBtn.hidden=NO;
    for(int j=0;j<buttonArray.count;j++){
        UIButton *b=buttonArray[j];
        b.frame=CGRectMake(10+60*j+5*j, ory, 60, 60);
    }
}

- (IBAction)showCateGray:(UIButton *)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    KxMenuItem *item;
    [mutable removeAllObjects];
    for(NSString *s in [defaults objectForKey:@"cate"]){
        item = [KxMenuItem menuItem:s image:nil target:self action:@selector(selectItm:)];
        //item.foreColor=[UIColor blackColor];
        [mutable addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:sender.frame menuItems:mutable];
}

-(void)selectItm:(KxMenuItem *)item
{
//    NSString *price;
//    if (_buyPrice.text.length) {
//        price=@"";
//    }else{
//        price=_buyPrice.text;
//    }
    [_showCateGray setTitle:item.title forState:UIControlStateNormal];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    for(int i=0;i<[(NSArray *)[defaults objectForKey:@"cate"] count];i++){
        if ([item isEqual:[mutable objectAtIndex:i]]) {
            _cateGrayIdString=[[defaults objectForKey:@"cateId"] objectAtIndex:i];
        }
    }
}

-(BOOL)makePointOut:(UIButton *)sender
{
    JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    if (_buyTheme.text.length==0||_contactPerson.text.length==0||_contactPhoneNum.text.length==0) {
        [alert popAlert:@"带星号为必填项"];
        sender.userInteractionEnabled=YES;
        return NO;
    }
    if (_detailDescribe.text.length>100) {
        [alert popAlert:@"描述内容不能超过100个字"];
        sender.userInteractionEnabled=YES;
        return NO;
    }
    if (_contactPerson.text.length<2||_contactPerson.text.length>4) {
        [alert popAlert:@"联系人字数应在2-4个字"];
        sender.userInteractionEnabled=YES;
        return NO;
    }
    BOOL isZZS = [self isZhengZhengShu:_buyPrice.text];
    if (!isZZS) {
        [alert popAlert:@"请输入正整数价格"];
        sender.userInteractionEnabled=YES;
        return NO;
    }
    BOOL isPhoneOrTelNum=[self isMobileOrTel:_contactPhoneNum.text];
    if (!isPhoneOrTelNum) {
        [alert popAlert:@"不是正确的号码格式"];
        sender.userInteractionEnabled=YES;
        return NO;
    }
    if (!_cateGrayIdString) {
        [alert popAlert:@"类别为必填项"];
        sender.userInteractionEnabled=YES;
        return NO;
    }
    return YES;
}

- (IBAction)addImageBtnClick:(UIButton *)sender {
    [self popActionSheet];
}

- (IBAction)commitBtn:(UIButton *)sender {
    sender.userInteractionEnabled=NO;
    BOOL isP=[self makePointOut:sender];
    if (!isP) {
        return;
    }
    MQLBMKMapManage *coord=[MQLBMKMapManage instance];
    CLLocation *loaction=[coord currentLocation];
    HSPAccount *user=[HSPAccountTool account];
    NSString *latitudeString=[NSString stringWithFormat:@"%f",loaction.coordinate.latitude];
    NSString *longitudeString=[NSString stringWithFormat:@"%f",loaction.coordinate.longitude];
    NSDictionary *dic=@{@"categorytype":_cateGrayIdString,@"type":[NSString stringWithFormat:@"%d",1],@"title":_buyTheme.text,@"price":_buyPrice.text,@"des":_detailDescribe.text,@"phone":_contactPhoneNum.text,@"contacts":_contactPerson.text,@"weidu":latitudeString,@"jindu":longitudeString,@"tokenid":user.userTokenid,@"user_id":user.user_id};
    [request connectionUpLoadImage:imageArray withVoiceData:nil withPardic:dic withUrl:publishSecGoods withBlock:^(NSDictionary *dic, NSError *error) {
        if (!error) {
            sender.userInteractionEnabled=YES;
            JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
            [alert popAlert:@"上传成功"];
            publish=YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
//判断是否正确格式的价格
-(BOOL)isZhengZhengShu:(NSString *)zhengShu
{
    return [zhengShu isMatchedByRegex:@"^[1-9]\\d*$"];
}

//判断是否是正确的手机格式
- (BOOL)isMobileOrTel:(NSString *)number
{
    return [number isMatchedByRegex:@"^(1)[0-9]{10}$"];
}

- (IBAction)resignTheKeyBoard:(UITapGestureRecognizer *)sender {
    for(id f in self.addView.subviews){
        if ([f isKindOfClass:[UITextField class]]||[f isKindOfClass:[UITextView class]]) {
            [f resignFirstResponder];
        }
    }
}
#pragma mark --textViewDelegate--

-(void)textViewDidChange:(UITextView *)textView
{
    _nubTextLable.text=[NSString stringWithFormat:@"%d/100",textView.text.length];
    if (height==216) {
        if (textView.text.length==101) {
            JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
            [alert popAlert:@"不能超过100个文字"];
            return;
        }
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (height>216) {
        if (textView.text.length>=100) {
            JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
            [alert popAlert:@"不能超过100个文字"];
            return;
        }
    }
}

-(void)sdf:(NSNotification *)not
{
    NSValue *keyBoardValue=[[not userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyBoardRect=[keyBoardValue CGRectValue];
    height=keyBoardRect.size.height;
}

@end
