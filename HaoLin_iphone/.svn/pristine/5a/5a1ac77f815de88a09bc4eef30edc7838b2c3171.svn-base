//
//  ZYPGoodsSheftViewController.m
//  HaoLin
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPGoodsSheftViewController.h"

@interface ZYPGoodsSheftViewController ()<UISearchDisplayDelegate>
{
    NSMutableArray *arr;
    NSInteger sect;
    BOOL A;
    BOOL B;
    BOOL C;
    ZYPDetailGoodsObject *goodsObject;
    
}
@property (nonatomic, strong)NSString * flag;
//  categary和sameCategary进行对比，相同则加入到当前界面否则不作处理
@property (nonatomic, strong)NSString * categary;
@property (nonatomic, strong)NSString *sameCategary;
@property (nonatomic, strong)NSMutableArray *addArray;
@property (nonatomic, strong)NSMutableArray *searchArray;
@property (nonatomic, strong)NSString *searrText;
@property (nonatomic, strong)NSString *firstl;

@end

@implementation ZYPGoodsSheftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)tap:(UITapGestureRecognizer *)tap1
{
    [self.searchBar resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    //    [self.view addGestureRecognizer:tap];
    self.firstl = @"第一次加载";
    self.titleLabel.backgroundColor = ZYPBGColor;
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
        self.tableView.frame = CGRectMake(0, 108, 320, 460);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.tableView.frame = CGRectMake(0, 108, 320, 376);
    }
    self.listArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.categaryArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.addArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.searchArray = [[NSMutableArray alloc] initWithCapacity:0];
    A = YES;
    B = YES;
    C = YES;
    self.categary = @"";
    // Do any additional setup after loading the view from its nib.
    
    //  button状态
    self.releatedBtnImageView.image = [UIImage imageNamed:@"ZYPjiantoushang.png"];
    self.overBtn.layer.cornerRadius = 5;
    self.overBtn.layer.borderWidth = 1;
    self.overBtn.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    /**
     *  设置tableView背景颜色
     */
    self.tableView.backgroundColor = BGColor;
    self.view.backgroundColor = BGColor;
    self.allBtn.backgroundColor = BGColor;
    self.allBtn.layer.borderWidth = 1;
    self.allBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //    UIImageView *iamgeView = [[UIImageView alloc] initWithFrame:self.searchBar.frame];
    //    iamgeView.backgroundColor = BGColor;
    self.searchBar.tintColor = BGColor;
    //    [self.searchBar insertSubview:iamgeView atIndex:1];
    [self.searchBar setPlaceholder:@"请输入关键字"];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    //  真实数据
    [self updataSource];
    [self getCategaryList];
}

#pragma mark - searchBar代理方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searrText = searchText;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchGoods];
    [searchBar resignFirstResponder];
}

#pragma mark - 根据分类获取分类下得商品
- (void)searchGoods
{
    //显示家在状态
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    __weak ZYPGoodsSheftViewController *sheftVC= self;
    if ([self.searrText length] > 0) {
        ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
        HSPAccount *acout = [HSPAccountTool account];
        NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&goods_name=%@",goodsList,acout.user_id,acout.userTokenid,self.searrText];
        [manger connectWithUrlStr:urlString completion:^(id responedObject) {
            if ([responedObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = responedObject;
                if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                    /**
                     *  清空原有数据
                     */
                    [sheftVC.listArray removeAllObjects];
                    NSArray *array = [dic objectForKey:@"data"];
                    for (NSDictionary *dic1 in array) {
                        ZYPDetailGoodsObject *goodsObject1 = [[ZYPDetailGoodsObject alloc] initDetailGoodsObjectWithDic:dic1];
                        [sheftVC.listArray addObject:goodsObject1];
                    }
                    //  隐藏加载状态
                    [MBProgressHUD hideAllHUDsForView:sheftVC.tableView animated:YES];
                    /**
                     *  没有检索到数据，提示
                     */
                    if (sheftVC.listArray.count == 0)
                    {
                        [sheftVC alertWithMessage:[dic objectForKey:@"message"]];
                    }
                    [sheftVC.tableView reloadData];
                }else
                {
                    /**
                     *  清空原有数据
                     */
                    [sheftVC.listArray removeAllObjects];
                    //  隐藏加载状态
                    [MBProgressHUD hideAllHUDsForView:sheftVC.tableView animated:YES];
                    [sheftVC.tableView reloadData];
                    [sheftVC alertWithMessage:[dic objectForKey:@"message"]];
                }
            }else
            {
                //  隐藏加载状态
                [MBProgressHUD hideAllHUDsForView:sheftVC.tableView animated:YES];
                [sheftVC alertWithMessage:@"加载失败,请检查网络连接"];
            }
        }];
    }
}
#pragma mark-遮罩shelftView
//  创建遮罩view
- (void)sheftView
{
    self.shelftView = [[UIView alloc] initWithFrame:CGRectMake(0, 108, 120, 120)];
    self.shelftView.layer.cornerRadius = 1;
    self.shelftView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.shelftView.layer.borderWidth = 1;
    self.shelftView.backgroundColor = [UIColor clearColor];
    self.shelftView.alpha = 1;
    [self.view addSubview:self.shelftView];
}
#pragma mark -CategarytableView
//  创建CategarytableView
- (void)createCategaryTableView
{
    self.categaryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120, 120) style:UITableViewStylePlain];
    self.categaryTableView.delegate = self;
    self.categaryTableView.backgroundColor = [UIColor whiteColor];
    self.categaryTableView.dataSource = self;
    [self.shelftView addSubview:self.categaryTableView];
    
}
#pragma mark - 创建表视图
//  表view的显现
- (IBAction)getCategarySource:(id)sender
{
    
    [self.searchBar resignFirstResponder];
    self.flag = @"请求分类数据";
    if (A == YES)
    {
        //  tableView不能滚动啦
        self.tableView.scrollEnabled = NO;
        self.releatedBtnImageView.image = [UIImage imageNamed:@"ZYPjiantouxia.png"];
        [self sheftView];
        [self createCategaryTableView];
        A = NO;
    }else if (A == NO)
    {
        //  tableView不能滚动啦
        self.tableView.scrollEnabled = YES;
        self.releatedBtnImageView.image = [UIImage imageNamed:@"ZYPjiantoushang.png"];
        self.shelftView.hidden = YES;
        self.categaryTableView.hidden = YES;
        A = YES;
    }
}
#pragma mark -获取经营范围列表
//  获取商家经营范围列表
- (void)getCategaryList
{
    __weak ZYPGoodsSheftViewController *sheftVC = self;
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *acout = [HSPAccountTool account];
    
    NSString *urlstring = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@",scopeCategary,acout.user_id,acout.userTokenid];
    [manger connectWithUrlStr:urlstring completion:^(id respondObject) {
        if ([respondObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = respondObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                NSArray *array = [dic objectForKey:@"data"];
                for (NSDictionary *dic1 in array) {
                    ZYPCategaryListObject *categary = [[ZYPCategaryListObject alloc] initWithDictionry:dic1];
                    [sheftVC.addArray addObject:categary];
                }
                if (self.addArray.count > 0)
                {
                    ZYPCategaryListObject *object = [self.addArray objectAtIndex:0];
                    self.sameCategary = object.cat_id;
                }
                [sheftVC.categaryArray addObjectsFromArray:sheftVC.addArray];
                NSDictionary *costomDic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"cat_id",@"",@"cat_pid",@"全部",@"cat_name",@"",@"child", nil];
                ZYPCategaryListObject *custome = [[ZYPCategaryListObject alloc] initWithDictionry:costomDic];
                [sheftVC.categaryArray insertObject:custome atIndex:0];
            }else
            {
                //                //  隐藏加载状态
                //                [MBProgressHUD hideAllHUDsForView:sheftVC.tableView animated:YES];
                [sheftVC alertWithMessage:[dic objectForKey:@"message"]];
            }
        }else
        {
            //            //  隐藏加载状态
            //            [MBProgressHUD hideAllHUDsForView:sheftVC.tableView animated:YES];
            [sheftVC alertWithMessage:@"加载失败,请检查网络连接"];
        }
    }];
}
//  上拉加载，下拉刷新
//  返回按钮
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - shelftView1 遮罩视图2
//  遮罩视图2
- (void)getView
{
    if (IS_IPHONE_5) {
        self.shelftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 504)];
    }else
    {
        self.shelftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 416)];
    }
    self.shelftView1.backgroundColor = [UIColor grayColor];
    self.shelftView1.alpha = 0.9;
    [self.view addSubview:self.shelftView1];
}
#pragma mark - creatDetaiView
//  创建添加界面视图
- (void)creatDetaiView
{
    self.detailView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPAddDetailView" owner:self options:nil] lastObject];
    self.detailView.sheftView = self.shelftView1;
    ZYPCategaryListObject *zyp = [self.addArray objectAtIndex:0];
    self.detailView.listObject = zyp;
    self.detailView.goodsSheftVC = self;
    self.detailView.addView = self.shelftView1;
    self.detailView.frame = CGRectMake(40, 60, 240, 200);
    self.detailView.backgroundColor = [UIColor whiteColor];
    self.detailView.flag = @"2";
    [self.detailView.allCategaryBtn setTitle:[NSString stringWithFormat:@"%@",zyp.cat_name] forState:UIControlStateNormal];
    [self.shelftView1 addSubview:self.detailView];
}
#pragma mark - overBtn 事件
//  添加商品按钮
- (IBAction)over:(id)sender
{
    /**
     *  隐藏遮罩
     */
    self.shelftView.hidden = YES;
    self.categaryTableView.hidden = YES;
    self.tableView.scrollEnabled = YES;
    self.shelftView1.hidden = YES;
    [self.detailView removeFromSuperview];
    A = YES;
    /**
     *  searchBar 取消响应
     */
    [self.searchBar resignFirstResponder];
    /**
     *  添加遮罩2
     */
    [self getView];
    [self creatDetaiView];
    self.overBtn.enabled = NO;
}
#pragma mark - addtableView
//  重用创建addtableView
- (void)createCategaryTableViewL
{
    self.addTableView = [[UITableView alloc] initWithFrame:CGRectMake(96, 41, 100, 132) style:UITableViewStylePlain];
    self.addTableView.layer.cornerRadius = 1;
    self.addTableView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.addTableView.layer.borderWidth = 1;
    self.addTableView.delegate = self;
    self.addTableView.dataSource = self;
    self.addTableView.backgroundColor = [UIColor clearColor];
    [self.detailView addSubview:self.addTableView];
    [self.addTableView reloadData];
}
#pragma mark -createListView
//  创建表View
- (void)createListView
{
    if (B == YES) {
        if (C == YES) {
            [self createCategaryTableViewL];
        }else
        {
            self.addTableView.hidden = NO;
        }
        B = NO;
    }else if (B == NO)
    {
        self.addTableView.hidden = YES;
        B = YES;
    }
}
#pragma mark - 遮罩2
//  遮罩视图2
- (void)getView2
{
    self.shelftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 504)];
    self.shelftView1.backgroundColor = [UIColor grayColor];
    self.shelftView1.alpha = 0.9;
    [self.view addSubview:self.shelftView1];
}
#pragma mark - 创建添加界面视图
//  创建添加界面视图
- (void)creatDetaiView2
{
    self.detailView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPAddDetailView" owner:self options:nil] lastObject];
    self.detailView.goodsSheftVC = self;
    self.detailView.addView = self.shelftView1;
    self.detailView.categaryLabel.text = @"修改商品:";
    self.detailView.goodsPriceText.text = goodsObject.goods_price;
    self.detailView.goodsNameText.text = goodsObject.goods_name;
    self.detailView.allCategaryBtn.titleLabel.text = @"";
    self.detailView.allCategaryBtn.enabled = NO;
    self.detailView.frame = CGRectMake(40, 100, 240, 200);
    self.detailView.backgroundColor = [UIColor whiteColor];
    [self.shelftView1 addSubview:self.detailView];
}

#pragma mark - 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return self.listArray.count;
    }else if (tableView == self.categaryTableView)
    {
        return self.categaryArray.count;
    }else if (tableView == self.addTableView)
    {
        return self.addArray.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (tableView == self.tableView)
        {
            return 40;
        }
        return 0;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *customeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 40)];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"商品名";
        [customeView addSubview:label];
        
        
        UILabel *labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 100, 40)];
        labelPrice.textAlignment = NSTextAlignmentRight;
        labelPrice.text = @"商品价格";
        [customeView addSubview:labelPrice];
        return customeView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {
        return 44.0;
    }else if (tableView == self.categaryTableView)
    {
        return 44.0;
    }else if(tableView == self.addTableView)
    {
        return 44;
    }
    return 0;
}
//  tableViewCell 定制方式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categaryTableView)
    {
        static NSString *indentifie = @"indentifie";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:indentifie];
        if (cell1 == nil)
        {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifie];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        if (tableView == self.categaryTableView)
        {
            cell1.backgroundColor = [UIColor whiteColor];
            ZYPCategaryListObject *object = [self.categaryArray objectAtIndex:indexPath.row];
            cell1.detailTextLabel.text = @">";
            cell1.textLabel.text = object.cat_name;
            return cell1;
        }
        //        else if (tableView == self.addTableView)
        //        {
        //            ZYPCategaryListObject *object = [self.addArray objectAtIndex:indexPath.row];
        //            cell1.textLabel.text = object.cat_name;
        //            return cell1;
        //        }
    }else if (tableView == self.tableView)
    {
        static NSString *indentifier = @"indentifier";
        ZYPDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPDetailCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ZYPDetailGoodsObject *detailObject = [self.listArray objectAtIndex:indexPath.row];
        cell.nameLabel.text = detailObject.goods_name;
        cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",detailObject.goods_price];
        return cell;
    }else if (tableView == self.addTableView)
    {
        static NSString *indentifier = @"indentifier";
        ZYPAddBusinessCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPAddBusinessCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ZYPCategaryListObject *object = [self.addArray objectAtIndex:indexPath.row];
        cell.categaryBtn.tag = indexPath.row;
        cell.categaryBtn.titleLabel.textColor = [UIColor orangeColor];
        [cell.categaryBtn setTitle:object.cat_name forState:UIControlStateNormal];
        [cell.categaryBtn addTarget:self action:@selector(addCategaryName:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}
- (void)addCategaryName:(UIButton *)btn
{
    ZYPCategaryListObject *object = [self.addArray objectAtIndex:btn.tag];
    self.addTableView.hidden = YES;
    self.sameCategary = object.cat_id;
    [self.detailView.allCategaryBtn setTitle:[NSString stringWithFormat:@"%@",object.cat_name] forState:UIControlStateNormal];
    B = YES;
    self.detailView.listObject = object;
    self.detailView.flag = @"2";
}
//  点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {
        //  将某一商品传的detailView里面进行操作
        goodsObject = [self.listArray objectAtIndex:indexPath.row];
        [self getView2];
        [self creatDetaiView2];
        self.detailView.sheftView = self.shelftView1;
        [self.searchBar resignFirstResponder];
        self.detailView.detailObject = goodsObject;
        self.detailView.flag = @"1";//  用来标记是添加还是编辑商品
    }else if(tableView == self.categaryTableView)
    {
        //  tableView不能滚动啦
        self.tableView.scrollEnabled = YES;
        //  btn切换图片
        self.releatedBtnImageView.image = [UIImage imageNamed:@"ZYPjiantoushang.png"];
        A = YES;
        
        ZYPCategaryListObject *objectList = [self.categaryArray objectAtIndex:indexPath.row];
        //  btn上添加显示的分类
        [self.allBtn setTitle:[NSString stringWithFormat:@"%@",objectList.cat_name] forState:UIControlStateNormal];
        self.categary = objectList.cat_id;
        //  请求数据，并且刷新tableView
        [self getjutiSource:objectList];
    }
    //    else if (tableView == self.addTableView)
    //    {
    //        ZYPCategaryListObject *object = [self.addArray objectAtIndex:indexPath.row];
    //        NSLog(@"添加商品");
    //        self.addTableView.hidden = YES;
    //        self.sameCategary = object.cat_id;
    //        [self.detailView.allCategaryBtn setTitle:[NSString stringWithFormat:@"%@",object.cat_name] forState:UIControlStateNormal];
    //        B = YES;
    //        self.detailView.listObject = object;
    //        self.detailView.flag = @"2";
    //    }
}
//  获取具体分类资源
- (void)getjutiSource:(ZYPCategaryListObject *)objectList
{
    //  显示加载状态
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak ZYPGoodsSheftViewController *sheftVC= self;
    [self.listArray removeAllObjects];
    HSPAccount *acout = [HSPAccountTool account];
    
    NSString *urlString;
    if ([objectList.cat_id isEqualToString:@""]) {
        urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@",goodsList,acout.user_id,acout.userTokenid];
    }else
    {
        urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&cat_id=%@",goodsList,acout.user_id,acout.userTokenid,objectList.cat_id];
    }
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         if ([respondObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *dic = respondObject;
             if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                 NSArray *array = [dic objectForKey:@"data"];
                 for (NSDictionary *dic1 in array) {
                     ZYPDetailGoodsObject *detailObject = [[ZYPDetailGoodsObject alloc] initDetailGoodsObjectWithDic:dic1];
                     [sheftVC.listArray addObject:detailObject];
                 }
                 //  如果有数据就刷新，将遮罩隐藏掉
                 sheftVC.shelftView.hidden = YES;
                 sheftVC.detailView.hidden = YES;
                 A = YES;
                 if (sheftVC.listArray.count == 0) {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"暂无商品" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alert show];
                 }
                 //  隐藏家在状态
                 [MBProgressHUD hideAllHUDsForView:sheftVC.view animated:YES];
                 [sheftVC.tableView reloadData];
                 
             }else
             {
                 //  如果有数据就刷新，将遮罩隐藏掉
                 sheftVC.shelftView.hidden = YES;
                 sheftVC.detailView.hidden = YES;
                 //  隐藏家在状态
                 [MBProgressHUD hideAllHUDsForView:sheftVC.view animated:YES];
                 [sheftVC alertWithMessage:[dic objectForKey:@"message"]];
                 [sheftVC.tableView reloadData];
             }
         }else
         {
             //  如果有数据就刷新，将遮罩隐藏掉
             sheftVC.shelftView.hidden = YES;
             sheftVC.detailView.hidden = YES;
             
             //  隐藏家在状态
             [MBProgressHUD hideAllHUDsForView:sheftVC.view animated:YES];
             [sheftVC.tableView reloadData];
             [sheftVC alertWithMessage:@"加载失败,请检查网络连接"];
         }
     }];
}
//  添加完成后更新数据
- (void)updataTableView
{
    if ([self.categary isEqualToString:self.sameCategary] || [self.categary isEqualToString:@""])
    {
        [self updataSource];
    }else
    {
        self.shelftView1.hidden = YES;
        self.detailView.hidden = YES;
        A = YES;
    }
}
//  请求更新数据
- (void)updataSource
{
    if ([self.firstl isEqualToString:@"第一次加载"])
    {
        //  显示加载状态
        [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
        self.firstl = nil;
    }
    
    __weak ZYPGoodsSheftViewController *sheftVC = self;
    [self.listArray removeAllObjects];
    HSPAccount *acout = [HSPAccountTool account];
    NSString * urlString;
    if ([self.categary isEqualToString:@""]) {
        urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@",goodsList,acout.user_id,acout.userTokenid];
    }else
    {
        urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&cat_id=%@",goodsList,acout.user_id,acout.userTokenid,self.categary];
    }
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    [manger connectWithUrlStr:urlString completion:^(id respondObject) {
        if ([respondObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = respondObject;
            if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                NSArray *array = [dic objectForKey:@"data"];
                for (NSDictionary *dic1 in array) {
                    ZYPDetailGoodsObject *detailObject = [[ZYPDetailGoodsObject alloc] initDetailGoodsObjectWithDic:dic1];
                    [sheftVC.listArray addObject:detailObject];
                }
                //  隐藏遮罩
                sheftVC.shelftView1.hidden = YES;
                sheftVC.detailView.hidden = YES;
                A = YES;
                //  隐藏家在状态
                [MBProgressHUD hideAllHUDsForView:sheftVC.tableView animated:YES];
                [sheftVC.tableView reloadData];
            }else
            {
                //  隐藏家在状态
                [MBProgressHUD hideAllHUDsForView:sheftVC.tableView animated:YES];
                [sheftVC.tableView reloadData];
                [sheftVC alertWithMessage:[dic objectForKey:@"message"]];
            }
        }else
        {
            //  隐藏家在状态
            [MBProgressHUD hideAllHUDsForView:sheftVC.tableView animated:YES];
            [sheftVC.tableView reloadData];
            [sheftVC alertWithMessage:@"加载失败,请检查网络连接"];
        }
    }];
}
//  更新分类数据
- (void)updataCategaryTable
{
    [self updataSource];
}
//  编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        return YES;
    }else if(tableView == self.categaryTableView)
    {
        return NO;
    }else
        return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        ZYPDetailGoodsObject *detailObject = [self.listArray objectAtIndex:indexPath.row];
        [self deleteDetailGoods:detailObject];
        [self.listArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
    }
}
#pragma mark -删除商品
- (void)deleteDetailGoods:(ZYPDetailGoodsObject *)object
{
    //  显示加载状态
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    __weak ZYPGoodsSheftViewController *sheftVC = self;
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *acout = [HSPAccountTool account];
    
    NSString *urlstring = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&goods_id=%@",deleteGoods,acout.user_id,acout.userTokenid,object.goods_id];
    [manger connectWithUrlStr:urlstring completion:^(id respondObject)
     {
         if ([respondObject isKindOfClass:[NSDictionary class]])
         {
             //  隐藏家在状态
             [MBProgressHUD hideAllHUDsForView:sheftVC.tableView animated:YES];
             
             NSDictionary *dic = respondObject;
             if ([[dic objectForKey:@"code"] isEqualToString:@"0"])
             {
                 [sheftVC alertWithMessage:[dic objectForKey:@"message"]];
             }else
             {
                 [sheftVC alertWithMessage:[dic objectForKey:@"message"]];
             }
         }else
         {
             //  隐藏家在状态
             [MBProgressHUD hideAllHUDsForView:sheftVC.tableView animated:YES];
             [sheftVC alertWithMessage:@"删除失败,请检查网络连接"];
         }
         
     }];
}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
