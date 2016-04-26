//
//  JZDBBsEvaluateViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-16.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDBBsEvaluateViewController.h"

@interface JZDBBsEvaluateViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,JZDImageViewDelegate>
{
    JZDModuleHttpRequest *request;
    JZDCustomAlertView *alert;
    NSString *desStr;
    JZDBBsSectionView *sectionView;
    NSMutableArray *_dataArray;
    NSMutableArray *_imageArrayUrl;
    NSMutableArray *_imgArray;
    NSString *_voiceName;
    __block int page;
}

@property (nonatomic, copy) NSString *cachePath;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *wavFilePath;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation JZDBBsEvaluateViewController

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
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [MBProgressHUD showHUDAddedTo:win animated:YES];
    _evalutaeContent.layer.masksToBounds=YES;
    _evalutaeContent.layer.cornerRadius=5;
    self.title=@"帖子详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
           [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    page=1;
    _imageArrayUrl=[[NSMutableArray alloc] init];
    _imgArray=[[NSMutableArray alloc] init];
    request=[JZDModuleHttpRequest sharedInstace];
    alert=[JZDCustomAlertView sharedInstace];
    _dataArray=[[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.alertMan.hidden=NO;
    _evalutaeContent.editable=YES;
    [self uiconfig];
}
#pragma mark  --textField代理--
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.alertMan.hidden=YES;
    JZDBBsEvaluteViewController *eva=[[JZDBBsEvaluteViewController alloc] initWithNibName:@"JZDBBsEvaluteViewController" bundle:nil];
    eva.posts_id=_posts_id;
    [self.navigationController pushViewController:eva animated:YES];
    _evalutaeContent.editable=NO;
    return YES;
}

-(void)uiconfig
{
    [_evaluateBBsTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新(一进入程序就下拉刷新).
    [_evaluateBBsTableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_evaluateBBsTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
//下拉刷新
-(void)headerRereshing
{
    __weak JZDBBsEvaluateViewController *wself=self;
    [request connectionRequestUrl:[NSString stringWithFormat:BBSDetail,_posts_id,1] withJSON:^(id responeJson) {
        [_dataArray removeAllObjects];
        [wself addData:responeJson];
    }];
    [self endRload];
    
}
//上拉刷新
-(void)footerRereshing
{
    page++;
    __weak JZDBBsEvaluateViewController *wself=self;
    [request connectionRequestUrl:[NSString stringWithFormat:BBSDetail,_posts_id,page] withJSON:^(id responeJson) {
        if (![(NSArray *)[responeJson objectForKey:@"data"] count]) {
            [alert popAlert:@"已经是最后一条数据"];
        }
        [wself addData:responeJson];
    }];
    [self endRload];
}

-(void)endRload
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_evaluateBBsTableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    });
}

-(void)addData:(id)responeJson
{
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [MBProgressHUD hideAllHUDsForView:win animated:YES];
    if (![responeJson isKindOfClass:[NSError class]]) {
        if ([[responeJson objectForKey:@"code"] isEqualToString:@"0"]) {
            if ([(NSArray *)[[responeJson objectForKey:@"data"] objectForKey:@"answer"] count]) {
                for(NSDictionary *dic in [[responeJson objectForKey:@"data"] objectForKey:@"answer"]){
                    JZDItem *item=[[JZDItem alloc] init];
                    __weak JZDItem *myItem=item;
                    [request getImageUrl:[dic objectForKey:@"headurl"] withImage:^(UIImage *img) {
                        myItem.headImage=img;
                        [_evaluateBBsTableView reloadData];
                    }];
                    item.nickName=[dic objectForKey:@"nickname"];
                    item.describeString=[dic objectForKey:@"posts_content"];
                    item.answerDes=[dic objectForKey:@"answer_content"];
                    desStr=[dic objectForKey:@"answer_content"];
                    item.timeForStart=[dic objectForKey:@"addtime"];
                    [_dataArray addObject:item];
                }
            }
            [_imageArrayUrl removeAllObjects];
            for(NSDictionary *dic in [[responeJson objectForKey:@"data"] objectForKey:@"pic"]){
                [_imageArrayUrl addObject:[dic objectForKey:@"pic_url_name"]];
            }
            _voiceName=[[responeJson objectForKey:@"data"] objectForKey:@"posts_voice_name"];
            if ([_voiceName length]) {
                [self downloadFile:[[responeJson objectForKey:@"data"] objectForKey:@"posts_voice_url"]];
            }
            [self makeSectionView];
        }
    }
    [_evaluateBBsTableView headerEndRefreshing];
    [_evaluateBBsTableView footerEndRefreshing];
}
#pragma mark  --下载声音
- (void)downloadFile:(NSString *)urlStr
{
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        self.cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        self.filePath = [self.cachePath stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *fileURL = [NSURL fileURLWithPath:self.filePath];
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:fileURL error:NULL];//存储文件
    }] resume];
}
#pragma mark  --设置评价顶部信息--
-(void)makeSectionView
{
    sectionView=[[[NSBundle mainBundle] loadNibNamed:@"JZDBBsSectionView" owner:self options:nil] lastObject];
    [sectionView.headImageButton setBackgroundImage:_senctionItem.headImage forState:UIControlStateNormal];
    sectionView.nickName.text=_senctionItem.nickName;
    sectionView.timeStart.text=_senctionItem.timeForStart;
    sectionView.userPublishContent.text=_senctionItem.describeString;
    
    JZDBottomView *bview=[[[NSBundle mainBundle] loadNibNamed:@"JZDBottomView" owner:self options:nil] lastObject];
    bview.frame=CGRectMake(0, 123, 320, 95);
    [bview.saidYourVoice addTarget:self action:@selector(saidVoice:) forControlEvents:UIControlEventTouchUpInside];
    if (_imageArrayUrl.count) {
        CGRect rect=sectionView.frame;
        rect.size.height+=95;
        sectionView.frame=rect;
        for(int i=0;i<_imageArrayUrl.count;i++){
            __block JZDImageView *imgView=[[JZDImageView alloc] initWithFrame:CGRectMake(10+i*(60+15), 0, 60, 60)];
            imgView.delegate=self;
            [request getImageUrl:_imageArrayUrl[i] withImage:^(UIImage *img) {
                imgView.image=img;
                [_imgArray addObject:img];
            }];
            [bview addSubview:imgView];
        }
        [sectionView addSubview:bview];
        [_evaluateBBsTableView reloadData];
    }
}
#pragma mark  --图片的代理方法--
-(void)imageSingelClick:(JZDImageView *)imgView
{
    JZDShowPicViewController *show=[[JZDShowPicViewController alloc] initWithNibName:@"JZDShowPicViewController" bundle:nil];
    show.imageArray=_imgArray;
    for(int i=0;i<_imgArray.count;i++){
        if ([_imgArray[i] isEqual:imgView.image]) {
            show.currentIndex=i;
        }
    }
    [self.navigationController pushViewController:show animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_imgArray removeAllObjects];
    [_imageArrayUrl removeAllObjects];
}

/**
 *  听声音
 */
-(void)saidVoice:(UIButton *)btn
{
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
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        if (!btn.selected) {
            btn.selected=YES;
            [self.player play];
            // 删除AMR文件
            [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
        }else{
            btn.selected=NO;
            [self.player stop];
        }
    }else{
        [alert popAlert:@"没有上传声音"];
    }
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
//sectionView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_imageArrayUrl.count) {
        return 218;
    }
    return 123;
}
//行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size=[desStr boundingRectWithSize:CGSizeMake(290, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    if (size.height>38) {
        return 51+size.height+25;
    }
    return 51+38+25;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return sectionView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"cell";
    JZDBBSTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"JZDBBSTableViewCell" owner:self options:nil] lastObject];
    }
    [cell setItem:[_dataArray objectAtIndex:indexPath.row]];
    return cell;
}

@end
