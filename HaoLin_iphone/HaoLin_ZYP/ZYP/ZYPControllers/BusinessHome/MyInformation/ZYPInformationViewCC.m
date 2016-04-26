//
//  ZYPInformationViewCC.m
//  HaoLin
//
//  Created by mac on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPInformationViewCC.h"

@interface ZYPInformationViewCC ()
{
    NSInteger page;
}
@property (nonatomic, strong)NSMutableArray *orderArray;
@property (nonatomic, strong)NSMutableArray *inforArray;

@end

@implementation ZYPInformationViewCC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    /**
     *  从父视图上移除btn
     */
    [self.deleteBtn removeFromSuperview];
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
        self.tableView.frame = CGRectMake(0, 64, 320, 504);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.tableView.frame = CGRectMake(0, 64, 320, 416);
    }
    // Do any additional setup after loading the view from its nib.
    page = 1;
    self.titleLabel.backgroundColor = ZYPBGColor;

    self.orderArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.inforArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self refreshes];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
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
//上拉刷新
-(void)footerRereshing
{
    page++;
    [self performSelector:@selector(getSource) withObject:nil afterDelay:2];
}
- (void)getSource
{
    if (page == 1) {
        [self.inforArray removeAllObjects];
    }
    __weak ZYPInformationViewCC *inforVC = self;
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *accout = [HSPAccountTool account];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&page=%@",information,accout.user_id,accout.userTokenid,[NSString stringWithFormat:@"%d",page]];
    [manger connectWithUrlString:urlString completion:^(id responedObject) {
        if ([responedObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responedObject;
            
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                NSArray *array = [dic objectForKey:@"data"];
                for (NSDictionary *dic1 in array) {
                    ZYPInformationObject *infor = [[ZYPInformationObject alloc] initInformationWithDic:dic1];
                    [inforVC.inforArray addObject:infor];
                }
                [inforVC.tableView reloadData];
                [inforVC.tableView headerEndRefreshing];
                [inforVC.tableView footerEndRefreshing];
            }else
            {
                [inforVC.tableView headerEndRefreshing];
                [inforVC.tableView footerEndRefreshing];
                [inforVC alertWithMessage:[dic objectForKey:@"message"]];
            }
        }else
        {
            [inforVC.tableView headerEndRefreshing];
            [inforVC.tableView footerEndRefreshing];
            [inforVC alertWithMessage:@"加载失败,请检查网络连接"];
        }
    }];
}
- (void)alertWithMessage:(NSString *)mesage
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
//  返回
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)delete:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定删除全部信息吗?" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
   }
#pragma mark -alert代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.inforArray removeAllObjects];
        [self.tableView reloadData];
    }
}
#pragma mark - 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inforArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        ZYPInformationObject *object = [self.inforArray objectAtIndex:indexPath.row];
        CGFloat height = [self heightOfLabelFromString:object.message_desc];
        if (height > 40) {
            height = 40;
        }
        return height +16 + 30;
}
//  label自适应高度
- (CGFloat)heightOfLabelFromString:(NSString *)text
{
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    CGSize size1 = [text boundingRectWithSize:CGSizeMake(280, 0) options:  NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    return size1.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static  NSString *indentifier = @"indentifier";
    ZYPInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPInformationCell" owner:self options:nil] lastObject];
    }
    cell.righeCon.image = nil;
    //  自定义实例对象，用来综合消息信息
    ZYPInformationObject *object = [self.inforArray objectAtIndex:indexPath.row];
     CGFloat height = [self heightOfLabelFromString:object.message_desc];
    cell.contentLabel.frame = CGRectMake(20, 2, 280, height);
    cell.timeLabel.frame = CGRectMake(156,2 + height + 10, 154, 30);
    cell.righeCon.frame = CGRectMake(291,2 + height + 16, 20, 15);
    if ([object.isread intValue] == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"橙色位置.png"];
    }
    cell.contentLabel.text =object.message_desc;
    cell.timeLabel.text = [self timeTranslate:object.createtime];
    return cell;
}
#pragma mark -时间戳时间转化
- (NSString *)timeTranslate:(NSString *)time
{
//  将时间戳转化为时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSString *dateString = [formatter stringFromDate:date1];
    return dateString;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYPInformationCell *cell =  (ZYPInformationCell *)[tableView cellForRowAtIndexPath:indexPath];
    //  获得cell所对应的对象
    ZYPInformationObject *object = [self.inforArray objectAtIndex:indexPath.row];
    //  信息未读，点入后读取，返回后标示消失
    if ([object.isread intValue] == 0) {
        cell.imageView.alpha = 0;
    }
    //  下个界面
    ZYPInforDetailVC *detailInfoVC = [[ZYPInforDetailVC alloc] initWithNibName:@"ZYPInforDetailVC" bundle:nil];
    //  传递信息给下个界面
    detailInfoVC.infoObject = object;
    [self.navigationController pushViewController:detailInfoVC animated:YES];
    //  改变信息状态
    [self changeState:object.message_id];
}
//  改变信息状态，将未读标记为已读
- (void)changeState:(NSString *)messageID
{
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *accout = [HSPAccountTool account];
    NSString *urlStr = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&message_id=%@",markInformation,accout.user_id,accout.userTokenid,messageID];
    [manger connectWithUrlString:urlStr completion:^(id responedObject) {
        if ([responedObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responedObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
//                [deyailVC alertWithMessage:[dic objectForKey:@"message"]];
            }
        }
    }];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.inforArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
