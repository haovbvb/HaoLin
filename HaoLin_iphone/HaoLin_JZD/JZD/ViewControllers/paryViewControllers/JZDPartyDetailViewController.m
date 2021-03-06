//
//  JZDPartyDetailViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDPartyDetailViewController.h"
#define HSPlightGrayColor  [UIColor lightGrayColor]

@interface JZDPartyDetailViewController ()<JZDCheckButtonDelegate,JZDModuleHttpRequestDelegate,JZDImageViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *_dataArray;
    NSMutableArray *_groupPicArray;
    __block NSMutableArray *_imageArrayUrl;
    JZDSectionView *sectionView;
    JZDModuleHttpRequest *request;
    NSString *userIdString;
    HSPAccount *account;
}
@property (nonatomic, copy) NSString *cachePath;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *wavFilePath;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, copy) NSString *theGroupId;

@end

@implementation JZDPartyDetailViewController

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
    account = [HSPAccountTool account];
    _imageArrayUrl=[[NSMutableArray alloc] init];
    _dataArray=[[NSMutableArray alloc] init];
    _groupPicArray=[[NSMutableArray alloc] init];
    [self uiconfig];
    _play.buttonImageRect=CGRectMake(250, 5, 30, 30);
    _play.buttonTitleRect=CGRectMake(10, 5, 137, 20);
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
    [self sendRequest];
    self.title = @"聚会详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor, NSForegroundColorAttributeName, nil]];
}

-(void)sendRequest
{
    request=[JZDModuleHttpRequest sharedInstace];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [request connectionRequestUrl:_thisUrl withDelegate:self];
    
}
/**
 *  请求完成的代理方法
 */
-(void)requestFinished:(id)responseObject
{
//    YYLog(@"%@",responseObject);
    if (![responseObject isKindOfClass:[NSError class]]) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
            [self viewContent:responseObject];
            [self getPicture:responseObject];
            [self getDiscuss:responseObject];
            [self getDescribe:responseObject];
            [self getVoiceInfo];
            [self makeSex:[[responseObject objectForKey:@"data"] objectForKey:@"gender"]];
            userIdString=[[responseObject objectForKey:@"data"] objectForKey:@"user_id"];
            __weak JZDPartyDetailViewController *wself=self;
            [request getImageUrl:[[responseObject objectForKey:@"data"] objectForKey:@"headimg"] withImage:^(UIImage *img) {
                [wself.userHeadImage setBackgroundImage:[UIImage circleImageWithName:img borderWidth:0.1 borderColor:[UIColor clearColor]] forState:UIControlStateNormal];
            }];
            _userName.text=[[responseObject objectForKey:@"data"] objectForKey:@"nickname"];
        }
        
        if (account.userTokenid.length) {
            [self isAppleBtnOk];
        }
    }else{
        return;
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
        //        [_imageArrayUrl removeAllObjects];
        //        [_imageArrayUrl addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"group_pic"]];
        [_groupPicArray removeAllObjects];
        for(NSDictionary *dic in [[responseObject objectForKey:@"data"] objectForKey:@"group_pic"]){
            [_groupPicArray addObject:[dic objectForKey:@"pic_url"]];
        }
        [self addPic:_groupPicArray];
    }
}

//添加图片
-(void)addPic:(NSMutableArray *)arr
{
    NSMutableArray *viewsArray = [@[] mutableCopy];
    if (arr.count) {
        for (int i = 0; i < arr.count; ++i) {
            __block JZDImageView *groupImg = [[JZDImageView alloc] initWithFrame:CGRectMake(i*70+i*10, 0, 70, 70)];
            groupImg.delegate=self;
            [request getImageUrl:arr[i] withImage:^(UIImage *img) {
                groupImg.image=img;
                [_imageArrayUrl addObject:img];
            }];
            [viewsArray addObject:groupImg];
            [_smallImageShow addSubview:groupImg];
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

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_imageArrayUrl removeAllObjects];
}

//获取聚会说明
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
    self.theGroupId=[dic objectForKey:@"group_id"];
    _doSomeThing.text=[dic objectForKey:@"group_subject"];
    _location.text=[dic objectForKey:@"group_address"];
    [_farAway setTitle:[NSString stringWithFormat:@"%.2fkm",_farAwayString/1000.00] forState:UIControlStateNormal];
    _numPeople.text=[NSString stringWithFormat:@"%@人",[dic objectForKey:@"group_man_num"]];
    _joinPeople.text=[NSString stringWithFormat:@"已参加%@人",[dic objectForKey:@"group_join_num"]];
    _timeDate.text=[dic objectForKey:@"group_addtime"];
    _startTime.text=[dic objectForKey:@"group_partytime"];
    _click_num.text=[NSString stringWithFormat:@"%@人浏览",[dic objectForKey:@"group_click_num"]];
    _voicePath = [dic objectForKey:@"group_voice_url"];
    _voiceName = [dic objectForKey:@"group_voice_name"];
    [self setSubmitBtnStatus:[dic objectForKey:@"group_man_num"] str2:[dic objectForKey:@"group_join_num"]];
    
}

-(void)requestFailed:(NSError *)error
{
    JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    [alert popAlert:[error localizedDescription]];
}

- (void)setSubmitBtnStatus:(NSString *)str1 str2:(NSString *)str2
{
    if ([str1 isEqualToString:str2]) {
        _submitBtn.userInteractionEnabled = NO;
        [_submitBtn setTitle:@"名额已满" forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:[UIColor grayColor]];
        
    }
}

-(void)uiconfig
{
    _highScrollView.contentSize=CGSizeMake(CGRectGetWidth(_bottomView.frame), CGRectGetHeight(_bottomView.frame));
    [_highScrollView addSubview:_bottomView];
    _farAway.delegate=self;
    _farAway.buttonImageRect=CGRectMake(0, 0, 10, 10);
    _farAway.buttonTitleRect=CGRectMake(13, -7, 120, 25);
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    sectionView=[[[NSBundle mainBundle] loadNibNamed:@"JZDSectionView" owner:self options:nil] lastObject];
    [sectionView.wantToEvaluate addTarget:self action:@selector(evaluate:) forControlEvents:UIControlEventTouchUpInside];
}
//返回上级页面
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_petDetailTableView]) {
        return 64;
    }else{
        CGSize size=[_describeString boundingRectWithSize:CGSizeMake(302, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        if (indexPath.section==0) {
            if (_describeString.length) {
                return size.height+5;
            }else{
                return 0;
            }
        }else{
            return 70;
        }
    }
}

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

//宠物聚会报名
- (IBAction)applyPetsParty:(UIButton *)sender {
    if (!account.userTokenid.length) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }

    [self isAppleBtnOk];
    
    JZDApplyViewController *apply=[[JZDApplyViewController alloc] initWithNibName:@"JZDApplyViewController" bundle:nil];
    apply.group_Id=_groupId;
    HSPNavigationController *nav=[[HSPNavigationController alloc] initWithRootViewController:apply];
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 *  0   成功，可以申请
 -2请求服务器的接口参数存在空值
 -2  请求服务器的接口参数存在空值!
 -3 tokenid不为空
 -4 非法操作
 1117 圈子不存在
 1124 不能加入自己的圈子！
 1118 圈子已经过期！
 1119 圈子人数已满，不能再申请！
 1120 你已经申请过并在审核中..！
 1121 申请被拒绝，不能再次申请！
 1122 你已经申请过，不能重复申请！
 */
- (void)isAppleBtnOk
{
    if (_theGroupId.length > 0) {
        [request connectionRequestUrl:[NSString stringWithFormat:isApplyBtnOkUrl,_theGroupId,account.user_id,account.userTokenid] withJSON:^(id responeJson) {
            int i = [[responeJson objectForKey:@"code"] intValue];
            switch (i) {
                case 1124:
                    [self submitBtns:@"自己圈子" color:HSPlightGrayColor];
                    break;
                case 1118:
                    [self submitBtns:@"已经过期" color:HSPlightGrayColor];
                    break;
                case 1119:
                    [self submitBtns:@"人数已满" color:HSPlightGrayColor];
                    break;
                case 1120:
                    [self submitBtns:@"审核中" color:HSPlightGrayColor];
                    break;
                case 1121:
                    [self submitBtns:@"已被拒绝" color:HSPlightGrayColor];
                    break;
                case 1122:
                    [self submitBtns:@"已经申请" color:HSPlightGrayColor];
                    break;
                    
                default:
                    break;
            }
        }];
    }
}

- (void)submitBtns:(NSString *)title color:(UIColor *)bgColor
{
    
    [_submitBtn setTitle:title forState:UIControlStateNormal];
    [_submitBtn setBackgroundColor:[UIColor grayColor]];
    _submitBtn.enabled = NO;
}


/**
 *  UIAlertView 代理
 */

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        HSPLoginViewController *login=[[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
        HSPNavigationController *nav = [[HSPNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

/**
 *  文件下载
 *
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

@end
