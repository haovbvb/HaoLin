//
//  JZDSec_handViewController.m
//  HaoLin
//9977568
//  Created by Zidon on 14-9-5.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDSec_handViewController.h"

@interface JZDSec_handViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIAlertViewDelegate>
{
    JZDModuleHttpRequest *request;
    JZDDistance *distance;
    NSMutableArray *_dataArray;
    NSMutableArray *_dataId;
    NSMutableArray *_cateGrayArray;
    NSMutableArray *_cateGrayArrayId;
    NSMutableArray *mutable;
    JZDCustomAlertView *alert;
    CGRect rect;
    int page;
    BOOL serachOrNot;
}
@property (nonatomic,copy) NSString *cateGrayIdString;
@end

@implementation JZDSec_handViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.edgesForExtendedLayout=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    rect=_secSearchBar.frame;
    
    distance=[[JZDDistance alloc] init];
    _dataId=[[NSMutableArray alloc] init];
    _dataArray=[[NSMutableArray alloc] init];
    _cateGrayArray=[[NSMutableArray alloc] init];
    alert=[JZDCustomAlertView sharedInstace];
    _cateGrayArrayId=[[NSMutableArray alloc] init];
    _showMenuBtn.buttonTitleRect=CGRectMake(3, -3, 50, 30);
    _showMenuBtn.buttonImageRect=CGRectMake(53, 5, 15, 15);
    mutable=[[NSMutableArray alloc] init];
    page=1;
    [self uiconfig];
    [self reFreshConfig];
//    [self sendRequest];
}

-(void)getCateGray
{
    __weak JZDSec_handViewController *wself=self;
    [request connectionRequestUrl:GetTheCategray withJSON:^(id responeJson) {
        if (![responeJson isKindOfClass:[NSError class]]) {
            [wself addCateGray:responeJson];
        }
    }];
}

-(void)addCateGray:(NSDictionary *)dic
{
    [_cateGrayArray removeAllObjects];
    [_cateGrayArrayId removeAllObjects];
    if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
        for(NSDictionary *d in [dic objectForKey:@"data"]){
            [_cateGrayArray addObject:[d objectForKey:@"catname"]];
            [_cateGrayArrayId addObject:[d objectForKey:@"typeid"]];
        }
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:_cateGrayArray forKey:@"cate"];
        [defaults setObject:_cateGrayArrayId forKey:@"cateId"];
        [defaults synchronize];
    }else{
        [alert popAlert:[dic objectForKey:@"message"]];
    }
}

-(void)uiconfig
{
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    [self.navigationItem setRightItemWithTarget:self action:@selector(publish) image:@"JZD_pub@2x"];
#pragma mark --修改弹出列表颜色--
//    [KxMenu setTintColor:[UIColor whiteColor]];
}

-(void)publish
{
    HSPAccount *user=[HSPAccountTool account];
    if (user.userTokenid==nil) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"登录后才能发布内容" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:@"放弃", nil];
        [alertView show];
        return;
    }
    if (_secNavSegment.selectedSegmentIndex==0) {
        JZDPublishSecViewController *transfer=[[JZDPublishSecViewController alloc] initWithNibName:@"JZDPublishSecViewController" bundle:nil];
        [self.navigationController pushViewController:transfer animated:YES];
    }else{
        JZDPubTransferViewController *buy=[[JZDPubTransferViewController alloc] initWithNibName:@"JZDPubTransferViewController" bundle:nil];
        [self.navigationController pushViewController:buy animated:YES];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        HSPLoginViewController *login=[[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
        HSPNavigationController *nav=[[HSPNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

-(void)reFreshConfig
{
    [_secTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新(一进入程序就下拉刷新)
    [_secTableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_secTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
#pragma mark --拉动刷新--
-(void)headerRereshing
{
    page=1;
    if (!serachOrNot) {
        __weak JZDSec_handViewController *wself=self;
        request=[JZDModuleHttpRequest sharedInstace];
        [request connectionRequestUrl:[NSString stringWithFormat:SecList,self.secNavSegment.selectedSegmentIndex+1,@"0",1] withJSON:^(id responeJson) {
            if (![responeJson isKindOfClass:[NSError class]]) {
                [_dataArray removeAllObjects];
                [_dataId removeAllObjects];
                [wself addData:responeJson];
            }else{
                [_secTableView headerEndRefreshing];
                [alert popAlert:@"请检查您的网络"];
            }
        }];
    }else{
        if (!_cateGrayIdString) {
            _cateGrayIdString=@"";
        }
        __weak JZDSec_handViewController *wself=self;
        NSDictionary *dic=@{@"categoryType":_cateGrayIdString,@"q":_secSearchBar.text,@"type":[NSString stringWithFormat:@"%d",_secNavSegment.selectedSegmentIndex+1]};
        [request connectionREquesturl:[NSString stringWithFormat:searchSecGoods,1] withPostDatas:dic withDelegate:nil withBackBlock:^(id backDictionary, NSError *error) {
            [_dataArray removeAllObjects];
            [_dataId removeAllObjects];
            [wself addData:backDictionary];
        }];
    }
    [self endRereshing];
    [self getCateGray];
}

-(void)footerRereshing
{
    page++;
    if (!serachOrNot) {
        __weak JZDSec_handViewController *wself=self;
        request=[JZDModuleHttpRequest sharedInstace];
        [request connectionRequestUrl:[NSString stringWithFormat:SecList,self.secNavSegment.selectedSegmentIndex+1,@"0",page] withJSON:^(id responeJson) {
            [wself addData:responeJson];
            [wself endRereshing];
        }];
    }else{
        if (!_cateGrayIdString) {
            _cateGrayIdString=@"";
        }
        __weak JZDSec_handViewController *wself=self;
        NSDictionary *dic=@{@"categoryType":_cateGrayIdString,@"q":_secSearchBar.text,@"type":[NSString stringWithFormat:@"%d",_secNavSegment.selectedSegmentIndex+1]};
        [request connectionREquesturl:[NSString stringWithFormat:searchSecGoods,page] withPostDatas:dic withDelegate:nil withBackBlock:^(id backDictionary, NSError *error) {
            [wself addData:backDictionary];
        }];
    }
    [self endRereshing];
}

-(void)endRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_secTableView reloadData];
    });
}

-(void)addData:(id)dict
{
//    YYLog(@"%@",dict);
    if (![dict isKindOfClass:[NSError class]]) {
        if ([[dict objectForKey:@"code"] isEqualToString:@"0"]) {
            NSArray *array=[dict valueForKeyPath:@"data"];
            if (array.count) {
                for(NSDictionary *dic in array){
                    JZDItem *item=[[JZDItem alloc] init];
                    [item setValuesForKeysWithDictionary:dic];
                    __weak JZDItem *witem=item;
                    [request getImageUrl:[dic objectForKey:@"headurl"] withImage:^(UIImage *img) {
                        witem.headImage=img;
                        [_secTableView reloadData];
                    }];
//                    item.headImageUrl=[dic objectForKey:@"headurl"];
//                    if ([[dic objectForKey:@"used_jindu"] isEqualToString:NoWay]) {
//                        item.disTance=1.0;
//                    }else{
                    item.disTance=[distance jingdu:[dic objectForKey:@"used_jindu"] withWeidu:[dic objectForKey:@"used_weidu"]];
//                    }
                    [_dataArray addObject:item];
                    [_dataId addObject:[dic objectForKey:@"id"]];
                    [_secTableView reloadData];
                }
            }else{
                [_secTableView reloadData];
                [alert popAlert:@"无数据"];
            }
        }else{
            [alert popAlert:[dict objectForKey:@"message"]];
        }
    }else{
        [_dataArray removeAllObjects];
        [_dataId removeAllObjects];
        [_secTableView reloadData];
        [alert popAlert:@"请检查您的网络"];
    }
//    [_secTableView reloadData];
    [_secTableView headerEndRefreshing];
    [_secTableView footerEndRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _secNavSegment.frame=CGRectMake(70, 6, 180, 30);
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:_secNavSegment];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_secNavSegment removeFromSuperview];
}
#pragma mark --searchBarDelegate--
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    serachOrNot=YES;
    if (!_cateGrayIdString) {
        _cateGrayIdString=@"";
    }
    [searchBar resignFirstResponder];
    __weak JZDSec_handViewController *wself=self;
    NSDictionary *dic=@{@"categoryType":_cateGrayIdString,@"q":_secSearchBar.text,@"type":[NSString stringWithFormat:@"%d",_secNavSegment.selectedSegmentIndex+1]};
    [request connectionREquesturl:[NSString stringWithFormat:searchSecGoods,1] withPostDatas:dic withDelegate:nil withBackBlock:^(id backDictionary, NSError *error) {
        [_dataArray removeAllObjects];
        [_dataId removeAllObjects];
        [wself addData:backDictionary];
    }];
}
#pragma mark --tableViewDelegate&tableViewDataSource---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"cell";
    SecListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SecListTableViewCell" owner:self options:nil] lastObject];
    }
    cell.item=[_dataArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZDSec_detailViewController *detail=[[JZDSec_detailViewController alloc] initWithNibName:@"JZDSec_detailViewController" bundle:nil];
    detail.detailId=[_dataId objectAtIndex:indexPath.row];
    detail.farwaryDouble=[[_dataArray objectAtIndex:indexPath.row] disTance];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark --切换转让与求购--
- (IBAction)secNavSegment:(UISegmentedControl *)sender {
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [MBProgressHUD showHUDAddedTo:win animated:YES];
    
    __weak JZDSec_handViewController *wself=self;
    if (sender.selectedSegmentIndex==1) {
        _showMenuBtn.hidden=YES;
        _secSearchBar.frame=CGRectMake(10, 8, 305, 30);
        [request connectionRequestUrl:[NSString stringWithFormat:SecList,2,@"0",1] withJSON:^(id responeJson) {
            [_dataArray removeAllObjects];
            [_dataId removeAllObjects];
            [wself addData:responeJson];
            [MBProgressHUD hideHUDForView:win animated:YES];
        }];
    }else{
        _showMenuBtn.hidden=NO;
        _secSearchBar.frame=rect;
        [request connectionRequestUrl:[NSString stringWithFormat:SecList,1,@"0",1] withJSON:^(id responeJson) {
            [_dataArray removeAllObjects];
            [_dataId removeAllObjects];
            [wself addData:responeJson];
            [MBProgressHUD hideHUDForView:win animated:YES];
        }];
    }
}

- (IBAction)showMenu:(UIButton *)sender {
    if (!_cateGrayArray.count) {
        [alert popAlert:@"数据还没有加载完成或没有数据"];
        return;
    }
    [mutable removeAllObjects];
    [_cateGrayArray addObject:@"全部"];
    KxMenuItem *item;
    for(NSString *s in _cateGrayArray){
        item = [KxMenuItem menuItem:s image:nil target:self action:@selector(selectItm:)];
//        item.foreColor=[UIColor blackColor];
        [mutable addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:sender.frame menuItems:mutable];
    [_cateGrayArray removeLastObject];
}
#pragma mark --根据类别搜索---
-(void)selectItm:(KxMenuItem *)item
{
    [_showMenuBtn setTitle:item.title forState:UIControlStateNormal];
    if ([item.title isEqualToString:@"全部"]) {
        serachOrNot=NO;
        __weak JZDSec_handViewController *wself=self;
        request=[JZDModuleHttpRequest sharedInstace];
        [request connectionRequestUrl:[NSString stringWithFormat:SecList,self.secNavSegment.selectedSegmentIndex+1,@"0",1] withJSON:^(id responeJson) {
            [_dataArray removeAllObjects];
            [_dataId removeAllObjects];
            [wself addData:responeJson];
        }];
        [self endRereshing];
        return;
    }
    serachOrNot=YES;
    __weak JZDSec_handViewController *wself=self;
    for(int i=0;i<_cateGrayArray.count;i++){
        if ([item isEqual:[mutable objectAtIndex:i]]) {
            _cateGrayIdString=_cateGrayArrayId[i];
            NSDictionary *dic=@{@"categoryType":_cateGrayIdString,@"q":_secSearchBar.text,@"type":[NSString stringWithFormat:@"%d",_secNavSegment.selectedSegmentIndex+1]};
            [request connectionREquesturl:[NSString stringWithFormat:searchSecGoods,1] withPostDatas:dic withDelegate:nil withBackBlock:^(id backDictionary, NSError *error) {
                if (!error) {
                    [_dataArray removeAllObjects];
                    [_dataId removeAllObjects];
                    [wself addData:backDictionary];
                }
            }];
        }
    }
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
