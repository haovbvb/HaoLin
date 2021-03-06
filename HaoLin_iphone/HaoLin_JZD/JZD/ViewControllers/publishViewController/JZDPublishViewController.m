//
//  JZDPublishViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//
#import "JZDPublishViewController.h"

@interface JZDPublishViewController ()<UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,JZDModuleHttpRequestDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *imageArray;
    NSMutableArray *buttonArray;
    NSInteger ory;
    int i;
    NSArray *arr;
    BOOL publishOrNot;
    BOOL outDate;
    BOOL scrollStop;
    JZDModuleHttpRequest *request;
    MQLAudioManage *audioManage;
    JZDCustomAlertView *alert;
}
@property (nonatomic, copy) NSString *wavFilePath;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *amrFilePath;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation JZDPublishViewController
-(void)dealloc
{
    _myTapGesture=nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    i=0;
    scrollStop=NO;
    publishOrNot=NO;
    ory=_uploadOne.frame.origin.y;
    imageArray=[[NSMutableArray alloc] init];
    buttonArray=[[NSMutableArray alloc] init];
    [buttonArray addObject:_uploadOne];
    request=[JZDModuleHttpRequest sharedInstace];
    alert=[JZDCustomAlertView sharedInstace];
    audioManage = [MQLAudioManage instance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyHide) name:UIKeyboardWillHideNotification object:nil];
    [self uiconfig];
}

-(void)uiconfig
{
    self.navigationController.navigationBar.barTintColor=HSPBarBgColor;
    _partyDescribe.layer.masksToBounds=YES;
    _partyDescribe.layer.cornerRadius=5;
    _partyRequest.layer.masksToBounds=YES;
    _partyRequest.layer.cornerRadius=5;
    _saidButton.buttonImageRect=CGRectMake(160, 7, 20, 20);
    _saidButton.buttonTitleRect=CGRectMake(10, 7, 100, 20);
    _publishBottomScrollView.bounces = YES;
    _publishBottomScrollView.contentSize=_publishBottomView.frame.size;
    _publishBottomView.frame=CGRectMake(0, 0, _publishBottomView.frame.size.width, _publishBottomView.frame.size.height);
    [_publishBottomScrollView addSubview:_publishBottomView];
    [self.view addGestureRecognizer:_myTapGesture];
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
}

-(void)keyShow
{
    _publishBottomScrollView.contentSize=CGSizeMake(_publishBottomView.frame.size.width, _publishBottomView.frame.size.height+210);
}

-(void)keyHide
{
    _publishBottomScrollView.contentSize=CGSizeMake(_publishBottomView.frame.size.width, _publishBottomView.frame.size.height);
}

-(void)back
{
    if (!publishOrNot) {
        UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:nil message:@"您还没有发布" delegate:self cancelButtonTitle:@"继续" otherButtonTitles:@"放弃", nil];
        [alertV show];
    }
}
#pragma mark --alert代理--
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    if ([_partyDescribe isEqual:textView]) {
//        _publishBottomScrollView.contentSize=CGSizeMake(_publishBottomView.frame.size.width, _publishBottomView.frame.size.height+210);
//        [UIView animateWithDuration:0.25f animations:^{
//            _publishBottomScrollView.contentOffset = CGPointMake(0, 150);
//        }];
//    }
//    if ([_partyRequest isEqual:textView]) {
//        _publishBottomScrollView.contentSize=CGSizeMake(_publishBottomView.frame.size.width, _publishBottomView.frame.size.height+210);
//        [UIView animateWithDuration:0.25f animations:^{
//            _publishBottomScrollView.contentOffset = CGPointMake(0, 355);
//        }];
//    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([_partyDescribe isEqual:textView]) {
        _publishBottomScrollView.contentSize=CGSizeMake(_publishBottomView.frame.size.width, _publishBottomView.frame.size.height + 210);
    }
    if ([_partyRequest isEqual:textView]) {
        _publishBottomScrollView.contentSize=CGSizeMake(_publishBottomView.frame.size.width, _publishBottomView.frame.size.height + 210);
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_partyTime isEqual:textField]) {
        _partyTime.inputView=_dateBottomView;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =[NSString stringWithFormat:@"%@",@"yyyy-MM-dd HH:mm"];
        _partyTime.text = [formatter stringFromDate:_pickerView.date];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_partyTime]) {
        NSDate *date=_pickerView.date;
        NSTimeInterval selectTime=[date timeIntervalSinceReferenceDate];
        NSTimeInterval now=[NSDate timeIntervalSinceReferenceDate];
        if (now-selectTime>0) {
            outDate=NO;
            [alert popAlert:@"选择时间不能小于当前时间"];
        }else{
            outDate=YES;
        }
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (_partyTheme.text.length>=15) {
        [alert popAlert:@"主题应小于15个字"];
    }
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName,nil]];
    if (_partyOrPets) {
        self.title=@"发布聚会";
    }else{
        self.title=@"发布宠物聚会";
    }
}
//回到今天
- (IBAction)today:(UIButton *)sender {
    
}
//选择日期完成
- (IBAction)complete:(UIButton *)sender {
    [_partyTime resignFirstResponder];
}

- (IBAction)pickerScroll:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:@"%@",@"yyyy-MM-dd HH:mm"];
    _partyTime.text = [formatter stringFromDate:_pickerView.date];
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
    }else if(buttonIndex==1){
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
    i++;
    UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage *imgUpload=[image imageWithImageSimple:image scaledToSize:CGSizeMake(320, 480)];
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

-(void)setButtonImage:(UIImage *)img
{
    [_uploadOne removeFromSuperview];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(106+60*i+5, ory, 60, 60);
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [buttonArray insertObject:btn atIndex:0];
    if (buttonArray.count==4) {
        [buttonArray  removeLastObject];
    }
    for(int j=0;j<buttonArray.count;j++){
        UIButton *b=buttonArray[j];
        b.frame=CGRectMake(106+60*j+j*5, ory, 60, 60);
        [_publishBottomView addSubview:b];
    }
}

-(void)deleteBtn:(UIButton *)btn
{
    for(int j=0;j<buttonArray.count;j++){
        UIButton *b=buttonArray[j];
        if ([b isEqual:btn]) {
            [buttonArray removeObjectAtIndex:j];
            if (!buttonArray.count) {
                _uploadOne=[UIButton buttonWithType:UIButtonTypeCustom];
                _uploadOne.frame=CGRectMake(106, ory, 60, 60);
                [_uploadOne setBackgroundImage:[UIImage imageNamed:@"JZD_add"] forState:UIControlStateNormal];
                [_uploadOne addTarget:self action:@selector(uploadImageOne:) forControlEvents:UIControlEventTouchUpInside];
                [_publishBottomView addSubview:_uploadOne];
                [buttonArray addObject:_uploadOne];
            }
        }
    }
    [btn removeFromSuperview];
    for(int j=0;j<buttonArray.count;j++){
        UIButton *b=buttonArray[j];
        b.frame=CGRectMake(106+60*j+5*j, ory, 60, 60);
    }
}

-(void)saveImage:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (IBAction)uploadImageOne:(UIButton *)sender {
    [self popActionSheet];
}
#pragma mark --发布活动--
- (IBAction)publishParty:(UIButton *)sender {
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    publishOrNot=YES;
    if (_partyTheme.text.length==0||_partyNumOfPeople.text.length==0||_partyTime.text.length==0||_partyAddress.text.length==0) {
        [alert popAlert:@"带星号为必填项"];
        return;
    }
    if (!outDate) {
        [alert popAlert:@"时间应大于当前时间"];
        return;
    }
    if (_partyNumOfPeople.text.length>2) {
        [alert popAlert:@"人数应小于99人"];
        return;
    }
    sender.userInteractionEnabled=NO;
    [MBProgressHUD showHUDAddedTo:win animated:YES];
    MQLBMKMapManage *coord=[MQLBMKMapManage instance];
    CLLocation *loaction=[coord currentLocation];
    NSString *latitudeString=[NSString stringWithFormat:@"%f",loaction.coordinate.latitude];
    NSString *longitudeString=[NSString stringWithFormat:@"%f",loaction.coordinate.longitude];
    
//    NSString *voicePath = [[audioManage getAudioFileNamePath] stringByAppendingPathComponent:@"voice.amr"];
    NSData *data = [NSData dataWithContentsOfFile:self.amrFilePath];
    //请求参数
    HSPAccount *user=[HSPAccountTool account];
    NSDictionary *dic=@{@"user_id":user.user_id,@"type":_typeString,@"subject":_partyTheme.text,@"des":_partyDescribe.text,@"content":_partyRequest.text,@"partytime":_partyTime.text,@"jindu_coord":longitudeString,@"weidu_coord":latitudeString,@"address":_partyAddress.text,@"man_num":_partyNumOfPeople.text,@"voice":@"voice",@"tokenid":user.userTokenid};
//    [request connectionUpLoadImage:imageArray withVoiceData:data withPardic:dic withUrl:PublishActivity];
    [request connectionUpLoadImage:imageArray withVoiceData:data withPardic:dic withUrl:PublishActivity withBlock:^(NSDictionary *dic, NSError *error) {
        if (!error) {
            [MBProgressHUD hideHUDForView:win animated:YES];
            [alert popAlert:@"上传成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [MBProgressHUD hideHUDForView:win animated:YES];
            [alert popAlert:@"请检查您的网络"];
        }
        sender.userInteractionEnabled=YES;
    }];
}
- (void)requestFinished:(id)responseObject{}
- (void)requestFailed:(NSError *)error{}

- (IBAction)tapResignFirshResponder:(UITapGestureRecognizer *)sender {
    for(id obj in _publishBottomView.subviews){
        if ([obj isKindOfClass:[UITextField class]]||[obj isKindOfClass:[UITextView class]]) {
            [obj resignFirstResponder];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _saidButton.userInteractionEnabled=NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    [audioManage stopRecord];
    _saidButton.userInteractionEnabled=YES;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    [audioManage stopRecord];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    [audioManage stopRecord];
}

#pragma mark --录音部分
// 录取声音--按下
- (IBAction)recordDownBtnTouchDown:(id)sender {
    self.filePath = NSTemporaryDirectory();
    self.wavFilePath = [self.filePath stringByAppendingPathComponent:@"voice.wav"];
    [audioManage startRecordFromView:sender withWavFilePath:self.wavFilePath];
}

- (IBAction)recordDownBtnTouckUpInside:(id)sender {
    [audioManage stopRecord];
    self.amrFilePath = [self.filePath stringByAppendingPathComponent:@"voice.amr"];
    [audioManage encodeToAmr:self.amrFilePath FromWav:self.wavFilePath];
    _player=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.wavFilePath] error:nil];
    [_player prepareToPlay];
}

- (IBAction)recordDownBtnTouchUpOutside:(id)sender {
    [audioManage stopRecord];
}

- (IBAction)listenVoice:(UIButton *)sender {
    if (self.wavFilePath) {
        [_player play];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    arr=[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    return [arr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _partyNumOfPeople.text=[arr objectAtIndex:row];
}


@end

