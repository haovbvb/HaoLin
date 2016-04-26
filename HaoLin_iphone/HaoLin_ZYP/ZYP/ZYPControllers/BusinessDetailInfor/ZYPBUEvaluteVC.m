//
//  ZYPBUEvaluteVC.m
//  HaoLin
//
//  Created by mac on 14-9-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPBUEvaluteVC.h"

@interface ZYPBUEvaluteVC ()
{
    NSInteger page;
}
@property (nonatomic, strong)NSMutableArray *sourceArray;
@end

@implementation ZYPBUEvaluteVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sourceArray = [[NSMutableArray alloc] initWithCapacity:0];
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    self.tableView.hidden = YES;
    self.titleLabel.backgroundColor = ZYPBGColor;
    [self refreshes];
}
//  刷新
-(void)refreshes
{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新(一进入程序就下拉刷新).
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
//下拉刷新
-(void)headerRereshing
{
    page = 1;
    [self performSelector:@selector(getSource) withObject:nil afterDelay:2];
}
//上拉加载
-(void)footerRereshing
{
    page++;
    [self performSelector:@selector(getSource) withObject:nil afterDelay:2];
}

- (void)getSource
{
    if (page == 1)
    {
        [self.sourceArray removeAllObjects];
    }
    __weak ZYPBUEvaluteVC *evaluateVC = self;
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *account = [HSPAccountTool account];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&merchant_id=%@&page=%d",evaluteList,account.user_id,account.userTokenid,self.mercont_id,page];
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         if ([respondObject isKindOfClass:[NSDictionary class]]) {
             NSDictionary *dic = respondObject;
             if ([[dic objectForKey:@"code"] intValue] == 0)
             {
                 NSArray *array = [dic objectForKey:@"data"];
                 for (NSDictionary *dic1 in array)
                 {
                     EvaluateObject *evaluateObject = [[EvaluateObject alloc] initEvaluateObjectWithDic:dic1];
                     [evaluateVC.sourceArray addObject:evaluateObject];
                 }
                 [evaluateVC.tableView headerEndRefreshing];
                 [evaluateVC.tableView footerEndRefreshing];
                 [evaluateVC.tableView reloadData];
             }else
             {
                 [evaluateVC.tableView headerEndRefreshing];
                 [evaluateVC.tableView footerEndRefreshing];
                 [evaluateVC alertWithMessage:[dic objectForKey:@"message"]];
             }
         }else
         {
             [evaluateVC.tableView headerEndRefreshing];
             [evaluateVC.tableView footerEndRefreshing];
             [evaluateVC alertWithMessage:@"加载失败,请重试"];
         }
    }];
}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark - 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifier";
    ZYPEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPEvaluateCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    EvaluateObject *object = [self.sourceArray objectAtIndex:indexPath.row];
    cell.nickNameLabel.text = object.nickname;
    
    CGFloat height = [self heightOfLabelFromString:object.comment_info];
    cell.contentLabel.frame = CGRectMake(20, 35, 280, height);
    cell.contentLabel.text = object.comment_info;
    
    
    if ([object.score intValue] != 0)
    {
        for (int i = 0; i < [object.score intValue]; i++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i*20 , height + 40, 20, 20)];
            imageview.image = [UIImage imageNamed:@"ZYPChengseStar@2x_01.png"];
            [cell.contentView addSubview:imageview];
        }
        for (int i = [object.score intValue]; i < 5 ; i ++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i*20 , height + 40, 20, 20)];
            imageview.image = [UIImage imageNamed:@"ZYPHuiseStar@2x_03.png"];
            [cell.contentView addSubview:imageview];
        }
    }else
    {
        for (int i = 0; i < 5 ; i ++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i*20 , height + 40, 20, 20)];
            imageview.image = [UIImage imageNamed:@"ZYPHuiseStar@2x_03.png"];
            [cell.contentView addSubview:imageview];
        }
    }
    cell.creatTimeLabel.frame = CGRectMake(160,  height + 40, 140, height + 40);
    cell.creatTimeLabel.text = [self timeTranslate:object.createtime];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EvaluateObject *object = [self.sourceArray objectAtIndex:indexPath.row];
    CGFloat height = [self heightOfLabelFromString:object.comment_info];
    if (height < 30) {
        height = 30;
    }
    return 35 + height + 30;
}

//  label自适应高度
- (CGFloat)heightOfLabelFromString:(NSString *)text
{
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    CGSize size1 = [text boundingRectWithSize:CGSizeMake(280, 0) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    return size1.height;
}
#pragma mark -时间戳时间转化
- (NSString *)timeTranslate:(NSString *)time
{
    //  将时间戳转化为时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm"];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSString *dateString = [formatter stringFromDate:date1];
    return dateString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
