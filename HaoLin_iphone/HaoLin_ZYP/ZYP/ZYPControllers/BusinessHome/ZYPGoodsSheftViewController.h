//
//  ZYPGoodsSheftViewController.h
//  HaoLin
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYPAddDetailView;
//@class ZYPDetailGoodsObject;
@interface ZYPGoodsSheftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong)NSMutableArray *listArray;
@property (nonatomic, strong)NSMutableArray *categaryArray;
@property (nonatomic, strong)UITableView *categaryTableView;
@property (nonatomic, strong)UITableView *addTableView;
@property (nonatomic, strong)UIView *shelftView;
@property (nonatomic, strong)UIView *shelftView1;
@property (nonatomic, strong)ZYPAddDetailView *detailView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *overBtn;
@property (nonatomic, strong)UIView *shadeView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIImageView *releatedBtnImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


- (void)createListView;
- (void)updataTableView;
- (void)updataCategaryTable;

@end
