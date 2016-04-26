//
//  ZYPScopeVC.h
//  HaoLin
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BMKGeoCodeResult;
@class CLLocation;
@interface ZYPScopeVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSString *shopAddress;
@property (nonatomic, strong)NSString *shopName;
@property (nonatomic, strong)NSString *categary;
@property (nonatomic, strong)NSMutableArray *imagesArr;
@property (nonatomic, strong)CLLocation * result;
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)BMKGeoCodeResult *coord;

- (void)caculuteCount:(NSInteger)count but:(UIButton*)btn;

@end
