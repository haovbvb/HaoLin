//
//  PetsDetailViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "PetsDetailViewController.h"

@interface PetsDetailViewController ()<JZDCheckButtonDelegate,JZDModuleHttpRequestDelegate,JZDImageViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    NSMutableArray *_groupPicArray;
    __block NSMutableArray *_imageArrayUrl;
    JZDSectionView *sectionView;
    JZDModuleHttpRequest *request;
    NSString *userIdString;
    UIScrollView *scroll;
    CGFloat contentOffsetY;
    CGFloat oldContentOffsetY;
    CGFloat newContentOffsetY;
    CGRect rectS;
    CGRect rectB;
    CGRect rectT;
}
@property (nonatomic, copy) NSString *cachePath;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *wavFilePath;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) JZDNoNetWorkView *noView;
@end

@implementation PetsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.edgesForExtendedLayout=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _imageArrayUrl=[[NSMutableArray alloc] init];
    _dataArray=[[NSMutableArray alloc] init];
    _groupPicArray=[[NSMutableArray alloc] init];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.title=@"宠物活动";
    _littleTableView.separatorColor=[UIColor clearColor];
    rectS=_highScrollView.frame;
    rectB=_playVoice.frame;
    rectT=_petDetailTableView.frame;
    [self uiconfig];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self sendRequest];
}

//验证报名
-(void)check
{
    JZDPushSingl *singl=[JZDPushSingl sharedInstance];
    JZDModuleHttpRequest *req=[JZDModuleHttpRequest sharedInstace];
    JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    __weak typeof(self) wself=self;
    if (singl.userIdStr) {
        [req connectionRequestUrl:[NSString stringWithFormat:ApplyCheck,_groupId,singl.userIdStr,singl.token_idStr] withJSON:^(id responeJson) {
//            YYLog(@"%@",responeJson);
            if (![responeJson isKindOfClass:[NSError class]]) {
                [wself changeTitle:responeJson];
            }else{
                [alert popAlert:@"登录失败,请检查您的网络"];
                return ;
            }
        }];
    }
}

-(void)changeTitle:(id)responeJson
{
    NSString *code=[responeJson objectForKey:@"code"];
    switch ([code integerValue]) {
        case 1117:
            [_applyBtn setTitle:@"不存在圈子" forState:UIControlStateNormal];
            [_applyBtn setBackgroundColor:[UIColor grayColor]];
            _applyBtn.userInteractionEnabled=NO;
            break;
        case 1124:
            [_applyBtn setTitle:@"自己的圈子" forState:UIControlStateNormal];
            [_applyBtn setBackgroundColor:[UIColor grayColor]];
            _applyBtn.userInteractionEnabled=NO;
            break;
        case 1118:
            [_applyBtn setTitle:@"已过期" forState:UIControlStateNormal];
            [_applyBtn setBackgroundColor:[UIColor grayColor]];
            _applyBtn.userInteractionEnabled=NO;
            break;
        case 1120:
            [_applyBtn setTitle:@"审核中" forState:UIControlStateNormal];
            [_applyBtn setBackgroundColor:[UIColor grayColor]];
            _applyBtn.userInteractionEnabled=NO;
            break;
        case 1121:
            [_applyBtn setTitle:@"已被拒绝" forState:UIControlStateNormal];
            [_applyBtn setBackgroundColor:[UIColor grayColor]];
            _applyBtn.userInteractionEnabled=NO;
            break;
        case 1122:
            [_applyBtn setTitle:@"已申请" forState:UIControlStateNormal];
            [_applyBtn setBackgroundColor:[UIColor grayColor]];
            _applyBtn.userInteractionEnabled=NO;
            break;
        default:
            break;
    }
}

/**
 *  评价
 *
 *  @param btn
 */
-(void)evaluate:(UIButton *)btn
{
    JZDEvaluateViewController *evaluate=[[JZDEvaluateViewController alloc] initWithNibName:@"JZDEvaluateViewController" bundle:nil];
    evaluate.groupId=_groupId;
    evaluate.user_id=userIdString;
    [self.navigationController pushViewController:evaluate animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
//    sectionView=[[[NSBundle mainBundle] loadNibNamed:@"JZDSectionView" owner:self options:nil] lastObject];
    [self check];
}

-(void)sendRequest
{
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [MBProgressHUD showHUDAddedTo:win animated:YES];
    request=[JZDModuleHttpRequest sharedInstace];
    [request connectionRequestUrl:_thisUrl withDelegate:self];
}
/**
 *  请求完成的代理方法
 */
-(void)requestFinished:(id)responseObject
{
    //group_man_num group_join_num
    if (_noView.superview) {
        [_noView removeFromSuperview];
    }
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [MBProgressHUD hideHUDForView:win animated:YES];
    if (![responseObject isKindOfClass:[NSError class]]) {
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
            [self viewContent:responseObject];
            [self getPicture:responseObject];
            [self getDiscuss:responseObject];
            [self getDescribe:responseObject];
            [self setBtnState:responseObject];
            [self makeSex:[[responseObject objectForKey:@"data"] objectForKey:@"gender"]];
            [self getVoiceInfo];
            userIdString=[[responseObject objectForKey:@"data"] objectForKey:@"user_id"];
            __weak PetsDetailViewController *wself=self;
            [request getImageUrl:[[responseObject objectForKey:@"data"] objectForKey:@"headimg"] withImage:^(UIImage *img) {
                [wself.userHeadImage setBackgroundImage:[UIImage circleImageWithName:img borderWidth:0.1 borderColor:[UIColor clearColor]] forState:UIControlStateNormal];
            }];
            _userName.text=[[responseObject objectForKey:@"data"] objectForKey:@"nickname"];
        }
    }else{
        return;
    }
}

-(void)requestFailed:(NSError *)error
{
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [MBProgressHUD hideHUDForView:win animated:YES];
//    JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
//    [alert popAlert:@"请检查您的网络"];
    __weak typeof(self) wself=self;
    _noView=[[[NSBundle mainBundle] loadNibNamed:@"NoNetWork" owner:self options:nil] lastObject];
    _noView.frame=CGRectMake(0, 64, CGRectGetWidth(self.view.frame),CGRectGetHeight(win.frame)-64);
    _noView.sendRefresh=^(void){
        [wself sendRequest];
    };
    [win addSubview:_noView];
}

-(void)setBtnState:(id)res
{
    NSString *group_man_num=[[res objectForKey:@"data"] objectForKey:@"group_man_num"];
    NSString *group_join_num=[[res objectForKey:@"data"] objectForKey:@"group_join_num"];
    if ([group_man_num isEqualToString:group_join_num]) {
        [_applyBtn setTitle:@"名额已满" forState:UIControlStateNormal];
        [_applyBtn setBackgroundColor:[UIColor grayColor]];
        _applyBtn.userInteractionEnabled=NO;
    }
}

-(void)makeSex:(NSString *)sex
{
    if ([sex isEqualToString:@"1"]) {
        _userSex.image=[UIImage imageNamed:@"JZD_male.png"];
    }else{
        _userSex.image=[UIImage imageNamed:@"JZD_female.png"];
    }
}

//获取聚会图片
-(void)getPicture:(NSDictionary *)responseObject
{
    if ([(NSArray *)[[responseObject objectForKey:@"data"] objectForKey:@"group_pic"] count]) {
        [_groupPicArray removeAllObjects];
        for(NSDictionary *dic in [[responseObject objectForKey:@"data"] objectForKey:@"group_pic"]){
            [_groupPicArray addObject:[dic objectForKey:@"pic_url"]];
        }
    }
}

-(void)imageSingelClick:(JZDImageView *)imgView
{
    JZDShowPicViewController *pic=[[JZDShowPicViewController alloc] initWithNibName:@"JZDShowPicViewController" bundle:nil];
    pic.imageArray=_imageArrayUrl;
    for(int i=0;i<_imageArrayUrl.count;i++){
        if ([_imageArrayUrl[i] isEqual:imgView.image]) {
            pic.currentIndex=i;
        }
    }
    [self.navigationController pushViewController:pic animated:YES];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    JZDImageView *imgview;
    for(JZDImageView *igv in scrollView.subviews){
        imgview= igv;
    }
    return imgview;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_imageArrayUrl removeAllObjects];
}

#pragma mark  --聚会说明--
-(void)getDescribe:(NSDictionary *)responseObject
{
    for(NSString *s in [responseObject objectForKey:@"data"]){
        if ([s isEqualToString:@"group_des"]) {
            _describeString=[[responseObject objectForKey:@"data"] objectForKey:s];
            [_littleTableView reloadData];
        }
    }
}

//获取用户评论
-(void)getDiscuss:(NSDictionary *)responseObject
{
    if ([(NSArray *)[[responseObject objectForKey:@"data"] objectForKey:@"group_remark"] count]) {
        [_dataArray removeAllObjects];
        for(NSDictionary *dic in [[responseObject objectForKey:@"data"] objectForKey:@"group_remark"]){
            JZDItem *item=[[JZDItem alloc] init];
            //请求图片
            __weak JZDItem *myItem=item;
            [request getImageUrl:[dic objectForKey:@"headurl"] withImage:^(UIImage *img) {
                myItem.headImage=img;
                [_petDetailTableView reloadData];
            }];
            item.nickName=[dic objectForKey:@"nickname"];
            item.publishTimeString=[dic objectForKey:@"remark_addtime"];
            item.publishContentString=[dic objectForKey:@"remark_content"];
            [_dataArray addObject:item];
        }
    }
}
//获取声音信息
-(void)getVoiceInfo
{
    if ([_voicePath rangeOfString:@"amr"].location!= NSNotFound) {
        [self downloadFile:_voicePath];
    }
}

-(void)viewContent:(id)responseObject
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:[responseObject objectForKey:@"data"]];
    _doSomeThing.text=[dic objectForKey:@"group_subject"];
    _location.text=[dic objectForKey:@"group_address"];
    if (_farAwayString==1.0) {
        [_farAway setTitle:@"未知" forState:UIControlStateNormal];
    }else{
        [_farAway setTitle:[NSString stringWithFormat:@"%.2fkm",_farAwayString/1000.00] forState:UIControlStateNormal];
    }
    _numPeople.text=[NSString stringWithFormat:@"%@人",[dic objectForKey:@"group_man_num"]];
    _joinPeople.text=[NSString stringWithFormat:@"已参加%@人",[dic objectForKey:@"group_join_num"]];
    _timeDate.text=[dic objectForKey:@"group_addtime"];
    _startTime.text=[dic objectForKey:@"group_partytime"];
    _click_num.text=[NSString stringWithFormat:@"%@人浏览",[dic objectForKey:@"group_click_num"]];
    _voicePath = [dic objectForKey:@"group_voice_url"];
    _voiceName = [dic objectForKey:@"group_voice_name"];
}

-(void)uiconfig
{
    _highScrollView.contentSize=CGSizeMake(CGRectGetWidth(_bottomView.frame), CGRectGetHeight(_bottomView.frame));
    [_highScrollView addSubview:_bottomView];
    _playVoice.buttonImageRect=CGRectMake(250, 5, 30, 30);
    _playVoice.buttonTitleRect=CGRectMake(10, 5, 100, 30);
    _farAway.delegate=self;
    _farAway.buttonImageRect=CGRectMake(0, -4, 10, 10);
    _farAway.buttonTitleRect=CGRectMake(13, -7, 80, 15);

    sectionView=[[[NSBundle mainBundle] loadNibNamed:@"JZDSectionView" owner:self options:nil] lastObject];
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    [sectionView.wantToEvaluate addTarget:self action:@selector(evaluate:) forControlEvents:UIControlEventTouchUpInside];
}
//返回上级页面
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
//    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_petDetailTableView]) {
        return 40;
    }else{
        return 20;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_petDetailTableView]) {
        return sectionView;
    }
    return nil;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (![tableView isEqual:_petDetailTableView]) {
        if (section==0) {
            return @"说明";
        }else{
            return @"图片";
        }
    }
    return nil;
}
#pragma mark --行高--
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([tableView isEqual:_petDetailTableView]) {
//        return 64;
//    }else{
//        CGSize size=[_describeString boundingRectWithSize:CGSizeMake(302, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
//        if (indexPath.section==0) {
//            if (_describeString.length) {
//                return size.height+5;
//            }else{
//                return 0;
//            }
//        }else{
//            return 70;
//        }
//        YYLog(@"%f",size.height);
//    }
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_petDetailTableView]) {
        return _dataArray.count;
    }else{
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (![tableView isEqual:_petDetailTableView]) {
        return 2;
    }else{
        return 1;
    }
}
#pragma mark --创建cell--
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_petDetailTableView]) {
        static NSString *customCell=@"custom";
        JZDPartyDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:customCell];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"JZDPartyDetailTableViewCell" owner:self options:nil] lastObject];
        }
        [cell setItem:[_dataArray objectAtIndex:indexPath.row]];
        return cell;
    }else{
        if (indexPath.section==0) {
            static NSString *cellId=@"cellTwo";
            JZDDecTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"JZDDecTableViewCell" owner:self options:nil] lastObject];
            }
            cell.desStr=_describeString;
            return cell;
        }else{
            static NSString *cellId=@"cellOne";
            JZDImgTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"JZDImgTableViewCell" owner:self options:nil] lastObject];
            }
            cell.picArray=_groupPicArray;
            return cell;
        }
    }
}
#pragma mark --宠物聚会报名--
- (IBAction)applyPetsParty:(UIButton *)sender {
    HSPAccount *user=[HSPAccountTool account];
    if (!user.userTokenid) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"登录后才能报名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
//    if([userIdString isEqualToString:singl.userIdStr]){
//        [alert popAlert:@"不能报名自己的圈子"];
//        return;
//    }
//    if ([_outOfDute isEqualToString:@""]) {
        JZDApplyViewController *apply=[[JZDApplyViewController alloc] initWithNibName:@"JZDApplyViewController" bundle:nil];
        apply.group_Id=_groupId;
        [self.navigationController pushViewController:apply animated:YES];
//    }else{
//        [alert popAlert:@"圈子已过期"];
//    }
}

/**
 *  UIAlertView 代理
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        HSPLoginViewController *login=[[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
        HSPNavigationController *nav=[[HSPNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

/**
 *  文件下载
 *  @param urlStr 文件地址
 */
- (void)downloadFile:(NSString *)urlStr
{
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        self.cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        self.filePath = [self.cachePath stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *fileURL = [NSURL fileURLWithPath:self.filePath];
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:fileURL error:NULL];
    }] resume];
}
/**
 * 播放声音
 */
- (IBAction)palyTheVoice:(UIButton *)sender {
    if (_voiceName.length>0) {
        NSRange loc = [_voiceName rangeOfString:@"."];
        NSString *name = [_voiceName substringToIndex:loc.location];
        if ([self.filePath hasSuffix:@"amr"]) {
            self.wavFilePath=[self.filePath stringByReplacingOccurrencesOfString:@"amr" withString:@"wav"];
            [MQLAudioManage encodeToWav:self.wavFilePath fromAmr:self.filePath];
        }else{
            self.wavFilePath = [self.cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.wav",name]];
        }
        NSURL *fileURL = [NSURL fileURLWithPath:self.wavFilePath];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        if (!sender.selected) {
            sender.selected=YES;
            [self.player play];
            // 删除AMR文件
            [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
        }else{
            sender.selected=NO;
            [self.player stop];
        }
    }else{
        JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
        [alert popAlert:@"没有上传声音"];
    }
}

//开始拖拽视图

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_petDetailTableView]) {
        contentOffsetY = scrollView.contentOffset.y;
    }
}

// 滚动时调用此方法(手指离开屏幕后)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    newContentOffsetY = scrollView.contentOffset.y;
//    if (newContentOffsetY > oldContentOffsetY && oldContentOffsetY > contentOffsetY) {  // 向上滚动
//        //NSLog(@"up");
//    } else if (newContentOffsetY < oldContentOffsetY && oldContentOffsetY < contentOffsetY) { // 向下滚动
//        //NSLog(@"down");
//    } else {
//        //NSLog(@"dragging");
//    }
    if([scrollView isEqual:_petDetailTableView]){
        if (scrollView.dragging) {  // 拖拽
            if ((scrollView.contentOffset.y - contentOffsetY) > 5.0f) {  // 向上拖拽
                __block CGRect rectSTemp=_highScrollView.frame;
                __block CGRect rectBTemp=_playVoice.frame;
                __block CGRect rectTTemp=_petDetailTableView.frame;
                [UIView animateKeyframesWithDuration:0.2 delay:0.1 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                    rectSTemp.origin.y=-(rectS.size.height+rectB.size.height);
                    rectBTemp.origin.y=-(rectS.size.height+rectB.size.height);
                    rectTTemp.origin.y=64;
                    rectTTemp.size.height=self.view.frame.size.height;
                    _highScrollView.frame=rectSTemp;
                    _playVoice.frame=rectBTemp;
                    _petDetailTableView.frame=rectTTemp;
                } completion:^(BOOL finished) {
                }];
            } else if ((contentOffsetY - scrollView.contentOffset.y) > 5.0f) {   // 向下拖拽
                [UIView animateKeyframesWithDuration:0.1 delay:0.1 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                    _highScrollView.frame=rectS;
                    _playVoice.frame=rectB;
                    _petDetailTableView.frame=rectT;
                } completion:^(BOOL finished) {
                }];
            } else {
            }
        }
    }
}

@end
